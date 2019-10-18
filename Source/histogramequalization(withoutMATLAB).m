% Histogram equalization
%function y=histeq(x)
x=double(imread('scene00201.png')); % input image
[M,N]=size(x); % get size of image
h = zeros(1, 258);
for i=0:255
    h(i+1)=sum(sum(x==i)); %hist of input image
end
% compute hist equalization
y=x; % initialize output image
s=sum(h); % Total number of pixels
for i=0:255
    I=find(x==i); %index of pixels in input image with value ‘i’
    y(I)=round((sum(h(1:i))/s)*255); %(L-1)*CDF
end