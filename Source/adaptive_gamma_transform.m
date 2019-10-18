%Adaptive Gamma Transformation: Prior Works
%source: https://arxiv.org/ftp/arxiv/papers/1709/1709.04427.pdf

clc;
clear all;
close all;

D = '../Dataset/Part A/';
S = fullfile(pwd, D, 'IMG_9.jpg')

x=double(imread(S)); % input image
xr = x(:,:,1);
xg = x(:,:,2);
xb = x(:,:,3);
imshow(uint8(x)), title('Original Image');

yr = adapt_gamma_transform(xr); 
yg = adapt_gamma_transform(xg);
yb = adapt_gamma_transform(xb);

y = cat(3,uint8(yr),uint8(yg),uint8(yb));
figure; imshow(uint8(y)), title('Adaptive Gamma Transformed Image')

function y = adapt_gamma_transform(x)
    l_max = 255;
    [M,N]=size(x); % get size of image
    total_pixels = M*N;
    
    for i=0:255
       PDF(i+1)=sum(sum(x==i))/total_pixels; %hist of input image
    end

    y=x; 
    for i=0:255
       I = find(x==i); %index of pixels in input image with value ‘i’
       CDF = sum(PDF(1:i));
       gamma = 1 - CDF;
       y(I) = round(l_max*((i/l_max)^gamma)); 
    end
end