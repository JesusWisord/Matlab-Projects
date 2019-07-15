    function [ G ] = untitled4( input_args )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

%ImOr=double(rgb2gray(imread('rm_rodilla.jpg')))/255;
ImOr=double(imread('brain_014.jpg'))/255;
[M,N]=size(ImOr);

ImagenSalPimienta=imnoise(ImOr, 'salt & pepper', .1);
ImRuidoGauss=imnoise(ImOr,'gaussian',0,0.1);

Fourier=fft2(ImagenSalPimienta);
FourierCentrada=fftshift(Fourier);

a=0.1;
b=a;
T=1;
K=.3;

H=ones(3)/9;

Hf = fft2(H,M,N);
% Hf= fftshift(Hf);

for x=1:M
    for y=1:N
        
       H(x,y)=abs(Hf(x,y)).^2;
       
    end
end

% H=fft2(H); 
% H=fftshift(H);

for x=1:M
    for y=1:N
        
       aux4=1/Hf(x,y);
       aux5=(H(x,y))/((H(x,y))+K);
       aux6=FourierCentrada(x,y);
       Fp(x,y)=aux4*aux5*aux6;
        
    end
end


% Fp=ifftshift(Fp);
Fp=ifft2(Fp); 


IM2=Fp./FourierCentrada;

G=ifft2(IM2);
G=ifftshift(IM2);

figure(3), imshow(real((Fp))), title('Filtro Wiener Suavizante');


end

