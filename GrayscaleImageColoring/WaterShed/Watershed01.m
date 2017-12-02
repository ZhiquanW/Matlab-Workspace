clear,clc
filename='colorImage05.jpg';
f=imread(filename);
Info=imfinfo(filename);
if Info.BitDepth>8 
f=rgb2gray(f);
end
figure,
mesh(double(f));%???????????
%??1???????????????????????
b=imbinarize(f,graythresh(f));%???,???????????????0???????b??
d=bwdist(b); %?????????????????????????
l=watershed(-d); %matlab????????l?????????
w=l==0; %????
g=b&~w; %?w??mask????????
figure
subplot(2,3,1),
imshow(f);
subplot(2,3,2),
imshow(b);
subplot(2,3,3),
imshow(d);
subplot(2,3,4),
imshow(l);
subplot(2,3,5),
imshow(w);
subplot(2,3,6),
imshow(g);
%??2?????????????????????????????????1???????
h=fspecial('sobel');%??????sobel??
fd=double(f);
g=sqrt(imfilter(fd,h,'replicate').^2+imfilter(fd,h','replicate').^2);%??sobel????????
l=watershed(g);%?????
wr=l==0;
g2=imclose(imopen(g,ones(3,3)),ones(3,3));%?????????????
l2=watershed(g2);%?????????
wr2=l2==0;f2=f;
f2(wr2)=255;
figure;subplot(2,3,1);
imshow(f);
subplot(2,3,2),imshow(g);
subplot(2,3,3),imshow(l);
subplot(2,3,4),imshow(g2);
subplot(2,3,5),imshow(l2);
subplot(2,3,6),imshow(f2);
%??3????????????????????2???????
h=fspecial('sobel');%??????sobel??
fd=double(f);
g=sqrt(imfilter(fd,h,'replicate').^2+imfilter(fd,h','replicate').^2);%??sobel????????
l=watershed(g);%?????
wr=l==0;
rm=imregionalmin(g); %???????????????????????????????????????
im=imextendedmin(f,2);%????????????????????????????????????2???
fim=f;
fim(im)=175; %?im????????????
lim=watershed(bwdist(im));%???????
em=lim==0;
g2=imimposemin(g,im|em);%???????im?em?im?????????em????
l2=watershed(g2); %????????
f2=f;f2(l2==0)=255; %???????????
figure;subplot(3,3,1);imshow(f);
subplot(3,3,2),imshow(g);
subplot(3,3,3),imshow(l);
subplot(3,3,4),imshow(im);
subplot(3,3,5),imshow(fim);
subplot(3,3,6),imshow(lim);
subplot(3,3,7),imshow(g2);
subplot(3,3,8),imshow(l2);
subplot(3,3,9),imshow(f2);