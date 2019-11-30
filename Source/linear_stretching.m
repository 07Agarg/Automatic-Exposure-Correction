close all;
clear all;
clc
%%================================================================================================
D = '../Dataset/Part A/';
% D = '../Dataset/Part B/';
S = fullfile(pwd, D, 'IMG_1.png');
im = imread(S); % Read the Image
hsv_im = rgb2hsv(im);

i = hsv_im(:,:,3);
i_255 = uint8(i*255);

i_new = linear_stretch(i);
hsv_im(:,:,3) = i_new;
y =  hsv2rgb(hsv_im);

figure; imshow(im), title('Original Image');
figure; imshow(y), title('Linear Stretched Image')

figure; imhist(im)
figure; imhist(y)

brisque_orig_img = round(brisque(im), 4);
brisque_adaptnonlinear = round(brisque(y), 4);

function op_im = linear_stretch(im)
    C = 10;
    x = im;
    ymin = 0;
    ymax = 1;
    
    xmin = double(min(x(:)));
    xmax = double(max(x(:)));
    
    y=x;
    for i=0:255
        I = find(x==i); %index of pixels in input image with value ‘i’
        y(I) = (C*logsig(i)-xmin)/(xmax-xmin);
    end
    
    op_im = y;
end