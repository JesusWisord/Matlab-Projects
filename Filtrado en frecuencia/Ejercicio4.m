function [ output_args ] = Ejercicio4( input_args )

%Cerramos todas las ventanas, limpiamos nuestras variables y limpiamos
%nuestra ventana de comandos.
close all, clear all, clc; 

%Leemos ambas im?genes, les damos formato doble y las normalizamos
Im1=imread('imagen3dB.bmp');
Im2=imread('brain_014.jpg');
Im1=double(Im1);
Im2=double(Im2);
Im1=Im1/255;
Im2=Im2/255;

%Le damos transformada de fourier a nuestras dos im?genes guardando cada
%una en una variable nueva
Fou1=fft2(Im1);
Fou2=fft2(Im2);

%En una nueva variable interambiamos los m?dulos de nuestras im?genes con
%la convoluci?n.
Fou1_A=abs(Fou1).*exp(i*angle(Fou2));
Fou2_B=abs(Fou2).*exp(i*angle(Fou1));

%Guardamos estas dos transformaciones en 2 nuevas variables que
%representaran nuestras dos im?genes
Im3=ifft2(Fou1_A);
Im4=ifft2(Fou2_B);

%Desplegamos y guardamos nuestros resultados
figure(1), imshow(Im1), title('Imagen 1');
figure(2), imshow(Im2), title('Imagen 2');
figure(3), imshow(real(Im3)), title('Imagen 1 con Fase 2');
figure(4), imshow(real(Im4)), title('Imagen 2 con Fase 1');
imwrite(Im3,'Imagen 1 con Fase 2.jpg','jpg');
imwrite(Im4,'Imagen 2 con Fase 1.jpg','jpg');
end

