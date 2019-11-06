%%%%%%%%%%%%%%%%%%%%%%%%%%%%Contrast Limit ADAPTIVE HISTOGRAM EQUALIZATION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[X, MAP] = imread('scene00001.png');
%RGB = ind2rgb(X,MAP);
clc;
clear all;
close all;

D = '../Dataset/Part A/';
%D = '../Dataset/Part B/';
% S = fullfile(pwd, D, 'IMG_1.png');
S = fullfile(pwd, D, 'IMG_2.png');
% S = fullfile(pwd, D, 'IMG_3.png');
% S = fullfile(pwd, D, 'IMG_4.png');
% S = fullfile(pwd, D, 'IMG_5.png');
% S = fullfile(pwd, D, 'IMG_6.png');
% S = fullfile(pwd, D, 'IMG_7.png');
% S = fullfile(pwd, D, 'IMG_8.png');
% S = fullfile(pwd, D, 'IMG_9.png');

im = imread(S);
LAB = rgb2lab(im);
L = LAB(:,:,1)/100;
L = adapthisteq(L,'NumTiles',[720 50],'ClipLimit',0.005);
LAB(:,:,1) = L*100;
J_720 = lab2rgb(LAB);
% figure;imshow(J_720)
% title('Contrast Enhanced Image-(720 50)')

% LAB = rgb2lab(im);
% L = LAB(:,:,1)/100;
% L = adapthisteq(L,'NumTiles',[250 50],'ClipLimit',0.005);
% LAB(:,:,1) = L*100;
% J_250 = lab2rgb(LAB);
% figure;imshow(J_250)
% imshowpair(im,J,'montage')
% title('Contrast Enhanced Image-(250 50)')

brisque_orig_img = round(brisque(im), 4);
brisque_adapthist = round(brisque(J_720), 4);

niqe_orig_img = round(niqe(im), 4);
niqe_adapthist = round(niqe(J_720), 4);

piqe_orig_img = round(piqe(im), 4);
piqe_adapthist = round(piqe(J_720), 4);
