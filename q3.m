clear;
clc;
close all;

im = imread('chip.png');
[h w] = size(im);
imn = zeros(h,w);
figure, imshow(im);

c1 = 50;
c2 = 1;
p1 = 2;

for i = 1:h
    for j = 1:w        
%         imn(i,j) = c2 * (im(i,j).^(p1));  %power-law transformation
%          imn(i,j) = c1 * log(double(1+ im(i,j))); %log transformation
    end
end
% figure, imshow(uint8(imn));

 imn = histeq(im);
figure, imshow(uint8(imn));

% ----- Sharpening -------  

% Preallocate the matrices with zeros
I1=imn;
I=zeros(size(imn));
I2=zeros(size(imn));

%Filter Masks
F1=[0 1 0;1 -4 1; 0 1 0];
F2=[1 1 1;1 -8 1; 1 1 1];

%Padarray with zeros
imn=padarray(imn,[1,1]);
imn=double(imn);

%Implementation of the equation 
for i=1:size(imn,1)-2
    for j=1:size(imn,2)-2
       
        I(i,j)=sum(sum(F1.*imn(i:i+2,j:j+2)));
       
    end
end

I=uint8(I);
figure,imshow(I);

%Sharpenend Image
%Refer Equation in Fig.F
B=uint8(I1) - I;
figure,imshow(B);

% filt = fspecial('laplacian');
% temp = conv2(imn,filt,'same');
% figure, imshow(temp);
        
        
        
        
