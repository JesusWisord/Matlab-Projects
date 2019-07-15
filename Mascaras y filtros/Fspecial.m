function [ output_args ] = Fspecial( input_args )


%Cerramos las ventanas que puedan estar abiertas
close all


%Leemos nuestra matriz
A=imread('MRIspine1.tif');
%La transformamos a dobles
A=double(A);
%Normalizamos la matriz
A=A/255;

%Creamos dos filtros, uno laplaciano y otro promedio con el comando de
%fspecial
Lap=fspecial('laplacian');
Prom=fspecial('average');

%Aplicamos ambos filtros a nuestra imagen original
B=imfilter(A,Lap);
C=imfilter(A,Prom);

%Restamos este filtro de nuestra imagen original en el caso del filtro
%Laplace
B=A-B;

%Desplegamos nuestras im?genes y las guardamos en nuestra carpeta
figure(1), imshow(A), title ('Original');
figure(2), imshow(B), title ('Laplace');
imwrite(B,'6.1 Filtro fspecial Laplace.jpg','jpg');
figure(3), imshow(C), title ('Promedio');
imwrite(C,'6.2 Filtro fspecial Promedio.jpg','jpg');

Unsharp=fspecial('unsharp');


end

