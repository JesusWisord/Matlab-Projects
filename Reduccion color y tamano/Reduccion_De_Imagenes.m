function [ im2, im3, im4, im5 , im6, im7, im8, im9, im10 ] = Reduccion_De_Imagenes( input_args )
%Reduccion de imagen en potencias de 2
%   Este programa lee una imagen de 512x512 p?xeles para entregar una
%   matriz en proporcion 2:1, es decir entrega una imagen de 256x256 y de
%   esta se consigue una de 128x128 y asi sucesivamente. Por ultimo cada
%   una de estas nuevas im?genes se agranda hasta volver al tama?o original
%   obteniendo una imagen de menor calidad con cada agrandamiento.
I=imread('tarea1.jpg');
[ml,nl]=size(I); %Obtenemos el tamano en dos variables
I2=im2double(I);
im2=zeros(ml/2.^1,nl/2.^1);
im3=zeros(ml/2.^2,nl/2.^2);
im4=zeros(ml/2.^3,nl/2.^3);
im5=zeros(ml/2.^4,nl/2.^4);
im6=zeros(ml/2.^5,nl/2.^5);
im7=zeros(ml/2.^6,nl/2.^6);
im8=zeros(ml/2.^7,nl/2.^7);
im9=zeros(ml/2.^8,nl/2.^8);
im10=zeros(ml/2.^9,nl/2.^9);


for j=2:2:512; %Se recorren las columnas de 2 en 2 para eliminar nones
    for i=2:2:512; %Se recorren las filas de 2 en 2 para eliminar nones
        im2(i/2,j/2)=I2(i,j); %Se guardan las filas y columnas par en una nueva matriz
        
        if mod(i,4)==0 && mod(j,4)==0; %Se hace una comparacion para avanzar
            %de 4 en 4 por la matriz
        im3(i/4,j/4)=im2(i/2,j/2); %Se guardan para formar una 3era matriz
        %4 veces mas chica
        end
        %Cada proximo if es utilizado para saltar ciertos numeros en
        %potencias de 2 para lograr una matriz a partir de la matriz
        %anterior
        if mod(i,2.^3)==0 && mod(j,2.^3)==0;
        im4(i/2.^3,j/2.^3)=im3(i/4,j/4); 
        end
        
        if mod(i,2.^4)==0 && mod(j,2.^4)==0;
        im5(i/2.^4,j/2.^4)=im4(i/2.^3,j/2.^3); 
        end
        
        if mod(i,2.^5)==0 && mod(j,2.^5)==0;
        im6(i/2.^5,j/2.^5)=im5(i/2.^4,j/2.^4); 
        end
        
        if mod(i,2.^6)==0 && mod(j,2.^6)==0;
        im7(i/2.^6,j/2.^6)=im6(i/2.^5,j/2.^5); 
        end
        
        if mod(i,2.^7)==0 && mod(j,2.^7)==0;
        im8(i/2.^7,j/2.^7)=im7(i/2.^6,j/2.^6); 
        end
        
        if mod(i,2.^8)==0 && mod(j,2.^8)==0;
        im9(i/2.^8,j/2.^8)=im8(i/2.^7,j/2.^7); 
        end
        
        if mod(i,2.^9)==0 && mod(j,2.^9)==0;
        im10(i/2.^9,j/2.^9)=im9(i/2.^8,j/2.^8); 
        end
    end
    %Los if deben ser repetidos para saltar igualmente las columnas
    if mod(j,4)==0;
    im3(i/4,j/4)=im2(i/2,j/2);
    end
    if mod(i,2.^3)==0 && mod(j,2.^3)==0;
        im4(i/2.^3,j/2.^3)=im3(i/4,j/4); 
        end
        
        if mod(i,2.^4)==0 && mod(j,2.^4)==0;
        im5(i/2.^4,j/2.^4)=im4(i/2.^3,j/2.^3); 
        end
        
        if mod(i,2.^5)==0 && mod(j,2.^5)==0;
        im6(i/2.^5,j/2.^5)=im5(i/2.^4,j/2.^4); 
        end
        
        if mod(i,2.^6)==0 && mod(j,2.^6)==0;
        im7(i/2.^6,j/2.^6)=im6(i/2.^5,j/2.^5); 
        end
        
        if mod(i,2.^7)==0 && mod(j,2.^7)==0;
        im8(i/2.^7,j/2.^7)=im7(i/2.^6,j/2.^6); 
        end
        
        if mod(i,2.^8)==0 && mod(j,2.^8)==0;
        im9(i/2.^8,j/2.^8)=im8(i/2.^7,j/2.^7); 
        end
        
        if mod(i,2.^9)==0 && mod(j,2.^9)==0;
        im10(i/2.^9,j/2.^9)=im9(i/2.^8,j/2.^8); 
        end
    
