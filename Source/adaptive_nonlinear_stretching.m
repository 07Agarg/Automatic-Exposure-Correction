close all;
clear all;
clc
%%================================================================================================
D = '../Dataset/Part A/';
% D = '../Dataset/Part B/';
S = fullfile(pwd, D, 'IMG_6.png');
im = imread(S); % Read the Image
hsv_x = rgb2hsv(im);

i = hsv_x(:,:,3);
% i255 = uint8(i*255);

hsv_y = adapt_nonlinear_stretch(i);
%i_new = double(hsv_y)/255.0;
hsv_x(:,:,3) = hsv_y;
y =  hsv2rgb(hsv_x);

figure; imshow(im), title('Original Image');
figure; imshow(y), title('Adaptive Non Linear Stretched Image')

brisque_orig_img = round(brisque(im), 4);
brisque_adaptnonlinear = round(brisque(y), 4);

niqe_orig_img = round(niqe(im), 4);
niqe_adaptnonlinear = round(niqe(y), 4);

function threshold = otsu_threshold(I)
    [counts,x] = imhist(I);
    threshold = otsuthresh(counts);
end


function [px, xpx] = ret_px_xpx(PDF, low, high)
    px = sum(PDF(low+1:high));
    xpx = 0;
    for i=low:high
       xpx = xpx + double(i/255) * PDF(i+1);
    end
end


function hist = calc_hist(x)
    [M,N]=size(x); % get size of image
    total_pixels = M*N;
    
    for i=0:255
       PDF(i+1)=sum(sum(x==i))/total_pixels; %hist of input image
    end
    hist = PDF;
end

function kbar = calc_kbar(x, b)
    ybar = 0.5;                       %%% Given in paper
    
    x255 = uint8(x*255);
    x_hist = calc_hist(x255);
    b_255 = uint8(b*255);
    
    [b1, a1] = ret_px_xpx(x_hist, b_255, 255);
    [X, c1] = ret_px_xpx(x_hist, 0, b_255);
    [X, e1] = ret_px_xpx(x_hist, 0, 255);
    d1 = b1;
      
    num = (1-b) * ybar - a1 + b * b1;
    den = c1 + b * d1 - b * e1;
    kbar = b * (num/den);
end

function y = adapt_nonlinear_stretch(x)
    
    b = otsu_threshold(x);            %%% In range 0-1
    kbar = calc_kbar(x, b);
    
    xmin = double(min(x(:)));
    xmax = double(max(x(:)));
    
    mu = 0.2;  %%%% Parameter lie between [0, 1]
    %mu = mean(x(:));
    
    k_low = (1 - mu)*b;
    k_high = mu + (1 - mu)*b;

    if kbar > k_high
        k = k_high;
    elseif kbar <= k_high && kbar >= k_low
        k = kbar;
    else
        k = k_low;
    end
     
    [M,N]=size(x); % get size of image
    y = x;
    for i = 1:M
        for j = 1:N
          if x(i, j) <= xmin
              y(i, j) = 0;
          elseif x(i, j) > xmin && x(i, j) <= b
              y(i, j) = (k/(b - xmin))*(x(i, j) - xmin);
          elseif x(i, j) > b && x(i, j) < xmax
              y(i, j) = k + ((1 - k)/(xmax - b))*(x(i, j) - b);
          else 
              y(i, j) = 1;
          end
        end
    end
end
