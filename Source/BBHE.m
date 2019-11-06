clc;
close all;
clear all;
D = '../Dataset/Part B/';
S = fullfile(pwd, D, 'IMG_1.png')
a = imread(S);
x_red = a(:,:,1);
x_green = a(:,:,2);
x_blue = a(:,:,3);

y_red = uint8(BBHE(x_red));
y_green = uint8(BBHE(x_green));
y_blue = uint8(BBHE(x_blue));

y_final = cat(3, y_red, y_green, y_blue);
figure,imshow(a), title('Original Image');
figure, imshow(y_final), title('BBHE Colored Image');

function equalized_img = BBHE(x)
sz = size(x);
%figure; imshow(x)
o_mean = round(mean(x(:)));
                                                                             % HISTOGRAM
h_l = zeros(256,1);
h_u = zeros(256,1);
for i = 1:sz(1)
   for j = 1:sz(2)
       g_val = x(i,j);
        if(g_val<=o_mean)
         h_l(g_val+1) = h_l(g_val+1) + 1;
       else
          h_u(g_val+1) = h_u(g_val+1) + 1;
       end
   end
end

nh_l = zeros(256,1);
nh_u = zeros(256,1);
                                                                            % NORMALIZED HISTOGRAM OR PDF
nh_l = h_l/sum(h_l);
nh_u = h_u/sum(h_u);
% % CDF
hist_l_cdf = double(zeros(256,1));
hist_u_cdf = double(zeros(256,1));
hist_l_cdf(1) = nh_l(1);
hist_u_cdf(1) = nh_u(1);
for k = 2:256
   hist_l_cdf(k) =  hist_l_cdf(k-1) + nh_l(k);
   hist_u_cdf(k) =  hist_u_cdf(k-1) + nh_u(k);
end
                                                                              % IMAGE REMAPPING 
equalized_img = zeros(sz);
range_l = [0 o_mean];
range_u = [(o_mean+1) 255];
for i =1:sz(1)
   for j =1:sz(2)
       g_val = x(i,j);
       if(g_val<=o_mean)
          equalized_img(i,j) = range_l(1) + round(((range_l(2)-range_l(1))*hist_l_cdf(g_val+1))); 
       else
          equalized_img(i,j) = range_u(1) + round(((range_u(2)-range_u(1))*hist_u_cdf(g_val+1))); 
       end
  end
end
end