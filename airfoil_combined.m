clear;
clc;
close all;

%% Setting vars

ref1 = [7 45 82];
dist1 = 45;

ref2 = [20 126 143];
dist2 = 90;

aft = imread('airfoil_tip.jpg');
af = imread('airfoil.jpg');
af = fliplr(flipud(fliplr(flipud(af))));


af_C1 = imcrop(af,[500,350,2000,2000]);
af_C = imcrop(af,[0,0,2500,2350]);

%% airfoil analysis

pos1_af = [500 500 450 200];
pos2_af = [950 360 100 240];
pos3_af = [1050 350 250 150];
pos4_af = [1300 400 100 150];
pos5_af = [1400 480 50 120];
pos6_af = [1450 520 50 110];
pos7_af = [1500 550 60 150];
pos8_af = [1560 640 70 120];
pos9_af = [1630 700 40 120];
pos10_af = [1670 770 50 200];
pos11_af = [1720 800 50 200];
pos12_af = [1770 880 50 200];
pos13_af = [1820 920 50 200];
pos14_af = [1870 990 80 200];
pos15_af = [1920 1100 80 200];
pos16_af = [1970 1200 80 200];
pos17_af = [2020 1300 80 200];


posMat_af = [ pos1_af; pos2_af; pos3_af ;pos4_af ; pos5_af;
    pos6_af; pos7_af; pos8_af ;pos9_af ; pos10_af;
    pos11_af; pos12_af; pos13_af;pos14_af; pos15_af; pos16_af ;pos17_af];

af_bin = zeros(1504,2104);
posEditMat_af = posEdit(posMat_af);
af_bin = pos2bin(af,posMat_af,posEditMat_af,af_bin,ref1,dist1);
[row_af,col_af] = find(af_bin);

x_af = 1:length(af_bin(1,:));

figure(1)
imshow(af_bin)
[C_af,ia_af,ic_af] = unique(col_af);
unqrow_af = row_af(ia_af);
unqcol_af = col_af(ia_af);

s_af = spline(unqcol_af, unqrow_af,x_af); % fit a spline
s2_af = s_af; % compensate for 2nd crop
s_smooth_af =smooth(s2_af,100); % smooth the spldine


figure(2)
imshow(af_C1)
hold on
plot(x_af,s2_af,'or')
hold on
plot(x_af,s_smooth_af,'.b')


%% airfoil with leading edge analysis

%aft_C1 = imcrop(aft,[670,100,2000,2000]);
aft_C1 = imcrop(aft,[570,270,2000,2000]);
aft_C = imcrop(aft,[0,0,2570,2270]);

pos1_aft = [570 500 430 120];
pos2_aft = [1000 430 130 170];
pos3_aft = [1130 270 250 200];
pos4_aft = [1380 290 100 160];
pos5_aft = [1480 376 60 200];
pos6_aft = [1540 400 30 200];
pos7_aft = [1570 450 30 200];
pos8_aft = [1600 450 30 200];
pos9_aft = [1630 490 30 200];
pos10_aft = [1660 530 30 200];
pos11_aft = [1690 580 50 200];
pos12_aft = [1720 610 80 200];
pos13_aft = [1750 630 80 200];
pos14_aft = [1780 660 80 200];
pos15_aft = [1810 690 80 200];
pos16_aft = [1840 720 80 200];
pos17_aft = [1870 750 80 200];
pos18_aft = [1900 770 80 200];
pos19_aft = [1930 800 80 200];
pos20_aft = [1960 830 80 200];
pos21_aft = [1990 860 80 200];
pos22_aft = [2020 890 80 200];
pos23_aft = [2050 920 80 200];
pos24_aft = [2050 920 80 200];
pos25_aft = [2080 950 80 200];
pos26_aft = [2110 980 80 200];
pos27_aft = [2140 1010 80 200];
pos28_aft = [2140 1040 80 200];
pos29_aft = [2140 1070 80 200];
pos30_aft = [2180 1100 80 200];
pos31_aft = [2180 1130 80 200];
pos32_aft = [2180 1160 80 200];
pos33_aft = [2200 1190 80 200];
pos34_aft = [2200 1210 120 200];

