function [  ] = untitled2( n, D0 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
close all;
%Leemos nuestra imagen d?ndole el tratamiento necesario para poder
%trabajarla
ImOr=double(rgb2gray(imread('rm_rodilla.jpg')))/255;
%Obtenemos el tama?o de nuestra imagen en dos variables
[M,N]=size(ImOr);
%Corrompemos la imagen con ruido impulso
ImagenSalPimienta=imnoise(ImOr, 'salt & pepper', .1);
%Mostramos la imagen original y la imagen corrompida en un Plot
figure (1), subplot(1,2,1), imshow(ImOr), title('Imagen Original');
figure (2), subplot(1,2,1), imshow(ImagenSalPimienta), title('Imagen sal Y pimienta');
%Calculamos la transformada de Fourier de nuestra imagen corrompida y la
%centramos
FourierSyP=fft2(ImagenSalPimienta);
FourierCentradaSyP=fftshift(FourierSyP);
%Lo mismo haremos con nuestra imagen original
Fourier=fft2(ImOr);
FourierCentrada=fftshift(Fourier);
%Obtenemos el valor de u y v para el centro de nuestra imagen
u=M/2; v=N/2;

%Creamos un ciclo del tama?o de nuestra imagen
for x=1:M
    for y=1:N
%Creamos una matriz con la distancia de cada pixel
        D(x,y)=sqrt((x-u).^2+(y-v).^2);
%Creamos nuestra matriz del filtro PasaBajas
        PB(x,y)=(1/(1+((D(x,y)/D0).^(2*n))));
%Creamos nuestra matriz del filtro PasaAltas
        PA(x,y)=(1/(1+((D0/D(x,y)).^(2*n))));
    end
end

%Aplicamos la convoluci?n a nuestra imagen corrompida en el dominio de
%Fourier
ImagenPasaBajas=PB.*FourierCentradaSyP;
%Aplicamos la convolucion a nuestra imagen original en el dominio de
%Fourier
ImagenPasaAltas=PA.*FourierCentrada;
%Obtenemos las inversas de Fourier para recuperar la imagen
ImagenPasaBajas=ifft2(ImagenPasaBajas);
ImagenPasaAltas=ifft2(ImagenPasaAltas);

figure (1), subplot(1,2,2), imshow(real(uint8(ImagenPasaAltas*255))), title('Imagen Con Pasa Altas');
figure (2), subplot(1,2,2), imshow(real(uint8(ImagenPasaBajas*255))), title('Imagen con Pasa Bajas');

%Guardamos nuestras imagenes en la carpeta

imwrite(ImagenPasaBajas, 'Imagen Pasa Bajas.jpg', 'jpg');
imwrite(ImagenPasaAltas, 'Imagen Pasa Altas.jpg', 'jpg');


end

