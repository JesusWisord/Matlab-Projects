function [ output_args ] = untitled3( input_args )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
close all;
%Leemos nuestra imagen con el proceso necesario para manipularla
ImOr=double(rgb2gray(imread('rm_rodilla.jpg')))/255;

%Creamos nuestras dos matrices para detectar bordes en el eje x y en el eje
%y
Tempx=[-1,0,1;-2,0,2;-1,0,1]/4;
Tempy=[-1,-2,-1;0,0,0;1,2,1]/4;
%Aplicamos nuestros filtros y guardamos cada uno de ellos
Gx=imfilter(ImOr,Tempx);
Gy=imfilter(ImOr,Tempy);
%Combinamos ambas im?genes
G=sqrt((Gx.^2)+(Gy.^2));
%Mostramos el resultado
imshow((G)), title('Detecci?n de bordes Manual');
%Guardamos nuestra imagen
imwrite(G, 'Deteccion de bordes manual.jpg','jpg');
%Aplicamos nuestro comando para detectar bordes y guardamos en una variable
B=edge(ImOr,'sobel');
%Mostramos el resultado
figure (2), imshow(B), title('Deteccion de bordes Comando');
%Guardamos nuestra imagen de comando
imwrite(B, 'Deteccion de bordes comando.jpg','jpg');

end