posMat_aft = [ pos1_aft; pos2_aft; pos3_aft ;pos4_aft ; pos5_aft;
    pos6_aft; pos7_aft; pos8_aft ;pos9_aft ; pos10_aft;
    pos11_aft ; pos12_aft; pos13_aft; pos14_aft ; pos15_aft;pos16_aft;pos17_aft;pos18_aft;pos19_aft;
    pos20_aft;pos21_aft;pos22_aft;pos23_aft;pos24_aft;pos25_aft;pos26_aft;pos27_aft;pos28_aft;pos29_aft;pos30_aft;
    pos31_aft;pos32_aft;pos33_aft;pos34_aft];
posEdit_aft = posEdit(posMat_aft);
aft_bin = zeros(1504,2104);
aft_bin = pos2bin(aft,posMat_aft,posEdit_aft,aft_bin,ref2,dist2);
[row_aft,col_aft] = find(aft_bin);
x_aft = 1:length(aft_bin(1,:));

figure(3)
imshow(aft_bin)
[C_aft,ia_aft,ic_aft] = unique(col_aft);
unqrow_aft = row_aft(ia_aft);
unqcol_aft = col_aft(ia_aft);

s_aft = spline(unqcol_aft, unqrow_aft,x_aft); % fit a spline
s2_aft = s_aft; % compensate for 2nd crop
s_smooth_aft =smooth(s2_aft,100); % smooth the spldine


figure(4)
imshow(aft_C1)
hold on
plot(x_aft,s2_aft,'or')
hold on
plot(x_aft,s_smooth_aft,'.b')



%% streamline Comparison

p2i_af_x = 1/(576 - 463);
p2i_aft_x= 1/(703 - 590);

p2i_af_y = 1/(576 - 463);
p2i_aft_y= 1/(703 - 590);


af_x = (1549 - 577);
af_y = (1277-17);

aft_x = (1643-614);
aft_y = (1309-9);

aft2af_x = af_x/aft_x; 
af2aft_x = aft_x/af_x;

aft2af_y = af_y/aft_y;
af2aft_y = aft_y/af_y;


figure(5)
imshow(aft_C)
hold on
plot(x_af.*(af2aft_x) + 570 ,s_smooth_af.*af2aft_y - 9 + 270,'r','LineWidth',2)
hold on
plot(x_aft + 570,s_smooth_aft + 270,'g','LineWidth',2)
title('comparison of streamlines on airfoil with tip')
legend('without leading edge','with leading edge')
impixelinfo

figure(6)
imshow(af_C)
hold on
plot(x_af + 500,s_smooth_af + 350,'r','LineWidth',2)
hold on
plot(x_aft.*aft2af_x + 500,s_smooth_aft.*aft2af_y + 350,'g','LineWidth',2)
title('comparison of streamlines on normal airfoil')
legend('without leading edge','with leading edge')
impixelinfo


%normalizing to aft
figure(7)
plot(x_af*p2i_aft_x,((s_smooth_af.*af2aft_y)./s_smooth_aft).*p2i_aft_y)
xlabel('X position (in)')
ylabel('Y position (in)')
grid on;

%% boundary layer thickness analysis

x_af_bl = [1074 1092 1148 1203 1258 1312 1370 1421 1474 1527 1580 1643 1690 1743 1800 1852 1908 1962 2019 2046 2074];
yt_af_bl = [359 354 351 357 376 399 435 476 516 569 618 673 731 786 847 922 1020 1106 1199  1247 1245];
yb_af_bl = [392 371 374 393 422 455 496 537 587 631 690 747 815 881 954 1040 1142 1270 1459 1629 1640];

figure(8)
imshow(af_C)
hold on
plot(x_af_bl,yt_af_bl,'y.', 'LineWidth',2 )
hold on
plot(x_af_bl,yb_af_bl,'c.', 'LineWidth',2)
legend('top of boundary layer','bottom of boundary layer')

figure(9)
plot(x_af_bl.*p2i_af_x, yt_af_bl.*p2i_af_y)
hold on
plot(x_af_bl.*p2i_af_x, yb_af_bl.*p2i_af_y)
legend('top of boundary layer','bottom of boundary layer')
xlabel('X distance on grid (in)')
ylabel('Y position on grid (in)')
grid on
title('Boundary Layer Position of Airfoil Without Leading Edge')

