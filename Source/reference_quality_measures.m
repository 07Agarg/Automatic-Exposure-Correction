clear all
close all
clc

D = '../Dataset/Part A/';
S = fullfile(pwd, D, 'IMG_1.png');

I = double(imread(S));
figure; imshow(I);

Ref = double(imread(S));
figure; imhist(Ref);

B = imhistmatch(I,Ref);
figure; imshow(B);
figure; imhist(B);

psnr1 = psnr(I,Ref)
ssim1 = ssim(I,Ref)

psnr2 = psnr(B,Ref)
ssim2 = ssim(B,Ref)