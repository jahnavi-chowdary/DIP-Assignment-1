clear;
clc;
close all;

im=imread('../office.jpg');
figure,imshow(im);
figure,imhist(rgb2gray(im));

R=im(:,:,1);
G=im(:,:,2);
B=im(:,:,3);

h=size(R,1);
w=size(R,2);

histR=zeros(256,1);
histG=zeros(256,1);
histB=zeros(256,1);
for i=1:h
    for j=1:w
        histR(R(i,j)+1) = histR(R(i,j)+1)+1;
        histG(G(i,j)+1) = histG(G(i,j)+1)+1;
        histB(B(i,j)+1) = histB(B(i,j)+1)+1;
    end
end

histR=histR/(h*w);
histG=histG/(h*w);
histB=histB/(h*w);

%plot(his);
cdfR=zeros(256,1);
cdfR(1)=histR(1);
cdfG=zeros(256,1);
cdfG(1)=histG(1);
cdfB=zeros(256,1);
cdfB(1)=histB(1);
for i=2:256
    cdfR(i)=cdfR(i-1)+histR(i);
    cdfG(i)=cdfG(i-1)+histG(i);
    cdfB(i)=cdfB(i-1)+histB(i);
end

rampf=zeros(256,1);
for i=1:size(rampf,1)
    if i<=75
        rampf(i)=20;
    elseif i>181
        rampf(i)=80;
    else
        rampf(i)=20+(i-75)*((80-20)/106);
    end
end

rampf=rampf/sum(rampf);
cdf_ramp=cumsum(rampf);
map_cdfR=zeros(256,1);
map_cdfG=zeros(256,1);
map_cdfB=zeros(256,1);

for i=1:256
        [~, ind] = min(abs(cdf_ramp-cdfR(i)));
        map_cdfR(i)=ind(1);
        [~, ind] = min(abs(cdf_ramp-cdfG(i)));
        map_cdfG(i)=ind(1);
        [~, ind] = min(abs(cdf_ramp-cdfB(i)));
        map_cdfB(i)=ind(1);
end

R2=uint8(zeros(h,w));
G2=uint8(zeros(h,w));
B2=uint8(zeros(h,w));

for i=1:h
    for j=1:w
        R2(i,j) = map_cdfR(R(i,j)+1);
        G2(i,j) = map_cdfG(G(i,j)+1);
        B2(i,j) = map_cdfB(B(i,j)+1);
    end
end

hist_eq_ramp=cat(3,R2,G2,B2);
figure, imshow(hist_eq_ramp);

figure, imhist(rgb2gray(hist_eq_ramp));
