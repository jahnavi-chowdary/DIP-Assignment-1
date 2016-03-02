clear; 
clc;
close all;

im = imread('office.jpg');

R = im(:,:,1);
G = im(:,:,2);
B = im(:,:,3);

numofpixels=size(im,1)*size(im,2);

figure,imshow(im);

finalR=uint8(zeros(size(R,1),size(R,2)));
finalG=uint8(zeros(size(G,1),size(G,2)));
finalB=uint8(zeros(size(B,1),size(B,2)));

%---------- For R channel -------------

freq=zeros(256,1);
prof=zeros(256,1);
proc=zeros(256,1);
cdf=zeros(256,1);
out=zeros(256,1);
    
for i=1:size(R,1)
    for j=1:size(R,2)
        temp = R(i,j);
        freq(temp+1)=freq(temp+1)+1;
        prof(temp+1)=freq(temp+1)/numofpixels;
    end
end

sum=0;

for i=1:size(prof)
   sum=sum+freq(i);
   cdf(i)=sum;
   proc(i)=cdf(i)/numofpixels;
   out(i)=round(proc(i)*255);
end

for i=1:size(R,1)
    for j=1:size(R,2)
            finalR(i,j)=out(R(i,j)+1);        
    end
end

%------------- For G channel -----------

freq=zeros(256,1);
prof=zeros(256,1);
proc=zeros(256,1);
cdf=zeros(256,1);
out=zeros(256,1);

for i=1:size(G,1)
    for j=1:size(G,2)
        temp=G(i,j);
        freq(temp+1)=freq(temp+1)+1;
        prof(temp+1)=freq(temp+1)/numofpixels;
    end
end

sum=0;

for i=1:size(prof)
   sum=sum+freq(i);
   cdf(i)=sum;
   proc(i)=cdf(i)/numofpixels;
   out(i)=round(proc(i)*255);
end

for i=1:size(G,1)
    for j=1:size(G,2)
            finalG(i,j)=out(G(i,j)+1);
    end
end

%figure, imshow(HIm2);

%---------- For B channel --------------

freq=zeros(256,1);
prof=zeros(256,1);
proc=zeros(256,1);
cdf=zeros(256,1);
out=zeros(256,1);

for i=1:size(B,1)
    for j=1:size(B,2)
        temp=B(i,j);
        freq(temp+1)=freq(temp+1)+1;
        prof(temp+1)=freq(temp+1)/numofpixels;
    end
end

sum=0;

for i=1:size(prof)
   sum=sum+freq(i);
   cdf(i)=sum;
   proc(i)=cdf(i)/numofpixels;
   out(i)=round(proc(i)*255);
end

for i=1:size(B,1)
    for j=1:size(B,2)
        finalB(i,j)=out(B(i,j)+1);
    end
end

final = cat(3, finalR, finalG, finalB);
figure, imshow(final);
figure, imhist(rgb2gray(final));
