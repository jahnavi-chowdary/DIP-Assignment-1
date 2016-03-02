clear;
clc;
close all;

im = imread('bell.jpg');
figure, imshow(im);

R = im(:,:,1);
G = im(:,:,2);
B = im(:,:,3);

imgdR = im2double(R);   % imgd in [0,1]
imgdG = im2double(G);   % imgd in [0,1]
imgdB = im2double(B);   % imgd in [0,1]

% ----------- Average Filter --------------

x = 5;
fil = ones(x);
temp = x.*x;
fil = (1/temp)*fil;

blurR = conv2(R,fil,'same');
blurG = conv2(G,fil,'same');
blurB = conv2(B,fil,'same');
blur = (cat(3,blurR,blurG,blurB));
figure, imshow(uint8(blur));

% ----------- Gaussian Filter ---------------

% h = fspecial('gaussian', 10 , 2);
% % hR = fspecial('gaussian', size(R) , 2);
% gR = conv2(R, h,'same');
% % hG = fspecial('gaussian', size(G) , 2);
% gG = conv2(G, h,'same');
% % hB = fspecial('gaussian', size(B) , 2);
% gB = conv2(B, h,'same');
% blur = (cat(3,gR,gG,gB));
% figure, imshow(uint8(blur));

% --------------------------------------------

% High Boost Filtering

k = 100;
temp = im - uint8(blur);
figure, imshow(temp);
final = im + k * temp;
figure, imshow(final);
