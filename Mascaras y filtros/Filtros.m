function [ D ] = Filtros( input_args )

%Cerramos las ventanas que puedan estar abiertas
close all



%Obtenemos la matriz de nuestra imagen
A=imread('MRIspine1.tif');
%Lo llevamos a un formato doble
A=double(A);
%Normalizamos la matriz
A=A/255;

%Creamos nuestras matrices para aplicar el filtro
h1=[0,-1,0;-1,8,-1;0,-1,0];
h1=h1/4;
h2=[0,-1,0;-1,5,-1;0,-1,0];

%Utilizamos el comando imfilter para aplicar el filtro a nuestra imagen
%original
B=imfilter(A,h1);
C=imfilter(A,h2);


%Desplegamos y guardamos nuestras imagenes original y las filtradas
figure (1), imshow(A), title('Original');
figure (2), imshow(B), title('Filtro Sharp 1');
imwrite(B, '4.1 Filtro 1.jpg', 'jpg');
figure (3), imshow(C), title('Filtro Sharp 2');
imwrite(C, '4.2 Filtro 2.jpg', 'jpg');

%Creamos una tercera matriz que nos servir? de filtro
h3=ones(3);
h3=h3/9;

%Aplicamos el filtro a la imagen guardando en una variable nueva
D=imfilter(A,h3);
%Restamos el filtro de la imagen original
E=A-D;
%Sumamos el resultado anterior a nuestra imagen original
F=A+E;

%Desplegamos nuestra imagen original y la filtrada a la vez que guardamos
%esta ultima
figure (1), imshow(A), title('Original');
figure (4), imshow(F), title('Filtro unsharp');
imwrite(F, '5.1 Filtro Unsharp.jpg', 'jpg');

end

