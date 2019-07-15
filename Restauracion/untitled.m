close all

% Lee la imagen y saca el tama?o
IM=double(imread('pruebaA.jpg'))/255;
[m,n]=size(IM);

% Aplica ruido Sal & Pimienta a la imagen
IMruido = imnoise(IM,'salt & pepper',0.1);

% Fourier y centrado de la imagen ruidosa IMruido, en IM2
IM2=fft2(IMruido);
IM2=fftshift(IM2);

% Obtiene las distancias D(u,v) al pixel central (m/2,n/2) 
% A partir de ello calcula la funcion de transferencia 'H(u,v)'
% del Filtro pasabajas butterworth basa bajas")
% guardado en H.
% Usa una distancia Do=5 pixeles y orden ord=2, cuyos valores pueden ser cambiados
% en las variables ord y Do:

ord=2;
Do=50;
H=zeros(m,n);

for i=1:m
    for j=1:n
        D(i,j)=sqrt((i-(m/2))^2+(j-(n/2))^2);
        H(i,j)=1/(1+((D(i,j)/Do).^(2*ord)));
    end
end
IM3=H.*IM2;
% Una vez obtenida la funcion de transferencia H en el espacio,
% se transforma con fourier
H=fft2(H);
H=fftshift(H);

% Aplica la multiplicacion, elemento por elemento del filtro
% por la imagen transformada segun el teorema de convolucion DFT


% Aplica transformada inversa a la imagen filtrada
IM3=ifft2(IM3);
IM3=ifftshift(IM3);

figure(1),subplot(4,4,[1:2 5:6]),imshow(IM),title('Im. Original');
figure(1),subplot(4,4,[3:4 7:8]),imshow(uint8(H)),title(['Butterworth Pasa bajas Orden:',num2str(ord)]);
figure(1),subplot(4,4,[9:10 13:14]),imshow(IMruido),title('Im. Sal & Pimienta');
figure(1),subplot(4,4,[11:12 15:16]),imshow(uint8(IM3*255)),title('Im. Filtrada');
