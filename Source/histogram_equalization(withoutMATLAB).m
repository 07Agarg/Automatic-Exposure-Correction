% % Histogram equalization
% %function y=histeq(x)
% x=double(imread('scene00201.png')); % input image
% [M,N]=size(x); % get size of image
% h = zeros(1, 258);
% for i=0:255
%     h(i+1)=sum(sum(x==i)); %hist of input image
% end
% % compute hist equalization
% y=x; % initialize output image
% s=sum(h); % Total number of pixels
% for i=0:255
%     I=find(x==i); %index of pixels in input image with value ‘i’
%     y(I)=round((sum(h(1:i))/s)*255); %(L-1)*CDF
% end

clc;
clear all;
close all;

% Histogram equalization
%function y=histeq(x)
x=double(imread('cameraman.tif')); % input image
imshow(uint8(x))

[M,N]=size(x); % get size of image
total_pixels = M*N;

for i=0:255
   PDF(i+1)=sum(sum(x==i))/total_pixels; %hist of input image
end

% compute hist equalization
y=x; % initialize output image
for i=0:255
   I=find(x==i); %index of pixels in input image with value ‘i’
   CDF = sum(PDF(1:i));
   y(I)=round(CDF*255); %(L-1)*CDF
end
figure; imshow(uint8(y))