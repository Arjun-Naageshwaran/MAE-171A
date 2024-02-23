clear;
clc;
close all;

aft = imread('airfoil_tip.jpg');
af = imread('airfoil.jpg');

af = fliplr(flipud(fliplr(flipud(af))));

figure(1)
imshow(af)
impixelinfo

% figure(2)
% imshow(aft)
% impixelinfo


in2pix_af = 1/(1095-986) ;

xoffset_af = 1097;
x_af = [986 1041 1097 1150 1208 1260 1318 1367 1425 1475 1531 1580 1640 1691 1746 1790 1855 1900 1962 2015 2073 2122 2180];
yt_af = [237 223 213 212 214 217 227 235 249 264 280 310 358 392 414 431 458 478 502 545 563 580 593];
yb_af = [261 240 224 219 222 236 253 274 300 327 360 400 427 467 509 538 579 613 644 674 701 726 745];

in2pix_aft = (1/(1530 - 1420));

xoffset_aft = 1206;
x_aft = [1092 1149 1206 1259 1313 1421 1476 1530 1579 1638 1690 1746 1793 1856 1906 1969 2020 2083 2138 2200 2260 2320 2380];
yt_aft = [154 156 168 174 202 252 291 319 349 392 431 477 521 570 616 672 713 769 809 855 897 928 956];
yb_aft = [164 167 173 182 210 260 304 330 380 435 469 520 568 625 679 741 794 858 910 970 1020 1065 1092];

%yt_aft = 1848 + yt_aft;
%yb_aft = 1848 + yb_aft;

figure(3)
imshow(aft)
hold on
plot(x_aft,yt_aft,'.r')
plot(x_aft,yb_aft,'.b')
legend('top of streamline', 'bottom of streamline')

figure(4)
plot((x_aft - xoffset_aft).*in2pix_aft, (yb_aft - yt_aft).*in2pix_aft)
title('Streamline thickess by distance with tip')
xlabel('x position (in)')
ylabel('streamline thickness (in)')
xline(0,'m')
xline(9,'r')
legend('streamline thickness', 'front of airfoil' ,'end of airfoil')

figure(5)
imshow(af)
hold on
plot(x_af,yt_af,'.r')
plot(x_af,yb_af,'.b')
legend('top of streamline', 'bottom of streamline')

figure(6)
plot((x_af - xoffset_af).*in2pix_af, (yb_af - yt_af).*in2pix_af)
title('Streamline thickess by distance without tip')
xlabel('x position (in)')
ylabel('streamline thickness (in)')
xline(0,'m')
xline(9,'r')
legend('streamline thickness', 'front of airfoil' ,'end of airfoil')

