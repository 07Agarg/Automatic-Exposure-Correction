%Adaptive Gamma Transformation: Prior Works
%source: https://arxiv.org/ftp/arxiv/papers/1709/1709.04427.pdf

%Efficient Contrast Enhancement Using Adaptive Gamma Correction With Weighting Distribution
%source: https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=6336819

clc;
clear all;
close all;

D = '../Dataset/Part A/';
S = fullfile(pwd, D, 'IMG_1.png');

x=double(imread(S)); % input image
xr = x(:,:,1);
xg = x(:,:,2);
xb = x(:,:,3);
imshow(uint8(x)), title('Original Image');

alpha = 2;
yr = weighted_adapt_gamma_transform(xr, alpha); 
yg = weighted_adapt_gamma_transform(xg, alpha);
yb = weighted_adapt_gamma_transform(xb, alpha);

y = cat(3,uint8(yr),uint8(yg),uint8(yb));
figure; imshow(uint8(y)), title('Weighted Adaptive Gamma Transformed Image');

brisque_originalimg = brisque(uint8(x));
brisque_yfinal = brisque(uint8(y));

function y = weighted_adapt_gamma_transform(x, alpha)
    l_max = 255;
    [M,N]=size(x); % get size of image
    total_pixels = M*N;
    
    for i=0:255
       PDF1(i+1)=sum(sum(x==i))/total_pixels; %hist of input image
    end

    p_max = max(PDF1);
    p_min = min(PDF1);
    
    %weighting dist fn to smooth primary hist
    for i=0:255
        PDF2(i+1) = p_max * (((PDF1(i+1)-p_min)/(p_max-p_min))^alpha);
    end
    
    %normalize prob
    PDF3 = PDF2/sum(PDF2);
   
    PDF = PDF3;
    y=x; 
    for i=0:255
       I = find(x==i); %index of pixels in input image with value ‘i’
       CDF = sum(PDF(1:i));
       gamma = 1 - CDF;
       y(I) = round(l_max*((i/l_max)^gamma)); 
    end
end