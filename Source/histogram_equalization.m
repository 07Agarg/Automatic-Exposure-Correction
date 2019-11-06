%%%%%%%%%%%%%%%%%%%%%%%%%%%%HISTOGRAM EQUALIZATION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear all;
close all;

% D = '../Dataset/Part A/';
D = '../Dataset/Part B/';
% S = fullfile(pwd, D, 'IMG_1.png');
S = fullfile(pwd, D, 'IMG_2.png');
% S = fullfile(pwd, D, 'IMG_3.png');
% S = fullfile(pwd, D, 'IMG_4.png');
% S = fullfile(pwd, D, 'IMG_5.png');
% S = fullfile(pwd, D, 'IMG_6.png');
% S = fullfile(pwd, D, 'IMG_7.png');
% S = fullfile(pwd, D, 'IMG_8.png');
%S = fullfile(pwd, D, 'IMG_9.png');
im = imread(S);
%figure; imshow(im), title('Original Image (IMG1)');

hist_eq = histeq(im);
%figure; imshow(hist_eq), title('Corrected Image (IMG1)');

brisque_orig_img = brisque(im);
brisque_histeq = brisque(hist_eq);

niqe_orig_img = niqe(im);
niqe_histeq = niqe(hist_eq);

piqe_orig_img = piqe(im);
piqe_histeq = piqe(hist_eq);


