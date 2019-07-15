%% filtro weiner
clear all;close all;clc;
I=imread('Skeleton.tif');

%I=rgb2gray(I);
[m n]=size(I);
% figure(1),subplot(2,2,1),imshow(I)
figure,imshow(I)
title('Original.')
%% filtro de la imagen original
F=fft2(I);%transformada de fourier de la imagen original
%I=double(I);
a=0.1;
b=0.1;
T=1;
K=0.0001;
for u=1:m
    for v=1:n
        pi1=pi*((u*a)+(v*b));
        H(u,v)=(T/pi1)*(sin(pi1)*exp(-j*pi1));%calcular la funcion de degradaci?n
        G(u,v)=H(u,v)*F(u,v); % calcular la transformada de la imagen degradada
        %H2(u,v)=(abs(H(u,v)))^2; %%%checar ---conj(H)
        H2(u,v)=conj(H(u,v));
        H3(u,v)= H2(u,v)*H(u,v); %conjugado de H por H
        H4(u,v)=(abs(H3(u,v)))^2;
        F5(u,v)=(((1/H(u,v))*(H4(u,v)/(H4(u,v)+K)))*G(u,v));%funcion de error m?nima
    end
end

% F5=abs(F5);
% F5=uint8(F5);
% e=I+F5;
F5=abs(ifft2(F5));
F5=uint8(F5);
e=(I-F5);
figure,imshow(uint8(e))
title('imagen original con filtro')
%imwrite(e,'prueba1.jpg');

%% filtro de la imagen con ruida gaussiano

I2=imread('Imagenruidogaus.jpg'); %imagen con el ruido
%I2=rgb2gray(I2);
% figure(1),subplot(2,2,3),imshow(I2);
figure,imshow(I2)
title('imagen con ruido')
%I2=double(I2);
FR=fft2(I2);%transformada de fourier de la imagen con ruido gaussiano
a=0.1;
b=0.1;
T=1;
K=0.0001;
for u=1:m
    for v=1:n
        pi1=pi*((u*a)+(v*b));
        H1(u,v)=(T/pi1)*(sin(pi1)*exp(-j*pi1));%calcular la funcion de degradaci?n
        G1(u,v)=H1(u,v)*FR(u,v); % calcular la transformada de la imagen degradada
        %H22(u,v)=(abs(H1(u,v)))^2; %%%checar
        H21(u,v)=conj(H1(u,v));
        H22(u,v)= H21(u,v)*H1(u,v);
        H33(u,v)=(abs(H22(u,v)))^2;
        F44(u,v)=(((1/H1(u,v))*(H33(u,v)/(H33(u,v)+K)))*G1(u,v));%funcion de error m?nima
    end
end

F44=abs(ifft2(F44));
F44=uint8(F44);
e1=(I2-F44);
% figure,imshow(F44);
% title('filtro')

figure,imshow(uint8(e1))
title('imagen con ruido gaussiano con filtro')
