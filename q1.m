clc;
clear all;
close all;

% A = imread('spot1-diff1.jpg');
% B = imread('spot1-diff2.jpg');
A = imread('spot1-diff1.jpg');
B = imread('spot1-diff2.jpg');

g = imabsdiff(A,B);
%figure, imshow(g)
Ifill = im2bw(g,0.05);
figure, imshow(Ifill)
[Ilabel num] = bwlabel(Ifill);

figure, imshow(A)
hold on;
for cnt = 1:num
    s = regionprops(Ilabel, 'BoundingBox');
    rectangle('position', s(cnt).BoundingBox,'edgecolor','r','linewidth',1);
end
hold off

figure, imshow(B)
hold on;
for cnt = 1:num
    s = regionprops(Ilabel, 'BoundingBox');
    rectangle('position', s(cnt).BoundingBox,'edgecolor','r','linewidth',1);
end
hold off