end

aux=zeros(2..^9); %Creamos una matriz auxiliar para aumentar el tama?o de las imagenes
%Se aumenta la matriz de 256x256 a 512x512 copiando una vez cada rengl?n y
%columna
for j=2:2:2.^9;
    for i=2:2:2.^9;
        aux(i-1,j-1)=im2(i/2,j/2);
        aux(i,j-1)=im2(i/2,j/2);
        aux(i-1,j)=im2(i/2,j/2);
        aux(i,j)=im2(i/2,j/2);
    end
end 
%Se guarda la matriz
IM2=aux;
%Se reinicia la matriz para evitar trasladar valores de una a otra.
aux=zeros(2.^9);
 
%Se hace lo mismo con la siguiente matriz Se utilizan las variables
%adicionales a y b para llenar la matriz con los datos que disponemos
%de cada matriz, se van rellenando por cuadrados.
for j=2.^2:2.^2:2.^9;
    for i=2.^2:2.^2:2.^9;
        for a=0:2^2-1;
            for b=0:2^2-1;
            aux(i-a,j-b)=im3(i/2^2,j/2^2);
            end
        end
    end
end

IM3=aux;
aux=zeros(2.^9);
 
 
 
for j=2.^3:2.^3:2.^9;
    for i=2.^3:2.^3:2.^9;
        for a=0:2^3-1;
            for b=0:2^3-1;
            aux(i-a,j-b)=im4(i/2^3,j/2^3);
            end
        end
    end
end

IM4=aux;
aux=zeros(2.^9);



for j=2.^4:2.^4:2.^9;
    for i=2.^4:2.^4:2.^9;
        for a=0:2^4-1;
            for b=0:2^4-1;
            aux(i-a,j-b)=im5(i/2^4,j/2^4);
            end
        end
    end
end

IM5=aux;
aux=zeros(2.^9);


for j=2.^5:2.^5:2.^9;
    for i=2.^5:2.^5:2.^9;
        for a=0:2^5-1;
            for b=0:2^5-1;
            aux(i-a,j-b)=im6(i/2^5,j/2^5);
            end
        end
    end
end


IM6=aux;
aux=zeros(2.^9);

for j=2.^6:2.^6:2.^9;
    for i=2.^6:2.^6:2.^9;
        for a=0:2^6-1;
            for b=0:2^6-1;
            aux(i-a,j-b)=im7(i/2^6,j/2^6);
            end
        end
    end
end

IM7=aux;
aux=zeros(2.^9);



for j=2.^7:2.^7:2.^9;
    for i=2.^7:2.^7:2.^9;
        for a=0:2^7-1;
            for b=0:2^7-1;
            aux(i-a,j-b)=im8(i/2^7,j/2^7);
            end
        end
    end
end

IM8=aux;
aux=zeros(2.^9);


for j=2.^8:2.^8:2.^9;
    for i=2.^8:2.^8:2.^9;
        for a=0:2^8-1;
            for b=0:2^8-1;
            aux(i-a,j-b)=im9(i/2^8,j/2^8);
            end
        end
    end
end

IM9=aux;
aux=zeros(2.^9);



for j=2.^9:2.^9:2.^9;
    for i=2.^9:2.^9:2.^9;
        for a=0:2^9-1;
            for b=0:2^9-1;
            aux(i-a,j-b)=im10(i/2^9,j/2^9);
            end
        end
    end
end

IM10=aux;
aux=zeros(2.^9);


        
        
end