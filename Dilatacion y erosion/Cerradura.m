function [ output_args ] = untitled4( input_args )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

I=double(imread('OutputBaselineBrain.png'))/255; %Leemos nuestra imagen y le
%damos un formato doble
[m,n]=size(I); %Obtenemos el tama?o de nuestra imagen.
se=strel('square',3);%Creamos nuestro elemento estructural
IM2=imdilate(I,se);%Aplicamos la dilataci?n a nuestra imagen
IM2=imerode(IM2,se); %Aplicamos la erosion a nuestra imagen
strel('line',3,0);%Creamos nuestro elemento estructural
IM3=imdilate(I,se);%Aplicamos la dilataci?n a nuestra imagen
IM3=imerode(IM3,se); %Aplicamos la erosion a nuestra imagen

%Mostramos y guardamos nuestras 2 imagenes.
figure(1), imshow(I), title('Original');
figure(2), imshow(IM2), title('Cerradura rectangulo');
imwrite(IM2,'Cerradura Rectangulo.jpg','jpg');
figure(3), imshow(IM3), title('Cerradura Linea');
imwrite(IM3,'Cerradura Linea.jpg','jpg');

end

