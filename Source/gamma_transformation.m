clc;
clear all;
close all;

D = '../Dataset/Part A/';
S = fullfile(pwd, D, 'IMG_9.jpg');
im = imread(S);
figure; imshow(im)

%gray_i = grb2gray(im);
im_gamma = imadjust(im, [], [], 1.5);
figure, imshow(im_gamma)

LAB = rgb2lab(im_gamma);
L = LAB(:,:,1)/100;
L = adapthisteq(L,'NumTiles',[720 50],'ClipLimit',0.005);
LAB(:,:,1) = L*100;
J_720 = lab2rgb(LAB);
figure;imshow(J_720)
%imshowpair(im,J,'montage')
title('Contrast Enhanced Image-(720 50)')

LAB = rgb2lab(im_gamma);
L = LAB(:,:,1)/100;
L = adapthisteq(L,'NumTiles',[250 50],'ClipLimit',0.005);
LAB(:,:,1) = L*100;
J_250 = lab2rgb(LAB);
figure;imshow(J_250)
%imshowpair(im,J,'montage')
title('Contrast Enhanced Image-(250 50)')