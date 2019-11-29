%Adaptive Gamma Transformation: Prior Works
%source: https://arxiv.org/ftp/arxiv/papers/1709/1709.04427.pdf

%Efficient Contrast Enhancement Using Adaptive Gamma Correction With Weighting Distribution
%source: https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=6336819

clc;
clear all;
close all;

% D = '../Dataset/Part A/';
D = '../Dataset/Part B/';
S = fullfile(pwd, D, 'IMG_1.png');
% S = fullfile(pwd, D, 'IMG_2.png');
% S = fullfile(pwd, D, 'IMG_3.png');
% S = fullfile(pwd, D, 'IMG_4.png');
% S = fullfile(pwd, D, 'IMG_5.png');
% S = fullfile(pwd, D, 'IMG_6.png');
% S = fullfile(pwd, D, 'IMG_7.png');
% S = fullfile(pwd, D, 'IMG_8.png');
% S = fullfile(pwd, D, 'IMG_9.png');

im=imread(S); % input image
hsv_x = rgb2hsv(im);
% xr = x(:,:,1);
% xg = x(:,:,2);
% xb = x(:,:,3);
figure; imshow(im), title('Original Image');

alpha = 0.5;
hsv_y = weighted_adapt_gamma_transform(uint8(hsv_x(:, :, 3)*255), alpha); 
i_new = double(hsv_y)/255.0;
hsv_x(:,:,3) = i_new;
y = hsv2rgb(hsv_x);
% yr = weighted_adapt_gamma_transform(xr, alpha); 
% yg = weighted_adapt_gamma_transform(xg, alpha);
% yb = weighted_adapt_gamma_transform(xb, alpha);
% 
% y = uint8(cat(3,uint8(yr),uint8(yg),uint8(yb)));
figure; imshow(y), title('Weighted Adaptive Gamma Transformed Image');

brisque_orig_img = round(brisque(im), 4);
brisque_wadaptgamma = round(brisque(y), 4);
% 
% niqe_orig_img = round(niqe(im), 4);
% niqe_wadaptgamma = round(niqe(y), 4);
% 
% piqe_orig_img = round(piqe(im), 4);
% piqe_wadaptgamma = round(piqe(y), 4);

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