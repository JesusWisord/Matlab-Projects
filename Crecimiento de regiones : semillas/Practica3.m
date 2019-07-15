function [ output_args ] = untitled( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    %% Punto A - Practica 3
    %Leemos nuestra imagen DICOM
    img=dicomread('brain_014.dcm');
    %Le damos un formato doble a nuestra imagen con im2double y luego le
    %damos un ajuste
    imgp1=im2double(img);
    imgp1=imadjust(imgp1);
    %Multiplicamos pixel por pixel nuestra matriz
    imgp1=imgp1.*255;
    %Mostramos el resultado
    imshow(uint8(imgp1));
    imgp1=uint8(imgp1);
    %Guardamos el resultado
    imwrite(imgp1,'brain_014.jpg','jpg');
    
    %Prueba 2
    
    %Leemos nuestra imagen y le damos un formato doble
    imgp2=dicomread('brain_014.dcm');
    imgp2=imadjust(imgp2);
    imgp2=double(imgp2);
    
    
    %Al tener una imagen de 16 bits normalizamos dividiendo entre (2^16)-1
    imgp2=imgp2/((2^16)-1);
    
    %La imagen resultante tendra un brillo demasiado bajo, aumentamos un
    %valor de .5 para realzarla
    imgp2=imgp2+.5;
    
    %Guardamos nuestra prueba 2 para comparar resultados
    imwrite(imgp2,'brain_014_2.jpg','jpg');
    
    %% Punto B 1.1 - Practica 3
    
    %Leemos la imagen que acabamos de crear
    img=double(imread('brain_014.jpg'))/255;
    %La copiamos en una nueva variable
    img2=img;
    %Creamos otra pero "vacia" o negra
    img3=img2*0;
    %Guardamos nuestra copia 2 como 'semilleo' para poder procesarla
    imwrite(img2,'semilleo.jpg','jpg');
    %Guardamos nuestra tercera copia para observar el resultado final del
    %segmento
    imwrite(img3,'Imagen Final Semilleo 1.jpg','jpg');
    % Nuestra semilla esta en las coordenadas 112,118
    %Nuestro rango de aceptacion es de 150 a 200
    
    %Nuestras coordenadas de la semilla se guardan en una variable
    semillaOrgX=112;
    semillaOrgY=118;
    %Iremos recorriendo nuestra imagen por lo que es necesario tener en
    %cuenta en que coordenadas nos encontramos en el momento.
    xActual=118;
    yActual=112;
    %Nos iremos moviendo por esquinas en nuestra imagen por lo que
    %necesitamos un incremento para saber si cambiaremos a la esquina
    %superior izquierda o a la esquina inferior derecha.
    xInc=0;
    yInc=0;
    %Creamos una condicion logica para poder repetir el semilleo hasta que
    %ya no se encuentre ningun pixel en nuestro rango
    condicion=true;
    
    while condicion
        %Se llama a la funcion de semilleo mientras nuestra condicion sea
        %verdadera
        [condicion,xActual,yActual,xInc,yInc, img3]=semilleo(xActual,yActual,xInc,yInc);
    end
    
    %Con ayuda de la img3 y la imagen original las vamos a superponer para
    %poder apreciar el segmento que pudimos hallar con el semilleo y la
    %imagen original
    imgc=img3+img2*.5;
    imwrite(imgc,'resultado superpuesto 1.jpg', 'jpg');
    figure (1), imshow(imgc);
    
    %% Punto B 1.2
    
    %Para el segundo semilleo tomamos las coordenadas que nos mencionan en
    %la practica y creamos una segunda funcion que nos procese la tecnica
    %de semilla por vecino de la region
    %Nuestras coordenadas en imagen son 546,463 por lo que en matriz las
    %invertiremos para lograr hallar el pixel de partida
    xActual=546;
    yActual=463;
    %Nuestros incrementos iniciaran en 0
    xInc=0;
    yInc=0;
    %Creamos una condicion logica para poder repetir el semilleo hasta que
    %ya no se encuentre ningun pixel en nuestro rango
    condicion=true;
    
    %Leemos nuestra imagen y creamos las imagenes necesarias para que
    %nuestro ciclo pueda trabajar
    img_b1=imread('mdb063.pgm');
    img_b2=img_b1;
    img_b3=img_b2*0;
    imwrite(img_b2,'semilleo 2.jpg','jpg');
    imwrite(img_b3,'Imagen Final Semilleo 2.jpg','jpg');
    
    
    
    while condicion
        %Se llama a la funcion de semilleo mientras nuestra condicion sea
        %verdadera
        [condicion,xActual,yActual,xInc,yInc, img_b3]=semilleo2(xActual,yActual,xInc,yInc);
        
    end
    
    %Agregamos una pausa antes de mostrar la ultima imagen
    pause
    %Con ayuda de la img3 y la imagen original las vamos a superponer para
    %poder apreciar el segmento que pudimos hallar con el semilleo y la
    %imagen original
    imgc=img_b3+img_b2*.5;
    imwrite(imgc,'resultado superpuesto 2.jpg', 'jpg');
    figure (1), imshow(imgc);

end

