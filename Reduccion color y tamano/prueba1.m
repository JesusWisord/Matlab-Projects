function [ ] = untitled2( input_args )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
I=imread('tarea1.jpg');
[ml,nl]=size(I); %Obtenemos el tama?o en dos variables
I2=im2double(I);
im2=zeros(ml/2^1,nl/2^1);
im3=zeros(ml/2^2,nl/2^2);
im4=zeros(ml/2^3,nl/2^3);
im5=zeros(ml/2^4,nl/2^4);
im6=zeros(ml/2^5,nl/2^5);
im7=zeros(ml/2^6,nl/2^6);
im8=zeros(ml/2^7,nl/2^7);
im9=zeros(ml/2^8,nl/2^8);
im10=zeros(ml/2^9,nl/2^9);

figure (1), imshow(I2);

%imagesc(I2), colormap gray;
for j=2:2:512; %Se recorren las columnas de 2 en 2 para eliminar nones
    for i=2:2:512; %Se recorren las filas de 2 en 2 para eliminar nones
        im2(i/2,j/2)=I2(i,j); %Se guardan las filas y columnas par en una nueva matriz
        
        if mod(i,2)==0 && mod(j,2)==0; %Se hace una comparacion para avanzar de 4 en 4 por la matriz
        im3(i/2,j/2)=im2(i,j); %Se guardan para formar una 3era matriz 4 veces m?s chica
        end
        
        if mod(i,2^3)==0 && mod(j,2^3)==0;
        im4(i/2^3,j/2^3)=I2(i,j); 
        end
        
        if mod(i,2^4)==0 && mod(j,2^4)==0;
        im5(i/2^4,j/2^4)=I2(i,j); 
        end
        
        if mod(i,2^5)==0 && mod(j,2^5)==0;
        im6(i/2^5,j/2^5)=I2(i,j); 
        end
        
        if mod(i,2^6)==0 && mod(j,2^6)==0;
        im7(i/2^6,j/2^6)=I2(i,j); 
        end
        
        if mod(i,2^7)==0 && mod(j,2^7)==0;
        im8(i/2^7,j/2^7)=I2(i,j); 
        end
        
        if mod(i,2^8)==0 && mod(j,2^8)==0;
        im9(i/2^8,j/2^8)=I2(i,j); 
        end
        
        if mod(i,2^9)==0 && mod(j,2^9)==0;
        im10(i/2^9,j/2^9)=I2(i,j); 
        end
    end
    
    if mod(j,4)==0;
    im3(i/4,j/4)=I2(i,j);
    end
    if mod(i,2^3)==0 && mod(j,2^3)==0;
    im4(i/2^3,j/2^3)=I2(i,j); 
    end
    if mod(i,2^4)==0 && mod(j,2^4)==0;
    im5(i/2^4,j/2^4)=I2(i,j); 
    end
        
    if mod(i,2^5)==0 && mod(j,2^5)==0;
    im6(i/2^5,j/2^5)=I2(i,j); 
    end
        
    if mod(i,2^6)==0 && mod(j,2^6)==0;
    im7(i/2^6,j/2^6)=I2(i,j); 
    end
        
    if mod(i,2^7)==0 && mod(j,2^7)==0;
    im8(i/2^7,j/2^7)=I2(i,j); 
    end
        
    if mod(i,2^8)==0 && mod(j,2^8)==0;
    im9(i/2^8,j/2^8)=I2(i,j); 
    end
        
    if mod(i,2^9)==0 && mod(j,2^9)==0;
    im10(i/2^9,j/2^9)=I2(i,j); 
    end
    
end
figure(2), imshow(im2);
figure(3), imshow(im9);
figure(4), imshow(im10);
end

