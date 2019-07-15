function [ ] = Ejercicio1( input_args )

%Cerramos todas las ventanas, limpiamos nuestras variables y limpiamos
%nuestra ventana de comandos.
close all, clear all, clc; 

%Leemos nuestra imagen con Ruido
Im=imread('imagen3dB.bmp');
%La llevamos a un formato doble
Im=double(Im);
%Normalizamos la imagen
Im=Im/255;

%Creamos nuestros filtros suavizantes unitarios de los tama?os 9x9, 11x11 y
%15x15
Filtro1=ones(9)/(9*9);
Filtro2=ones(11)/(11*11);
Filtro3=ones(15)/(15*15);

%Aplicamos nuestros filtros con el argumento 'full'
ImF1_f=conv2(Im,Filtro1,'full');
ImF2_f=conv2(Im,Filtro2,'full');
ImF3_f=conv2(Im,Filtro3,'full');

%Guardamos nuestras im?genes resultantes
imwrite(ImF1_f,'Filtro 1 Full.jpg','jpg');
imwrite(ImF2_f,'Filtro 2 Full.jpg','jpg');
imwrite(ImF3_f,'Filtro 3 Full.jpg','jpg');

%Aplicamos nuestros filtros con el argumento 'same'
ImF1_s=conv2(Im,Filtro1,'same');
ImF2_s=conv2(Im,Filtro2,'same');
ImF3_s=conv2(Im,Filtro3,'same');

%Guardamos nuestras im?genes resultantes
imwrite(ImF1_s,'Filtro 1 Same.jpg','jpg');
imwrite(ImF2_s,'Filtro 2 Same.jpg','jpg');
imwrite(ImF3_s,'Filtro 3 Same.jpg','jpg');

%Aplicamos nuestros filtros con el argumento 'valid'
ImF1_v=conv2(Im,Filtro1,'valid');
ImF2_v=conv2(Im,Filtro2,'valid');
ImF3_v=conv2(Im,Filtro3,'valid');

%Guardamos nuestras im?genes resultantes
imwrite(ImF1_v,'Filtro 1 Valid.jpg','jpg');
imwrite(ImF2_v,'Filtro 2 Valid.jpg','jpg');
imwrite(ImF3_v,'Filtro 3 Valid.jpg','jpg');

%Desplegamos nuestras im?genes con un subplot
figure(1), imshow(Im), title('Imagen Original');
figure(2), subplot (1,3,1), imshow(ImF1_f), title('Filtro 9x9 "Full"');
figure(2), subplot (1,3,2), imshow(ImF2_f), title('Filtro 11x11 "Full"');
figure(2), subplot (1,3,3), imshow(ImF3_f), title('Filtro 15x15 "Full"');
figure(3), subplot (1,3,1), imshow(ImF1_s), title('Filtro 9x9 "Same"');
figure(3), subplot (1,3,2), imshow(ImF2_s), title('Filtro 11x11 "Same"');
figure(3), subplot (1,3,3), imshow(ImF3_s), title('Filtro 15x15 "Same"');
figure(4), subplot (1,3,1), imshow(ImF1_v), title('Filtro 9x9 "Valid"');
figure(4), subplot (1,3,2), imshow(ImF2_v), title('Filtro 11x11 "Valid"');
figure(4), subplot (1,3,3), imshow(ImF3_v), title('Filtro 15x15 "Valid"');


end