x_aft_bl = [1183 1200 1253 1306 1362 1418 1474 1524 1581 1632 1686 1741 1800 1852 1910 1965 2015 2082 2132 2203 2213];
yt_aft_bl = [226 224 254 284 307 331 363 402 422 490 539 596 657 717 781 854 923 1032 1130 1260 1276];
yb_aft_bl = [301 278 282 300 322 350 382 422 464 511 569 626 690 754 819 904 989 1120 1259 1505 1575];

figure(10)
imshow(aft_C)
hold on
plot(x_aft_bl,yt_aft_bl,'y.', 'LineWidth',2 )
hold on
plot(x_aft_bl,yb_aft_bl,'c.', 'LineWidth',2)
legend('top of boundary layer','bottom of boundary layer')
impixelinfo

figure(11)
plot(x_aft_bl.*p2i_aft_x, yt_aft_bl.*p2i_aft_y)
hold on
plot(x_aft_bl.*p2i_aft_x, yb_aft_bl.*p2i_aft_y)
legend('top of boundary layer','bottom of boundary layer')
xlabel('X distance on grid (in)')
ylabel('Y position on grid (in)')
grid on
title('Boundary Layer Position of Airfoil With Leading Edge')

figure(12)
plot(x_af_bl.*p2i_af_x, (yb_af_bl.*p2i_af_y) - (yt_af_bl.*p2i_af_y))
hold on
plot(x_aft_bl.*p2i_aft_x, (yb_aft_bl.*p2i_aft_y) - (yt_aft_bl.*p2i_aft_y))
legend('top of boundary layer','bottom of boundary layer')
xlabel('X distance on grid (in)')
ylabel('Y position on grid (in)')
legend('airfoil without leading edge','airfoil with leading edge')
grid on
title('Boundary Layer Position of each airfoil')


figure(13)
plot(x_aft_bl.*p2i_aft_x, ((yb_af_bl.*p2i_af_y) - (yt_af_bl.*p2i_af_y)) - ((yb_aft_bl.*p2i_aft_y) - (yt_aft_bl.*p2i_aft_y)))
hold on
% plot(x_af_bl.*p2i_af_x, )
xlabel('X distance on grid (in)')
ylabel('Y position on grid (in)')
grid on
title('Difference in Boundary Layer Y Position')




%% Image processing Function
function [mat] = processFunc(img,ref,dist)

tempVec = [0 0 0];
tempMat = zeros(size(img,1),size(img,2)); 
for i = 1:size(img,1) 
    for j = 1:size(img,2)
        tempVec(1)=img(i,j,1);
        tempVec(2)=img(i,j,2);
        tempVec(3)=img(i,j,3);
        if norm(tempVec-ref) < dist
            % check if the color is within color distance
            tempMat(i,j)=1; % if so, set to 1
        end
    end
end
mat = tempMat;

end



%% pos array editing
function [posEditMat] = posEdit(posMat)
posEditMat = posMat;
minX = min(posEditMat(:,1));
minY = min(posEditMat(:,2));
posEditMat(:,1) = posEditMat(:,1) - minX;
posEditMat(:,2) = posEditMat(:,2) - minY;
for i = 1:length(posMat(:,1))
    if posEditMat(i,1) == 0
        posEditMat(i,1) = 1;
    end
    if posEditMat(i,2) == 0
       posEditMat(i,2) = 1; 
    end
    %output posEditMat(i) = [x1 y1 x2 y2]
    posEditMat(i,3) = posEditMat(i,1) + posEditMat(i,3);
    posEditMat(i,4) = posEditMat(i,2) + posEditMat(i,4);
end
end

%% image construction
function [outbin] = pos2bin(img,posMat,posEditmat,zeroBin,ref,dist)
    outbin = zeroBin;
    for i = 1:length(posMat(:,1))
     %Cropping
     aft_C = imcrop(img,posMat(i,:));
     %Binary Conversion
     aft_bin = processFunc(aft_C,ref,dist);
     %using position edited by posEdit
     outbin(posEditmat(i,2):posEditmat(i,4),posEditmat(i,1):posEditmat(i,3) ) = aft_bin;
    end
end