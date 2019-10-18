clc;
clear all;
close all;
img_name = 'scene00201.png';
img_index = 00001;
im = imread(img_name);
figure; imshow(im)

hist_eq = histeq(im);
figure; imshow(hist_eq)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%ADAPTIVE HISTOGRAM EQUALIZATION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[X, MAP] = imread('scene00001.png');
%RGB = ind2rgb(X,MAP);
LAB = rgb2lab(im);
L = LAB(:,:,1)/100;
L = adapthisteq(L,'NumTiles',[720 50],'ClipLimit',0.005);
LAB(:,:,1) = L*100;
J_720 = lab2rgb(LAB);
figure;imshow(J_720)
%imshowpair(im,J,'montage')
title('Contrast Enhanced Image-(720 50)')

LAB = rgb2lab(im);
L = LAB(:,:,1)/100;
L = adapthisteq(L,'NumTiles',[250 50],'ClipLimit',0.005);
LAB(:,:,1) = L*100;
J_250 = lab2rgb(LAB);
figure;imshow(J_250)
%imshowpair(im,J,'montage')
title('Contrast Enhanced Image-(250 50)')


brisque_original = brisque(im)
brisque_hist = brisque(hist_eq)
brisque_adapthist_720 = brisque(J_720)
brisque_adapthist_250 = brisque(J_250)

