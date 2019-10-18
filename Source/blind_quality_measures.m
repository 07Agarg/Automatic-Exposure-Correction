clear all
close all
clc

D = '../Dataset/Part A/';
S = fullfile(pwd, D, 'IMG_1.png');

im=double(imread(S)); % input image

figure; imshow(im);
q1 = brisque(im);
p1 = piqe(im);
n1 = niqe(im);