clc;
clear all;
close all;

A = imread('../boy_smiling.jpg');
figure, imshow(A);
A = double(A);
R = A(:,:,1);
G = A(:,:,2);
B = A(:,:,3);

BR = bilateral_filter(R,10,2,10);
BG = bilateral_filter(G,10,2,10);
BB = bilateral_filter(B,10,2,10);

B = cat(3, BR, BG, BB);
figure, imshow(uint8(B))