function [ proms ] = Practica1( entrenamiento1 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    %Cerramos cualquier ventana de figura que pueda estar abierta en Matlab
    %para evitar confusiones
    close all;
    %El proceso inicial es leer la imagen y darle un formato doble para
    %poder manipular sus datos con mayor facilidad
    %Creamos una validaci?n para cambiar entre una imagen y otra
    opc=input('Selecccione la imagen 1 presionando 1 o la imagen 2 presionando 1: ')
    if opc==1
        Imagen1=double(imread('Imagen1.tif'));
    else
        Imagen1=double(imread('Imagen2.tif'));
    end
    %Obtenemos el tama?o de nuestra imagen en dos variables distintas, una
    %para columnas, otra para renglones
    [m,n]=size(Imagen1)
    %Creamos y guardamos el vector del histograma en una variable nueva
    hist1=imhist(Imagen1);
    %Con este vector del histograma obtenemos los valores m?ximos y m?nimos
    %y su posici?n en el vector que representa el nivel de gris de nuestro
    %valor m?ximo y m?nimo
    [maxv,maxIdx]=max(hist1);
    [minv,minIdx]=min(hist1);
    %Obtenemos un valor promedio de estos dos valores para conseguir
    %nuestro umbral fijo 
    prom=(maxIdx+minIdx)/2;
    %Normalizamos nuestra imagen dividiendo entre 255
    Imagen1=Imagen1/255;
    
    %Recorremos pixel por pixel nuestra imagen por medio de 2 ciclos for
    for i=1:m
        for j=1:n
            %Si nuestro pixel presenta un valor mayor a nuestro umbral le
            %asignamos un valor de 1, si es menor simplemente asignaremos
            %un 0
            if Imagen1(i,j)>(prom/255)
                binary1(i,j)=1;
            else
                binary1(i,j)=0;
            end
        end
    end
    
    %Mostramos la imagen, la guardamos bajo el nombre "umbral fijo" y
    %esperamos una respuesta del usuario. Igualmente mostraremos la imagen
    %original.
    
    figure ('Name', 'Original Image'), imshow(Imagen1)
    
    figure ('Name', 'Binary Image (fixed)'), imshow(binary1)
    imwrite(binary1, 'Binary Image (fixed).jpg', 'jpg')
    
    %En conjunto mostraremos nuestro histograma con el umbral marcado en el
    fig=figure('Name', 'Histogram Image (fixed)'), histogram(binary1*255,0:255);
    hold on 'Histogram Image (fixed)'
    figure(3), stem(prom,0,'blue')
    saveas(fig, 'Histogram Image (fixed).png','png');
    
    %Agregamos una pausa para poder apreciar las imagenes
    pause
    
    %Volvemos a recorrer nuestra imagen original pixel por pixel para
    %volver a crear nuestra binarizacion, en este caso el umbral se elige
    %subjetivamente observando el histograma, escogimos un umbral de 160
    %En el caso de la imagen 2 utilizamos un umbral de 100
    if opc==1
        prom2=160;
        for i=1:m
        for j=1:n
            if Imagen1(i,j)>prom2/255
                binary2(i,j)=1;
            else
                binary2(i,j)=0;
            end
        end
        end
    else
        prom2=100
        for i=1:m
        for j=1:n
            if Imagen1(i,j)>prom2/255
                binary2(i,j)=1;
            else
                binary2(i,j)=0;
            end
        end
        end
    end
    %Cerramos nuestra imagen binarizada para mostrar la nueva
    close ('Binary Image (fixed)');
    close ('Histogram Image (fixed)');
    
    %Mostramos y guardamos la nueva imagen binarizada
    figure ('Name', 'Binary Image (subjective)'), imshow(double(binary2))
    imwrite(binary2, 'Binary Image (subjective).jpg', 'jpg')
    
    %Mostramos y guardamos nuestro histograma
    fig=figure('Name', 'Histogram Image (subjective)'), histogram(binary2*255,0:255);
    hold on 'Histogram Image (subjective)'
    figure(3), stem(prom2,0,'blue')
    saveas(fig, 'Histogram Image (subjective).png','png');
    
    %Agregamos una pausa para poder apreciar las imagenes
    pause
    
    %Mediante comandos binarizamos nuestra imagen, el primer comando sirve
    %para obtener el nivel m?s ?ptimo para binariza y luego simplemente lo
    %utilizamos con el comando im2bw
    
    %Existe un comando directo pero fue a?adido en la versi?n 2016, el
    %comando es imbinarize pero la versi?n utiliada para realizar el
    %programa es la 2015b por lo que no podemos utilizarlo.
    level=graythresh(Imagen1)
    BW=im2bw(Imagen1,level);
    imshow(BW)
    
    %Volvemos a cerrar nuestra imagen binarizada para poder ver la nueva
    %imagen binarizada
    close ('Binary Image (subjective)');
    close ('Histogram Image (subjective)');
    
    %De nuevo mostramos y guardamos nuestro resultado para poder revisarlo
    %en cualquier momento
    figure ('Name', 'Binary Image (command)'), imshow(BW)
    imwrite(BW, 'Binary Image (command).jpg', 'jpg')
    
    %Mostramos y guardamos nuestro histograma
    fig=figure('Name', 'Histogram Image (command)'), histogram(BW,0:255);
    hold on 'Histogram Image (command)'
    figure(3), stem(level*255,0,'blue')
    saveas(fig, 'Histogram Image (command).png','png');
    
    %Guardamos todos los promedios utilizados en un vector y lo devolvemos
    %en el programa.
    proms(1)=prom;
    proms(2)=prom2;
    proms(3)=level*255;
    
    end

