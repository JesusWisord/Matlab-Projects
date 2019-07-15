function [  ] = Ejercicio2( input_args )

%Cerramos todas las ventanas, limpiamos nuestras variables y limpiamos
%nuestra ventana de comandos.
close all, clear all, clc; 

%Leemos nuestra imagen con Ruido
Im=imread('imagen3dB.bmp');
%La llevamos a un formato doble
Im=double(Im);
%Normalizamos la imagen
Im=Im/255;

%Aplicamos la transformada de Fourier mediante un comando y la guardamos en
%una variable nueva
ImFou=fft2(Im);
%Con una variable auxiliar extraemos el logaritmo del m?dulo de nuestra
%transformada de Fourier
ImFouAux=real(.5*log(1+ImFou));
%Mostramos el resultado en una Figura y guardamos como jpg
figure(1), imagesc(ImFouAux), colormap gray, title('DFT de la Imagen');
saveas (1, 'Transoformada de Fourier', 'jpg');

%Centramos nuestra imagen mediante un comando
Icen=fftshift(ImFou);
%Nuevamente extraemos el logaritmo del m?dulo de nuestra transformada de
%Fourier
Icen=real(log(1+Icen));
%Mostramos en una segunda figura el resultado y guardamos como jpg
figure(2), imagesc(Icen), colormap gray, title('DFT Centrada Comando');
saveas(2, 'DFT Centrada Comando', 'jpg');

%Mediante un ciclo implementamos el centrado de la imagen para la
%transformaci?n de Fourier de manera manual con la formula 
% f(x,y)* (-1) elevado a (x+y)
for x=1:size(Im,1);
    for y=1:size(Im,2);
        Im2(x,y)=Im(x,y)*((-1).^(x+y));
    end
end

%A esta nueva imagen le aplicamos la transformada de Fourier
ImFou2=fft2(Im2);
%Se extrae el logaritmos del m?dulo de la imagen
ImFou2=real(log(1+ImFou2));
%Se despliega la ?ltima figura y se guarda con formato jpg
figure(3), imagesc(ImFou2), colormap gray, title('DFT centrada Manual');
saveas (3, 'DFT Centrada Manual', 'jpg');


end

