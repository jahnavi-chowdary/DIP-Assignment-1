clc;
clear;
close all;

A = imread('../face.png');
figure, imshow(A);
A = double(A);

n = 5;
sig_d = 2;
sig_r = 30;

B = bilateral_filter(A,n,sig_d,sig_r);
figure; imshow(uint8(B));