clc;
close all;
clear;

%% Opening images
opn = imread('opn.jpg');

cyl = imread('cyl.jpg');

rankH = imread('rank_H.jpg');

rankF = imread('rank_F.jpg');

airfoil = imread('airfoil.jpg');

airfoil_tip = imread('airfoil_tip.jpg');

%%Flip and reorient **Might not need, double check**

opn = fliplr(flipud(fliplr(flipud(opn))));

cyl = fliplr(flipud(fliplr(flipud(cyl))));

rankH = fliplr(flipud(fliplr(flipud(rankH))));

rankF = fliplr(flipud(fliplr(flipud(rankF))));

airfoil = fliplr(flipud(fliplr(flipud(airfoil))));


%% Crop images to right size, needs to be done individually for each image

%Example
%initial crop around general area
% [h,l] = size(opn)
opn_C1 = imcrop(opn,[1200,600,2300,1000]);
cyl_C1 = imcrop(cyl,[800,80,2100,1500]);
rankH_C1 = imcrop(rankH,[0,400,2100,1100]);
rankF_C1 = imcrop(rankF,[200,500,2300,900]);
airfoil_C1 = imcrop(airfoil,[700,100,2000,1748]);
airfoil_tip_C1 = imcrop(airfoil_tip,[700,100,2000,1748]);


%Crop around streamline for binary conversion
opn_C2 = imcrop(opn,[1200,1020,2300,250]);
cyl_C2 = imcrop(cyl,[800,80,2100,200]);
rankH_C2 = imcrop(rankH,[0,1100,2100,275]);
rankF_C2 = imcrop(rankF,[200,800,2300,600]);

%Airfoil need to do several crops
% airfoil_C2 = imcrop(airfoil,[700,500,500,900]);
% airfoil_tip_C2 = imcrop(airfoil_tip,[700,300,2300,900]);
%position vectors are [x1 y1 change in x change in y]

%older 3 and 4
% pos3_af = [1500 600 500 500];
% pos4_af = [1700 1100 300 600];
% 
% pos1_af = [700 450 300 200];
% pos2_af = [1000 350 500 250];
% pos3_af = [1500 600 250 250];
% pos4_af = [1600 850 250 250];
% pos5_af = [1700 1100 250 250];


% posMat_af = [ pos1_af; pos2_af; pos3_af ;pos4_af ; pos5_af];
% 
% airfoil_C2 = imcrop(airfoil,pos1_af);
% airfoil_C3 = imcrop(airfoil,pos2_af);
% airfoil_C4 = imcrop(airfoil,pos3_af);
% airfoil_C5 = imcrop(airfoil,pos4_af);
% airfoil_C6 = imcrop(airfoil,pos5_af);
%% Open Analysis

% 
% ref = [7 45 82];
% %dist also looks interesting at 25
% dist = 25;
% 
% opn_bin = processFunc(opn_C2,ref,dist); % Binary'd the cropped picture
% 
% [row_opn,col_opn] = find(opn_bin); %find the binary one whatever it ends up being.
% 
% x_opn = 1:length(opn_bin(1,:));
% [C_opn,ia_opn,ic_opn] = unique(col_opn);
% unqrow_opn = row_opn(ia_opn);
% unqcol_opn = col_opn(ia_opn);
% 
% s_opn = spline(unqcol_opn, unqrow_opn,x_opn); % fit a spline
% s2_opn = s_opn + 490; % compensate for 2nd crop
% s_smooth_opn=smooth(s2_opn,100); % smooth the spline
% 
% figure(1)
% imshow(opn_C1)
% hold on
% plot(x_opn,s2_opn,'or')
% hold on
% plot(x_opn,s_smooth_opn,'.b')


%repeat for other ones. 
%% Cylinder Analysis
%check if the crop is good
% 
% ref = [7 30 180];
% %dist also looks interesting at 25
% dist = 85;
% 
% [centers,radii] = imfindcircles(cyl_C1,[300 600],'Sensitivity',0.991,'ObjectPolarity','dark');
% 
% cyl_bin = processFunc(cyl_C2,ref,dist);
% 
% [row_cyl,col_cyl] = find(cyl_bin); %find the binary one whatever it ends up being.
% 
% x_cyl = 1:length(cyl_bin(1,:));
% [C_cyl,ia_cyl,ic_cyl] = unique(col_cyl);
% unqrow_cyl = row_cyl(ia_cyl);
% unqcol_cyl = col_cyl(ia_cyl);
% 
% s_cyl = spline(unqcol_cyl, unqrow_cyl,x_cyl); % fit a spline
% s2_cyl = s_cyl +0; % compensate for 2nd crop
% s_smooth_cyl=smooth(s2_cyl,100); % smooth the spline
% 
% 
% 
% figure(2)
% imshow(cyl_C1)
% hold on
% viscircles(centers,radii);
% plot(centers(1),centers(2),'xr','MarkerSize',20,'LineWidth',3);
% hold on
% plot(x_cyl,s2_cyl,'or')
% hold on
% plot(x_cyl,s_smooth_cyl,'.b')
% 
% figure(3)
% imshow(cyl_bin)
% hold on
% plot(x_cyl,s_cyl,'or')
% 
% 


%% Rankine Half Analysis
%focusing on airfoil first
ref = [7 140 151];

dist = 60;


rankH_bin = processFunc(rankH_C2,ref,dist);

[row_rankH,col_rankH] = find(rankH_bin); 

x_rankH = 1:length(rankH_bin(1,:));
[C_rankH,ia_rankH,ic_rankH] = unique(col_rankH);
unqrow_rankH = row_rankH(ia_rankH);
unqcol_rankH = col_rankH(ia_rankH);

s_rankH = spline(unqcol_rankH, unqrow_rankH,x_rankH); % fit a spline
s2_rankH = s_rankH + 700; % compensate for 2nd crop
s_smooth_rankH=smooth(s2_rankH,100); % smooth the spldine

figure(6)
imshow(rankH_C1)
hold on
plot(x_rankH,s2_rankH,'or')
hold on
plot(x_rankH,s_smooth_rankH,'.b')

s_loc = [767 948];%pixels, [x y]
p2i_rh = 1/(1038-840);
i2p_rh = (1038-840);
V = 0.0173; %m/s
V = V*(25.4);
s_strength =  8; %gph
r_stag = (0.075/1000)*25.4; %in

%rankH_C1 = imcrop(rankH,[0,400,2100,1100]);

figure(7)
imshow(rankH_C1)
hold on
plot(x_rankH,s_smooth_rankH,'g', 'LineWidth',2)
hold on
plot(s_loc(1),s_loc(2) - 400,'or','MarkerSize', 20)
hold on
plot(s_loc(1) - r_stag*i2p_rh, s_loc(2) - 400,'*r','MarkerSize', 20)
legend('experimentally determined streamline','source','Mathermatically determined stagnation point')
% all units are now in in and in/s



%% Rankine Full Analysis
% rref = [7 45 82];
% %dist also looks interesting at 25
% dist = 110;
% 
% rankF_bin = processFunc(rankF_C2,ref,dist);
% 
% % image Checking
% figure(7)
% imshow(rankF_C2)
% figure(8)
% imshow(rankF_bin);
% 
% 

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