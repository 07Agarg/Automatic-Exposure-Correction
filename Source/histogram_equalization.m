%%%%%%%%%%%%%%%%%%%%%%%%%%%%HISTOGRAM EQUALIZATION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear all;
close all;

D = '../Dataset/Part A/';
% D = '../Dataset/Part B/';
S = fullfile(pwd, D, 'IMG_5.png');
% S = fullfile(pwd, D, 'IMG_2.png');
% S = fullfile(pwd, D, 'IMG_3.png');
% S = fullfile(pwd, D, 'IMG_4.png');
% S = fullfile(pwd, D, 'IMG_5.png');
% S = fullfile(pwd, D, 'IMG_6.png');
% S = fullfile(pwd, D, 'IMG_7.png');
% S = fullfile(pwd, D, 'IMG_8.png');
% S = fullfile(pwd, D, 'IMG_9.png');
% S = fullfile(pwd, D, 'IMG_10.png');
im = imread(S);
figure; imshow(im), title('Original Image ');

%convert to hsv equivalent image
hsv_im = rgb2hsv(im);   
%im = hsv_im(:, :, 3);
%figure; imshow(uint8(im*255)), title('Im Image ');

%class(im)
a = hsv_im(:, :, 3);
hist_hsv = histeq(hsv_im(:, :, 3));

hsv_im(:,:,3) = hist_hsv;
hist_eq = hsv2rgb(hsv_im);
figure; imshow(hist_eq), title('Histogram Equalised Image ');
% 
% figure; imhist(im);
% figure; imhist(hist_eq);

brisque_orig_img = round(brisque(im), 4);
brisque_histeq = round(brisque(hist_eq), 4);

niqe_orig_img = round(niqe(im), 4);
niqe_histeq = round(niqe(hist_eq), 4);

% piqe_orig_img = piqe(im);
% piqe_histeq = piqe(hist_eq);