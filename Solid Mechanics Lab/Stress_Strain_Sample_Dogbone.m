%% MAE 171A Solid Mechanics Lab - Stress/Strain Curve Generator For Dogbone

clearvars;clc;
%Import csv filled with force, displacement and times values
data = readmatrix('PMMA_dogbone_20240207_104834_1.csv');

%Format data, remove titles and time vales to leave only force and
%displacement
data(1:2,:) = [];
data(:,1:2) = [];

%Generate the force displacement curve of the data. Useful for
%visualization but unhelpful in creating stress strain curve
%{
figure(1)
plot(data(:,1), data(:,2))
axis([0 0.3 -10 450]);
xlabel('Displacement (in)')
ylabel('Force (lbf)')
title('Force v Displacement Graph of Tensile Test')
%}

lbf = data(:,2);                    %Force values in lbf
newton =  lbf*4.44822;              %Convert force to Newton
inch = data(:,1);                   %Displacement values in inches
avg_thickness = 0.0030133333;       %Average specimen thickness in meters
avg_width = 0.0127133333;           %Average specimen width at the ends of the dogbone in meters
area = avg_thickness*avg_width;     %Cross sectional area of the specimen in m^2
og_length = 6.496063;               %Original specimen length in inches
stress = zeros(1,length(data));
strain = zeros(1,length(data));
modulus = zeros(1,25);
MPa = 10^6;

%For loop converts force to pressure and displacement to strain
for i=1:length(data)
    stress(i) = newton(i)/(MPa*area);
    strain(i) = inch(i)/og_length; 
    for j=2:26                                  
        modulus(j) = stress(j)/(strain(j));     %Calculate Young's Modulus in linear region
    end
end

%Plot stress strain curve
figure(2)
plot(strain,stress)
axis([0 0.05 -1 55]);
xlabel('Strain')
ylabel('Stress (MPa)')
title('Stress v Strain Graph of Tensile Test')
%Extract valuable data
youngsmod = (mean(modulus)/1000)     %Gives the Young's Modulus value in GPa
Sy = stress(26)                      %Gives the yield stress value in MPa (instead of using 0.2% strain rule I found 0.5% to be better for acrylic)
Sut = max(stress)                    %Gives the ultimate tensile strength value in MPa
%}