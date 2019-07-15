    function [  ] = untitled4( input_args )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
close all;
%Leemos nuestra imagen con el debido proceso para poder manipularla
ImOr=double(rgb2gray(imread('rm_rodilla.jpg')))/255;
%Obtenemos el tama?o de la imagen en dos variables
[M,N]=size(ImOr);
%Obtenemos una imagen corrompida con ruido impulso
ImagenSalPimienta=imnoise(ImOr, 'salt & pepper', .1);
%Obtenemos una imagen corrompida con ruido gaussiano
ImRuidoGauss=imnoise(ImOr,'gaussian',0,0.1);
%Aplicamos Fourier a nuestra imagen original y la centramos
Fourier=fft2(ImOr);
FourierCentrada=fftshift(Fourier);

%Declaramos nuestras constantes
a=0.1;
b=a;
T=1;
K=1000;

%Creamos una matriz del mismo tama?o de nuestra imagen con nuestra formula
%para obtener H
for x=1:M
    for y=1:N
        
       aux1=T/(pi*(x*a+b*y));
       aux2=sin(pi*(a*x+y*b));
       aux3=exp((-y)*pi*(a*x+y*b));
       H(x,y)=(aux1*aux2*aux3)+.00001;
       
    end
end

%Aplicamos Fourier a esa matriz y la centramos
H=fft2(H); 
H=fftshift(H);

%Creamos otro ciclo para aplicar nuestra formula del Filtro de Wiener y
%obtener as? una imagen
for x=1:M
    for y=1:N
        
       aux4=1/H(x,y);
       complex=conj(H(x,y));
       cuad=abs(H(x,y)).^2;
       aux5=(cuad)/((cuad)+K);
       aux6=FourierCentrada(x,y);
       Fp(x,y)=aux4*aux5*aux6;
        
    end
end

%Aplicamos una inversa de Fourier de esta ultima matriz.
Fp=ifftshift(Fp);
Fp=ifft2(Fp); 


%Mostramos nuestras imagenes
figure(1), imshow(real((Fp*255))), title('Filtro Wiener');
figure(2), imshow(real((ImOr))), title('Imagen Original');

%Guardamos nuestras imagenes
imwrite(real((Fp*255)),'Filtro Wiener.jpg','jpg');
imwrite(real((ImOr)),'Imagen Original.jpg','jpg');

pause
%------------------------------------------------------------------------%

%Aplicamos Fourier a nuestra imagen con ruido impulso y la centramos
Fourier=fft2(ImagenSalPimienta);
FourierCentrada=fftshift(Fourier);

%Creamos una matriz del mismo tama?o de nuestra imagen con nuestra formula
%para obtener H
for x=1:M
    for y=1:N
        
       aux1=T/(pi*(x*a+b*y));
       aux2=sin(pi*(a*x+y*b));
       aux3=exp((-y)*pi*(a*x+y*b));
       H(x,y)=(aux1*aux2*aux3)+.00001;
       
    end
end

%Aplicamos Fourier a esa matriz y la centramos
H=fft2(H); 
H=fftshift(H);

%Creamos otro ciclo para aplicar nuestra formula del Filtro de Wiener y
%obtener as? una imagen
for x=1:M
    for y=1:N
        
       aux4=1/H(x,y);
       complex=conj(H(x,y));
       cuad=abs(H(x,y)).^2;
       aux5=(cuad)/((cuad)+K);
       aux6=FourierCentrada(x,y);
       Fp(x,y)=aux4*aux5*aux6;
        
    end
end

%Aplicamos una inversa de Fourier de esta ultima matriz.
Fp=ifftshift(Fp);
Fp=ifft2(Fp); 


%Mostramos nuestras imagenes
figure(1), imshow(real((Fp*255))), title('Filtro Wiener');
figure(2), imshow(real((ImagenSalPimienta))), title('Imagen Sal y Pimienta');

%Guardamos nuestras imagenes
imwrite(real((Fp*255)),'Filtro Wiener Sal y Pimienta.jpg','jpg');
imwrite(real((ImagenSalPimienta)),'Imagen Sal y Pimienta.jpg','jpg');

pause
%------------------------------------------------------------------------%

%Aplicamos Fourier a nuestra imagen con ruido impulso y la centramos
Fourier=fft2(ImRuidoGauss);
FourierCentrada=fftshift(Fourier);

%Creamos una matriz del mismo tama?o de nuestra imagen con nuestra formula
%para obtener H
for x=1:M
    for y=1:N
        
       aux1=T/(pi*(x*a+b*y));
       aux2=sin(pi*(a*x+y*b));
       aux3=exp((-y)*pi*(a*x+y*b));
       H(x,y)=(aux1*aux2*aux3)+.00001;
       
    end
end

%Aplicamos Fourier a esa matriz y la centramos
H=fft2(H); 
H=fftshift(H);

%Creamos otro ciclo para aplicar nuestra formula del Filtro de Wiener y
%obtener as? una imagen
for x=1:M
    for y=1:N
        
       aux4=1/H(x,y);
       complex=conj(H(x,y));
       cuad=abs(H(x,y)).^2;
       aux5=(cuad)/((cuad)+K);
       aux6=FourierCentrada(x,y);
       Fp(x,y)=aux4*aux5*aux6;
        
    end
end

%Aplicamos una inversa de Fourier de esta ultima matriz.
Fp=ifftshift(Fp);
Fp=ifft2(Fp); 


%Mostramos nuestras imagenes
figure(1), imshow(real((Fp*255))), title('Filtro Wiener');
figure(2), imshow(real((ImRuidoGauss))), title('Imagen Ruido Gauss');

%Guardamos nuestras imagenes
imwrite(real((Fp*255)),'Filtro Wiener Ruido Gaussiano.jpg','jpg');
imwrite(real((ImRuidoGauss)),'Imagen Ruido Gaussiano.jpg','jpg');

end

