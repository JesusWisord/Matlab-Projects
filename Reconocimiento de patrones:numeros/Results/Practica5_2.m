function [ output_args ] = untitled( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    %Limpiamos todo lo que sea innecesario antes de comenzar la funcion
    clear all, close all
    %Leemos nuestra imagen con formato doble
    Im1=double(imread('TestTY2.jpg'));
    %Le aplicamos una binarizacion
    Im1=imbinarize(Im1);
    %Creamos un elemento estructural
    h=[1,1,1;1,1,1;1,1,1];
    %Erosionamos la imagen dos veces para lograr juntar las estructuras y
    %esto nos evite dos regiones en donde debería existir una únicamente.
    Im1=imerode(Im1,h);
    Im1=imerode(Im1,h);
    %Al final aplicamos una apertura para lograr el mismo efecto que
    %buscamos con la erosion y asi completar nuestro "filtrado"
    Im1=imopen(Im1,h);
    %Obtenemos una imagen negada de la imagen original para lograr obtener
    %las regiones de manera apropiada
    Im2=not(Im1);
    %Etiquetamos esta imagen
    [blackMatrix, n2]=bwlabel(Im2);
    %Mostramos nuestra imagen
    h= figure(1), imshow(Im1)
    %Obtenemos las propiedades de esta imagen etiquetada
    blackProperties=regionprops(blackMatrix,'all');
    %Creamos nuestras matrices de resultados
    resultsT=(blackMatrix*0)+1;
    resultsY=(blackMatrix*0)+1;
    resultselse=(blackMatrix*0)+1;

    hold on
    
    %Estas variables estan puestas unicamente para mostrar otra de las
    %propeidaes que podemos obtener con regionprops. Eje mayor y eje menor
    %que nos permiten generar una elipse.
    phi = linspace(0,2*pi,50);
    cosphi = cos(phi);
    sinphi = sin(phi);

    %Comenzamos nuestro ciclo para mostrar algunas de las propiedades que
    %regionprops nos muestra
    for k=1:size(blackProperties,1)
        %Obtenemos nuestros vectores de los puntos en extremos para
        %graficar en nuestra imagen
        x=blackProperties(k).Extrema(:,1);
        y=blackProperties(k).Extrema(:,2);
        %Graficamos nuestros puntos
        plot(x,y,'*');
        %Graficamos los rectangulos que encierran nuestros segmentos
        rectangle('Position', blackProperties(k).BoundingBox,'EdgeColor','g','LineWidth',2)
        %Igualmente obtenemos las coordenadas de cada centroide
        centerX=blackProperties(k).Centroid(1);
        centerY=blackProperties(k).Centroid(2);
        %Graficamos este centroide
        plot(centerX,centerY,'o');
        %Obtenemos la longitud de nuestros rectangulos
        lengthX=blackProperties(k).BoundingBox(3);
        lengthY=blackProperties(k).BoundingBox(4);
        %Graficamos los ejes de este rectangulo
        line ([centerX-round(lengthX/2) centerX+round(lengthX/2)],[centerY centerY], 'color', 'magenta', 'marker', 'p', 'LineStyle', '-.')
        line ([centerX centerX],[centerY-round(lengthY/2) centerY+round(lengthY/2)], 'color', 'magenta', 'marker', 'p', 'LineStyle', '-.')
        %Aqui obtenemos las variables necesarias para dibujar nuestra
        %elipse
        xbar = blackProperties(k).Centroid(1);
        ybar = blackProperties(k).Centroid(2);
        
        %Obtenemos las mitades de nuestros ejes mayor y menor
        a = blackProperties(k).MajorAxisLength/2;
        b = blackProperties(k).MinorAxisLength/2;
        
        %Obtenemos la orientacion de nuestra elipse y las demas variables
        %necesarias para conseguir dibujar nuestra elipse
        theta = pi*blackProperties(k).Orientation/180;
        R = [ cos(theta)   sin(theta)
             -sin(theta)   cos(theta)];
        xy = [a*cosphi; b*sinphi];
        xy = R*xy;
        xx = xy(1,:) + xbar;
        yx = xy(2,:) + ybar;
        
        %Finalmente dibujamos nuestra elipse
        plot(xx,yx,'r','LineWidth',2);

    end

    saveas(h,'Matriz de Prueba.jpg','jpg');
    
    %Reinicializamos nuestros vectores
    x=0; y=0; z=0;
    for k=1:size(blackProperties,1)
        x(k)=blackProperties(k).Extent;
        y(k)=blackProperties(k).MinorAxisLength;
        z(k)=blackProperties(k).Eccentricity;
    end
    
    %Graficamos dos de estos vectores en búsqueda de una condición que nos
    %permita segmentar apropiadamente nuestras regiones
    figure
    r= plot (x,z,'o')
    saveas(r,'Grafica Ext-Ecc 2.jpg','jpg')
    pause

    %Ya con estas condiciones bien definidas procedemos a segmentar
    for n=1:size(blackProperties,1)
        %Obtenemos en un vector los datos redondeados de nuestro rectangulo
        %de nuestra region
        d=round(blackProperties(n).BoundingBox);
        %Si este redonde nos causa un rebaso de nuestra matriz entonces
        %limitamos este redondeo.
        if (d(1)+d(3)>713)
            d(3)=d(3)-1;
        end
        %Obtenemos en dos variables nuestros valores que utilizaremos para
        %nuestras condiciones
        extent=blackProperties(n).Extent;
        eccent=blackProperties(n).Eccentricity
        %Creamos las condiciones apropiadas y agregamos a que amtriz se
        %copiaran los resultados
        if extent > .46
            resultselse(d(2):d(2)+d(4),d(1):d(1)+d(3))=Im1(d(2):d(2)+d(4),d(1):d(1)+d(3));
        else
            if eccent < .79 && eccent > .65 || extent < .36
            resultsY(d(2):d(2)+d(4),d(1):d(1)+d(3))=Im1(d(2):d(2)+d(4),d(1):d(1)+d(3));
            else if eccent >= .80 && eccent < .90 || extent > .36 && extent < .46
                resultsT(d(2):d(2)+d(4),d(1):d(1)+d(3))=Im1(d(2):d(2)+d(4),d(1):d(1)+d(3));
            else
                resultselse(d(2):d(2)+d(4),d(1):d(1)+d(3))=Im1(d(2):d(2)+d(4),d(1):d(1)+d(3));
            end
        end 
        end
    end
    
    %Mostramos nuestros resultados
    figure(1), imshow(resultsY)
    imwrite(resultsY,'Resultados Y Ex.jpg','jpg')
    figure(2), imshow(resultsT)
    imwrite(resultsT,'Resultados T Ex.jpg','jpg')
    figure(3), imshow(resultselse)
    imwrite(resultselse,'Resultados Else Ex.jpg','jpg')

end

