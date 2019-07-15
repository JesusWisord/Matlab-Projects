function [  ] = Ejercicio3( input_args )



%Cerramos todas las ventanas, limpiamos nuestras variables y limpiamos
%nuestra ventana de comandos.
close all, clear all, clc; 

%Leemos nuestra imagen con Ruido
Im=imread('imagen3dB.bmp');
%La llevamos a un formato doble
Im=double(Im);
%Normalizamos la imagen
Im=Im/255;

%Obtenemos el tama?o de la imagen en 2 variables
[m,n]=size(Im);

%Creamos las m?scaras suavizantes de distintos tama?os
Filtro1=ones(9)/(9*9);
Filtro2=ones(11)/(11*11);
Filtro3=ones(15)/(15*15);

%Creamos una variable con la Transformada de Fourier de la imagen original
FIm=fft2(Im);

%Transformamos nuestros filtros a transformada de fourier con el tama?o de
%nuestra imagen original
Fou_F1=fft2(Filtro1,m,n);
Fou_F2=fft2(Filtro2,m,n);
Fou_F3=fft2(Filtro3,m,n);

%Aplicamos al convoluci?n de los filtros con nuestra imagen ambos en
%Transformada de Fourier
ImF1=Fou_F1.*FIm;
ImF2=Fou_F2.*FIm;
ImF3=Fou_F3.*FIm;

%Aplicamos la inversi?n a cada una de nuestras im?genes
InvIm1=ifft2(ImF1);
InvIm2=ifft2(ImF2);
InvIm3=ifft2(ImF3);

%Las desplegamos en figuras y las guardamos en formato jpg
figure(1), imshow(Im), title('Imagen Original');
figure(2), imshow(InvIm1), title('Filtro 1 9x9');
figure(3), imshow(InvIm2), title('Filtro 2 11x11');
figure(4), imshow(InvIm3), title('Filtro 3 15x15');

imwrite(InvIm1,'Filtro 1 9x9.jpg','jpg');
imwrite(InvIm2,'Filtro 2 11x11.jpg','jpg');
imwrite(InvIm3,'Filtro 3 15x15.jpg','jpg');

end

