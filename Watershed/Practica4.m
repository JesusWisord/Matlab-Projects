function [ output_args ] = untitled( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    close all
    %Leemos nuestra imagen en formato doble y normalizando previamente
    %transformando el formato rgb a escala de grises
    ImOr=double(rgb2gray((imread('Practica4.jpg'))))/255;
    %Obtenemos el tama?o de nuestra imagen en dos variables
    [m,n]=size(ImOr);
    %Creamos una nueva variable con la DFT de la imagen
    Fourier=fft2(ImOr);
    %Centramos esta imagen en una nueva variable
    FourierCentrada=fftshift(Fourier);
    %Pasamos este resultado a una nueva variable
    IM2=FourierCentrada;
    %Asignamos la variables necesarias para nuestro filtro Pasa-Altas y
    %Pasa-Bajas para nuestro filtrado en frecuencia
    %Orden 20
    ord=20;
    %Frecuencia de corte para Pasa Altas 
    Do=5;
    %Frecuencia de corte para Pasa Bajas
    Do2=150;
    %Matrices a llenar con el resultado del filtrado
    H=zeros(m,n);
    H2=H;
    for i=1:m
        for j=1:n
            %Distancia de cada pixel
            D(i,j)=sqrt((i-(m/2))^2+(j-(n/2))^2);
            %Filtrado pasa Altas
            H(i,j)=1/(1+((Do/D(i,j)).^(2*ord)));
            %Filtrado Pasa Bajas
            H2(i,j)=1/(1+((D(i,j)/Do2).^(2*ord)));
        end
    end
    %Aplicamos el filtrado a nuestra imagen en el dominio de la frecuencia
    IM3=H.*IM2;
    IM4=H2.*IM2;
    %Le aplicamos la transformada inversa para regresar a la imagen
    IM3=ifft2(IM3);
    IM4=ifft2(IM4);
    %En el caso del Filtro Pasa Altas tendremos que sumar el resultado con
    %la imagen original para obtener el realce
    F1=IM3+ImOr;
    
    figure(1),imshow(uint8((IM3+.1)*255)),title('Im. Filtrada PA');
    figure(2), imshow(ImOr), title('Original')
    figure(3),imshow(uint8((IM4+.1)*255)),title('Im. Filtrada PB');
    figure(4), imshow(uint8((F1+.1)*255)), title('realce');
    
    %Creamos un ?ltimo filtado pero esta vez un filtro espacial. Este es un
    %filtro mediana que nos dara una imagen un poco mas suavizada en cuanto
    %a estructuras
    Med=medfilt2(ImOr,[7 7]);
    %Elegimos tres imagenes filtradas para procesarlas y utilizarlas en el
    %segmenteo y as? obtener segmentos mejor definidos
    I=(real(F1+.1));
    I2=Med;
    filt=fspecial('log');
    I3=imgaussfilt(I,.5);
   
    Imagen1=Segmenteo(I);
    pause;
    Imagen2=Segmenteo(I2);
    pause
    Imagen3=Segmenteo(I3);
    pause
    res=imshow(I)
    hold on
    himage = imshow(Imagen3);
    himage.AlphaData = 0.3;
    hold on
    himage = imshow(Imagen2);
    himage.AlphaData = 0.3;
    hold on
    himage = imshow(Imagen1);
    himage.AlphaData = 0.3;
    saveas(res,'Imagen final.jpg','jpg');
    

end

