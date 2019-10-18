%Adaptive Gamma Transformation: Prior Works
%source: https://arxiv.org/ftp/arxiv/papers/1709/1709.04427.pdf

clc;
clear all;
close all;

x=double(imread('kodim20.png')); % input image
xr = x(:,:,1);
xg = x(:,:,2);
xb = x(:,:,3);
imshow(uint8(x))

yr = adapt_gamma_transform(xr); 
yg = adapt_gamma_transform(xg);
yb = adapt_gamma_transform(xb);

y = cat(3,uint8(yr),uint8(yg),uint8(yb));
figure; imshow(uint8(y))

function y = adapt_gamma_transform(x)
    l_max = 255;
    %[M,N]=size(x); % get size of image
    for i=0:255
       h(i+1)=sum(sum(x==i)); %hist of input image
    end

    y=x; 
    s=sum(h); % Total number of pixels
    for i=0:255
       I = find(x==i); %index of pixels in input image with value ‘i’
       CDF = sum(h(1:i))/s;
       gamma = 1 - CDF;
       y(I) = round(l_max*((i/l_max)^gamma)); 
    end
end