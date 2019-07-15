function [ output_args ] = untitled( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    %Limpiamos todo lo que sea innecesario antes de comenzar la funcion
    clear all, close all
    %Leemos nuestra imagen con formatoc doble
    Im1=(double(imread('sangreD.jpg')))/255;
    %Guardamos y mostramos nuestra imagen original
    ImOr=Im1;
    figure (1), imshow(ImOr);
    %Transformamos nuestra imagen a escala de grises
    Im1=rgb2gray(Im1);
    %Le aplicamos una binarizacion
    Im1=imbinarize(Im1);
    %Creamos un elemento estructural para el filtrado de nuestra imagen
    %intentando eliminar las 'manchas' que hay en esta
    h=[1,1,1;0,0,0;1,1,1];
    %Aplicamos distintas funciones morfológicas buscando eliminar pequeñas
    %estructuras que nos puedan generar ruido.
    Im1=imdilate(Im1,h);
    Im1=imopen(Im1,h);
    Im1=imdilate(Im1,h);
    Im1=imclose(Im1,h);
    Im1=imerode(Im1,h);
   %Etiquetamos nuestra imagen binarizada
    [whiteMatrix, n]=bwlabel(Im1);
    %Obtenemos una segunda imagen negada
    Im2=not(Im1);
    %Etiquetamos esta segunda imagen
    [blackMatrix, n2]=bwlabel(Im2);
    %Mostramos la primera imagen etiquetada
    figure(2), imshow(whiteMatrix)
    %Obtenemos nuestros regiones y sus propiedades de la primera matriz, la
    %matriz blanca
    whiteProperties=regionprops(whiteMatrix,'all');
    %Obtenemos igualmente nuestros elementos de la matriz oscura
    blackProperties=regionprops(blackMatrix,'all');
    
    %Con estos for logramos mostrar las regiones que nuestro comando
    %encontro. En verde podemos apreciar los que encuentra en nuestra
    %matriz oscura y en azul los de la matriz clara.
    for n=1:size(blackProperties,1)
        rectangle('Position',blackProperties(n).BoundingBox,'EdgeColor','g','LineWidth',2)
    end

    for n=1:size(whiteProperties,1)
        rectangle('Position',whiteProperties(n).BoundingBox,'EdgeColor','b','LineWidth',2)
    end
    
    
    %Reinicializamos nuestros vectores para poder crear nuestras gráficas
    %de decisión
    x=0; y=0; z=0;
    %Creamos un ciclo para llenar nuestros vectores
    for k=1:size(blackProperties,1)
        x(k)=blackProperties(k).Area;
        y(k)=blackProperties(k).Perimeter;
        z(k)=blackProperties(k).MajorAxisLength;
    end
    
    %Graficamos dos de estos vectores en búsqueda de una condición que nos
    %permita separar nuestras células solitarias de las que fueron
    %segmentadas en grupos de dos o más.
    figure
    r= plot (x,y,'o');
    
    pause
    s=find([blackProperties.Area]<150);
    
    %Creamos una matriz auxiliar para poder eliminar nuestras areas
    %pequeñas y comprobar que se eliminen correctamente
    bw=Im1;
    
    %Con este ciclo eliminamos esas areas
    for n=1:size(s,2)
        d=round(blackProperties(s(n)).BoundingBox);
        bw(d(2):d(2)+d(4),d(1):d(1)+d(3))=1;
    end
    
    %Regresamos nuestra matriz ya modificada
    Im1=bw;
    
    %Repetimos nuestro proceso como si fuera nuestra primera imagen
    
    %Etiquetamos nuestra imagen binarizada
    [whiteMatrix, n]=bwlabel(Im1);
    %Obtenemos una segunda imagen negada
    Im2=not(Im1);
    %Etiquetamos esta segunda imagen
    [blackMatrix, n2]=bwlabel(Im2);
    %Mostramos la primera imagen etiquetada
    figure(2), imshow(whiteMatrix)
    %Obtenemos nuestros regiones y sus propiedades de la primera matriz, la
    %matriz blanca
    whiteProperties=regionprops(whiteMatrix,'all');
    %Obtenemos igualmente nuestros elementos de la matriz oscura
    blackProperties=regionprops(blackMatrix,'all');
    
    %Con estos for logramos mostrar las regiones que nuestro comando
    %encontro. En verde podemos apreciar los que encuentra en nuestra
    %matriz oscura y en azul los de la matriz clara.
    for n=1:size(blackProperties,1)
        rectangle('Position',blackProperties(n).BoundingBox,'EdgeColor','g','LineWidth',2)
    end

    for n=1:size(whiteProperties,1)
        rectangle('Position',whiteProperties(n).BoundingBox,'EdgeColor','b','LineWidth',2)
    end

    %Inicializamos nuestra variable de conteo
    conteo=0;
    
    %Recorreremos una a una nuestras propiedades para contar cuantas
    %células se encuentran en nuestra imagen
    for n=1:size(blackProperties,1)
        %Creamos un árbol de decisiones para encontrar áreas grandes, esto
        %con el fin de separar todas aquellas regiones con más de una
        %célula.
        if blackProperties(n).Area > 1500 || blackProperties(n).Perimeter > 149
            %El árbol de decisiones está diseñado para esta imagen y tiene
            %la finalidad de eliminar primero todas las regiones que tengan
            %unicamente dos células.
            if blackProperties(n).MajorAxisLength < 78.85
               cont=2;
            else
                if blackProperties(n).Orientation > 20
                   cont=2; 
                else
                    if blackProperties(n).Area > 2000 && blackProperties(n).Area < 3000
                        cont=2;
                    else
                        %Una vez eliminadas las celulas dobles procedemos a
                        %analizar si son 3 o 4 células
                        if blackProperties(n).MajorAxisLength > 200
                            cont=4;
                        else
                            cont=3;
                        end
                    end
                end
            end
        else
            %Si no entra en la primera condicion significa que nuestra
            %region es de una única célula
            cont=1;
        end
        %Se suma al conteo final
        conteo=conteo+cont;
        %Se reinicia la variable
        cont=0;
    end
    
    %Se muestran los resultados.
    conteo
    
end

