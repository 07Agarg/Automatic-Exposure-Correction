%%the above code is in one .m file  and following code is in another .m file 
clc;
close all;
clear all;
D = '../Dataset/Part B/';
S = fullfile(pwd, D, 'IMG_1.png')
a = imread(S);
%a = imread('scene00201.png');
x_red = a(:,:,1);
x_green = a(:,:,2);
x_blue = a(:,:,3);

y_red = uint8(BBHE(x_red));
y_green = uint8(BBHE(x_green));
y_blue = uint8(BBHE(x_blue));

y_final = cat(3, y_red, y_green, y_blue);
figure,imshow(a), title('Original Image');
figure, imshow(y_final), title('BBHE Colored Image');

brisque_originalimg = brisque(a);
brisque_yfinal = brisque(y_final);