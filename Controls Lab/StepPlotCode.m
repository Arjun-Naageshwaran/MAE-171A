%% MAE 171A Rotational (Torsional) Controls Lab - 

clearvars;clc;
%Import .txt file filled with sample number, time, encoder displancement and motor control data
data1 = readmatrix('a03_4 Contols OL\enc1 OL 1.txt');
data1(:,1:2) = [];  %Remove all but time and encoder 1 position
data1(:,2) = [];
data1(:,3:4) = [];
data2 = readmatrix('a03_4 Contols OL\enc2 OL 2.txt');
data2(:,1:2) = [];  %Remove all but time and encoder 2 position
data2(:,2:3) = [];
data2(:,3) = [];

%Plot encoder position versus time
figure(1)
plot(data1(:,1), data1(:,2))
title('Encoder 1 1DOF System')
xlabel('time (s)')
ylabel('Encoder 1 position')
xline(3, '-', {'Motor', 'Stop'})
yline(0, '--')
text(0.17, 292, '(t0, y0)')    %Label relevant values for future calculations
text(0.476, 209, '(tn, yn)')
text(2.4260, 192, 'yinf')

figure(2)
plot(data2(:,1), data2(:,2))
title('Encoder 2 1DOF System (Manual Agitation)')
xlabel('time (s)')
ylabel('Encoder 2 position')
xline(3, '-', {'Motor', 'Stop'})
yline(0, '--')
text(1.119, 527, '(t0, y0)')  %Label relevant values for future calculations
text(1.473, 427, '(tn, yn)')
text(5.985, 10, 'yinf')

%Encoder 1 variables
t01 = 0.17; y01 = 292; tn1 = 0.476; yn1 = 209; yinf1 = 192;
%Encoder 2 variables
t02 = 1.119; y02 = 527; tn2 = 1.473; yn2 = 427; yinf2 = 10;

%Generalized 2nd order transfer function resonant frequency form
%G(s) = 
%Variable extraction for encoder 1
U1 = 0.5;
n1 = 1;
wd1 = (2*pi*n1)/(tn1 - t01);
zwn1 = (1/(tn1-t01)*log((y01-yinf1)/(yn1-yinf1)));
wn1 = sqrt((wd1^2)+(zwn1^2));
z1 = zwn1/wn1;
C1 = yinf1/U1;
%Target values
k1 = 1/C1
m1 = 1/(C1*(wn1^2))
d1 = (2*z1)/(C1*wn1)

%Variables for encoder 2
k2 = k1;
C2 = 1/k2;
n2 = 1;
wd2 = (2*pi*n2)/(tn2 - t02);
zwn2 = (1/(tn2-t02)*log((y02-yinf2)/(yn2-yinf2)));
wn2 = sqrt((wd2^2)+(zwn2^2));
z2 = zwn2/wn2;
%Target values
m2 = 1/(C2*(wn2^2))
d2 = (2*z2)/(C2*wn2)
k2