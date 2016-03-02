clear;
clc;
close all;

image = imread('../office.jpg');
figure,imshow(image);
figure,imhist(rgb2gray(image));

[l, b,h] = size(image);

R = image(:,:,1);
G = image(:,:,2);
B = image(:,:,3);

hR = imhist(R);
hG = imhist(G);
hB = imhist(B);

hR = hR/(l*b);
hG = hG/(l*b);
hB = hB/(l*b);

cR = [];
cR(1) = hR(1);
cG = [];
cG(1) = hG(1);
cB = [];
cB(1) = hB(1);

for i = 2:256
    cR(i) = cR(i-1) + hR(i);
    cG(i) = cG(i-1) + hG(i);
    cB(i) = cB(i-1) + hB(i);
end

cR = cR*255;
cG = cG*255;
cB = cB*255;

%histogram matching

step=[];
for i = 1:256
    if(i<=100)
        step(i) = 0;
    else
        step(i) = (l*b)/156;
    end
end

step = step/(l*b);

cstep = [];
cstep(1) = step(1);

for i = 2:256
    cstep(i) = cstep(i-1)+step(i);
end

cstep = cstep*255;
mapcR = zeros(256,1);
mapcG = zeros(256,1);
mapcB = zeros(256,1);

for i = 1:256
    [~,index] = min(abs(cstep-cR(i)));
    mapcR(i) = index(1);
    [~,index] = min(abs(cstep-cG(i)));
    mapcG(i) = index(1);
    [~,index] = min(abs(cstep-cB(i)));
    mapcB(i) = index(1);
end

for i = 1:l
    for j = 1:b
        R(i,j) = mapcR(R(i,j)+1);
        G(i,j) = mapcG(G(i,j)+1);
        B(i,j) = mapcB(B(i,j)+1);
    end
end

image = cat(3,R,G,B);
figure
imshow(image);
figure,imhist(rgb2gray(image));