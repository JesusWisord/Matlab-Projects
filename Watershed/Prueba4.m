ImOr=double(rgb2gray((imread('Practica4.jpg'))))/255;
[m,n]=size(ImOr);
Fourier=fft2(ImOr);
FourierCentrada=fftshift(Fourier);
IM2=FourierCentrada;

figure(3), imshow(real(FourierCentrada));
ord=20;
Do=5;
Do2=150;
H=zeros(m,n);
for i=1:m
    for j=1:n
        D(i,j)=sqrt((i-(m/2))^2+(j-(n/2))^2);
        H(i,j)=1/(1+((Do/D(i,j)).^(2*ord)));
        H2(i,j)=1/(1+((D(i,j)/Do2).^(2*ord)));
    end
end
% H=fft2(H);
% H=fftshift(H);

IM3=H.*IM2;
IM4=H2.*IM2;

IM3=ifft2(IM3);
IM4=ifft2(IM4);
F1=IM3+ImOr;
% IM3=ifftshift(IM3);
figure(1),imshow(uint8((IM3+.1)*255)),title('Im. Filtrada PA');
figure(2), imshow(ImOr), title('Original')
figure(3),imshow(uint8((IM4+.1)*255)),title('Im. Filtrada PB');
figure(4), imshow(uint8((F1+.1)*255)), title('realce');

Med=medfilt2(real(IM4),[5 5]);
figure(5), imshow(Med), title('Med + PB');
% Med=real(F1);
I=Med;

I=im2bw(I);
imshow(I);
pause;
I=imcomplement(I);
imshow(I);
pause;
I=bwdist(I);
imshow(I);
pause;
I=watershed(I);
imshow(I);
pause;


% hy = fspecial('sobel');
% hx = hy';
% Iy = imfilter(double(I), hy, 'replicate');
% Ix = imfilter(double(I), hx, 'replicate');
% gradmag = sqrt(Ix.^2 + Iy.^2);
% figure
% imshow(gradmag,[]), title('Gradient magnitude (gradmag)')
% pause
% L = watershed(gradmag);
% Lrgb = label2rgb(L);
% figure, imshow(Lrgb), title('Watershed transform of gradient magnitude (Lrgb)')
% se = strel('disk', 20);
% Io = imopen(I, se);
% figure
% imshow(Io), title('Opening (Io)')
% Ie = imerode(I, se);
% Iobr = imreconstruct(Ie, I);
% figure
% imshow(Iobr), title('Opening-by-reconstruction (Iobr)')
% Ioc = imclose(Io, se);
% figure
% imshow(Ioc), title('Opening-closing (Ioc)')
% Iobrd = imdilate(Iobr, se);
% Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
% Iobrcbr = imcomplement(Iobrcbr);
% figure
% imshow(Iobrcbr), title('Opening-closing by reconstruction (Iobrcbr)')
% fgm = imregionalmax(Iobrcbr);
% figure
% imshow(fgm), title('Regional maxima of opening-closing by reconstruction (fgm)')
% I2 = I;
% I2(fgm) = 255;
% figure
% imshow(I2), title('Regional maxima superimposed on original image (I2)')
% se2 = strel(ones(5,5));
% fgm2 = imclose(fgm, se2);
% fgm3 = imerode(fgm2, se2);
% fgm4 = bwareaopen(fgm3, 20);
% I3 = I;
% I3(fgm4) = 255;
% figure
% imshow(I3)
% title('Modified regional maxima superimposed on original image (fgm4)')
% bw = im2bw(Iobrcbr);
% figure
% imshow(bw), title('Thresholded opening-closing by reconstruction (bw)')
% D = bwdist(bw);
% DL = watershed(D);
% bgm = DL == 0;
% figure
% imshow(bgm), title('Watershed ridge lines (bgm)')
% gradmag2 = imimposemin(gradmag, bgm | fgm4);
% L = watershed(gradmag2);
% I4 = I;
% I4(imdilate(L == 0, ones(3, 3)) | bgm | fgm4) = 255;
% figure
% imshow(I4)
% title('Markers and object boundaries superimposed on original image (I4)')
% Lrgb = label2rgb(L, 'jet', 'w', 'shuffle');
% figure
% imshow(Lrgb)
% title('Colored watershed label matrix (Lrgb)')
% figure
% imshow(I)
% hold on
% himage = imshow(Lrgb);
% himage.AlphaData = 0.3;
% title('Lrgb superimposed transparently on original image')