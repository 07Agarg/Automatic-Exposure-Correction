%Improved Gamma Correction
%source: https://arxiv.org/ftp/arxiv/papers/1709/1709.04427.pdf

clc;
close all;

D = '../Dataset/Part A/';
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
% paper parameters
T = 112;           % T is appropriate to be set as about the half of maximum pixel intensity, i.e., 128 for 8-bit images.
thresh = 0.3;      % threshold used for distinguishing brightness-distorted images from normal ones. set experimentally in consideration of the trade-off between enhancement quality and technical applicability.
% trunc = 0.5;
% alpha_dimmed = 0.75;
% alpha_bright = 0.25;

function y = ce_dimmed(x)

    y =0;

end

function y = ce_bright(x)

    y =0;

end

%The input image is judged as dimmed if t < -thresh and bright if t > thresh
% The images with normal illuminance threshold, t <= thresh are found to be unfit for AGC-based enhancement 
% thus, not addressed by the following techniques. 
function y = improved_gamma_transform(x)
    [M,N]=size(x); % get size of image
    total_pixels = M*N;
    
    m = sum(sum(x))/total_pixels;    
    t = int((m - T)/T);
    
    if t < -thresh
        y = ce_dimmed(x); 
    elseif t > thresh
        y = ce_bright(x);
    else
        y = -1;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
%     for i=0:255
%        PDF1(i+1)=sum(sum(x==i))/total_pixels; %hist of input image
%     end
% 
%     p_max = max(PDF1);
%     p_min = min(PDF1);
%     
%     %weighting dist fn to smooth primary hist
%     for i=0:255
%         PDF2(i+1) = p_max * (((PDF1(i+1)-p_min)/(p_max-p_min))^alpha);
%     end
%     
%     %normalize prob
%     PDF3 = PDF2/sum(PDF2);
%    
%     PDF = PDF3;
%     y=x; 
%     for i=0:255
%        I = find(x==i); %index of pixels in input image with value ‘i’
%        CDF = sum(PDF(1:i));
%        gamma = 1 - CDF;
%        y(I) = round(l_max*((i/l_max)^gamma)); 
%     end
