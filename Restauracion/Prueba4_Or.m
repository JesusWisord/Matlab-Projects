    function [ G ] = untitled4( input_args )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

%ImOr=double(rgb2gray(imread('rm_rodilla.jpg')))/255;
ImOr=double(imread('brain_014.jpg'))/255;
%ImOr=double(imread('Skeleton.tif'))/255;
[M,N]=size(ImOr);

ImagenSalPimienta=imnoise(ImOr, 'salt & pepper', .1);
ImRuidoGauss=imnoise(ImOr,'gaussian',0,0.1);

Fourier=fft2(ImRuidoGauss);
FourierCentrada=fftshift(Fourier);

a=0.1;
b=a;
T=1;
K=400;

for x=1:M
    for y=1:N
        
       aux1=T/(pi*(x*a+b*y));
       aux2=sin(pi*(a*x+y*b));
       aux3=exp((-y)*pi*(a*x+y*b));
       H(x,y)=(aux1*aux2*aux3)+.00001;
       
    end
end

H=fft2(H); 
H=fftshift(H);

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


Fp=ifftshift(Fp);
Fp=ifft2(Fp); 

IM2=Fp./FourierCentrada;

G=ifft2(IM2);
G=ifftshift(IM2);

figure(1), imshow(real((Fp*255))), title('Filtro Wiener con abs H(x,y).^2');
figure(2), imshow(real((ImRuidoGauss))), title('Sal y Pimienta');

end
