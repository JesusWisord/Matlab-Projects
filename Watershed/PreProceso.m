function [ imagen1 ] = untitled( imagenOriginal )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    %Obtenemos el tama?o de la imagen en dos variables
    [m,n,z]=size(imagenOriginal);
    %Obtenemos nuestras ventanas de entrenamiento. Iremos de la mas oscura
    %a la mas clara siendo la 1 negra y la 4 blanca.
    im1=imcrop(imagenOriginal);
    im2=imcrop(imagenOriginal);
    im3=imcrop(imagenOriginal);
    im4=imcrop(imagenOriginal);
    %Calculamos las medias de cada uno de nuestras ventanas y lo
    %redondeamos para guardarlas en una nueva variable.
    mean1=round(mean(mean(im1))*255);
    mean2=round(mean(mean(im2))*255);
    mean3=round(mean(mean(im3))*255);
    mean4=round(mean(mean(im4))*255);
    %Al ser nuestra primera iteraci?n nuestras probabilidades ser?n 
    P1=1/4;
    P2=1/4;
    P3=1/4;
    P4=1/4;
    %Calculamos las distancias entre nuestras medias

    s1=mean2-mean1;
    s2=mean3-mean2;
    s3=mean4-mean3;
    
    %Obtenemos variables para implementar los umbrales de manera mas
    %sencilla
    umbral1=round(mean1+s1/2);
    umbral2=round(mean2+s2/2);
    umbral3=round(mean3+s3/2);
    
    %Aplicamos el umbral con las mismas probabilidades a nuestra imagen
    for i=1:m
        for j=1:n
            if imagenOriginal(i,j,1)<umbral1/255
                imagen1(i,j)=mean1;
            elseif imagenOriginal(i,j,1)<umbral2/255
                imagen1(i,j)=mean2;
            elseif imagenOriginal(i,j,1)<umbral3/255
                imagen1(i,j)=mean3;
            else
                imagen1(i,j)=mean4;
            end
        end
    end
    
    
    %Antes de continuar con la segmentaci?n propiamente dicha y las
    %siguientes iteraciones crearemos una grafica que ilustre nuestras
    %medias y sus respectivas probabilidades para su asignacion
    

    
    
end
