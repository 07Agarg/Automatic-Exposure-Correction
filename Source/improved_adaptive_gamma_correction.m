%Improved Gamma Correction
%source: https://arxiv.org/ftp/arxiv/papers/1709/1709.04427.pdf

clc;
clear;
close all;

D = '../Dataset/Part B/';
S = fullfile(pwd, D, 'IMG_1.png');

x=double(imread(S)); % input image
xr = x(:,:,1);
xg = x(:,:,2);
xb = x(:,:,3);

imshow(uint8(x)), title('Original Image');

yr = improved_gamma_transform(xr); 
yg = improved_gamma_transform(xg);
yb = improved_gamma_transform(xb);

y = cat(3,uint8(yr),uint8(yg),uint8(yb));
figure; imshow(uint8(y)), title('Improved Gamma Correction Transformed Image');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global T;
global thresh;
global trunc;
global alpha_dimmed;
global alpha_bright;

function y = ce_dimmed(x)
    
    global trunc;
    global alpha_dimmed;
    
    alpha = alpha_dimmed;
    l_max = 255;
    [M,N]=size(x); % get size of image
    total_pixels = M*N;
    
    x = 255 - x;
    
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
       gamma = max(trunc, 1 - CDF);
       y(I) = round(l_max*((i/l_max)^gamma)); 
    end
    
end

function y = ce_bright(x)

    global alpha_bright;
    
    alpha = alpha_bright;
    l_max = 255;
    [M,N]=size(x); % get size of image
    total_pixels = M*N;
    
    x = 255 - x;
    
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
    
    y = round(255 - y);

end

%The input image is judged as dimmed if t < -thresh and bright if t > thresh
% The images with normal illuminance threshold, t <= thresh are found to be unfit for AGC-based enhancement 
% thus, not addressed by the following techniques. 
function y = improved_gamma_transform(x)
    
    global T;
    global thresh;
    global trunc;
    global alpha_dimmed;
    global alpha_bright;

    % paper parameters
    %T = 112;           % T is appropriate to be set as about the half of maximum pixel intensity, i.e., 128 for 8-bit images.
    T = 128;
    thresh = 0.3;      % threshold used for distinguishing brightness-distorted images from normal ones. set experimentally in consideration of the trade-off between enhancement quality and technical applicability.
    trunc = 0.5;
    alpha_dimmed = 0.75;
    alpha_bright = 0.25;
    
    [M,N]=size(x); % get size of image
    total_pixels = M*N;
    
    m = sum(sum(x))/total_pixels;    
    t = int8((m - T)/T);
    y = ce_bright(x);
    
%     if t < -thresh
%         "dimmed"
%         y = ce_dimmed(x); 
%     elseif t > thresh
%         "bright"
%         y = ce_bright(x);
%     else
%         "none"
%         y = -1;
%     end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%