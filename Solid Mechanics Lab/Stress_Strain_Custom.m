%% MAE 171A Solid Mechanics Lab - Stress/Strain Curve Generator For Custom Acrylic Cut

clearvars;clc;
%Import csv filled with force, displacement and times values
data = readmatrix('Sample 1_20240221_105820_1.csv');

%Format data, remove titles and time vales to leave only force and
%displacement
data(1:2,:) = [];
data(:,1:2) = [];

%Generate the force displacement curve of the data. Useful for
%visualization but unhelpful in creating stress strain curve
%{
figure(1)
plot(data(:,1), data(:,2))
axis([0 0.3 0 450]);
xlabel('Displacement (in)')
ylabel('Force (lbf)')
title('Force v Displacement Graph of Tensile Test')
%}

knewt = data(:,2);                  %Force values in kN
newton = 1000*data;                 %Force values converted to Newtons
mm = data(:,1);                     %Displacement values in mm
avg_thickness = 0.0030133333;       %Average specimen thickness in meters
avg_width = 0.0127133333;           %Average specimen width at the ends of the dogbone in meters
area = avg_thickness*avg_width;     %Cross sectional area of the specimen in m^2
og_length = 165;                    %Original specimen length in mm
stress = zeros(1,length(data));
strain = zeros(1,length(data));
modulus = zeros(1,25);
MPa = 10^6;

%For loop converts force to pressure and displacement to strain
for i=1:length(data)
    stress(i) = newton(i)/(MPa*area);
    strain(i) = mm(i)/og_length;
    for j=2:26                                  
        modulus(j) = stress(j)/(strain(j));     %Calculate Young's Modulus in linear region
    end
end

%Plot stress strain curve
figure(2)
plot(strain,stress)
axis([0 0.012 -1 55]);
xlabel('Strain')
ylabel('Stress (MPa)')
title('Stress v Strain Graph of Tensile Test')
%Extract valuable data

youngsmod = (mean(modulus)/1000)     %Gives the Young's Modulus value in GPa
Sy = stress(26)                      %Gives the yield stress value in MPa (instead of using 0.2% strain rule I found 0.5% to be better for acrylic)
Sut = max(stress)                    %Gives the ultimate tensile strength value in MPa
%}