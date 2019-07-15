    %Limpiamos todo lo que sea innecesario antes de comenzar la funcion
    clear all, close all
    %Leemos nuestra imagen con formato doble
    Im1=(double(imread('sangreD.jpg')))/255;
    ImOr=Im1;
    Im1=rgb2gray(Im1);
    %Le aplicamos una binarizacion
    Im1=imbinarize(Im1);
    h=[1,1,1;0,0,0;1,1,1];
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
    figure(1), imshow(whiteMatrix)
    %Obtenemos nuestros regiones y sus propiedades de la primera matriz, la
    %matriz blanca
    whiteProperties=regionprops(whiteMatrix,'all');
    %Eliminamos el primer elemento de estas regiones ya que este primer
    %elemento representa el fondo y solo nos genera conflicto a la hora de
    %intentar reconocer los numeros.
    whiteProperties(1)=[];
    %Obtenemos igualmente nuestros elementos de la matriz oscura
    blackProperties=regionprops(blackMatrix,'all');
    %Creamos dos matrices llenas de "unos" para guardar aqui nuestros
    %resultados
    resultsNine=(whiteMatrix*0)+1;
    resultsSix=(whiteMatrix*0)+1;
    
    %Con estos for logramos mostrar las regiones que nuestro comando
    %encontro. En verde podemos apreciar los que encuentra en nuestra
    %matriz oscura y en azul los de la matriz clara.
    for n=1:size(blackProperties,1)
        rectangle('Position',blackProperties(n).BoundingBox,'EdgeColor','g','LineWidth',2)
    end

    for n=1:size(whiteProperties,1)
        rectangle('Position',whiteProperties(n).BoundingBox,'EdgeColor','b','LineWidth',2)
    end
    
    pause
    
    %Reinicializamos nuestros vectores
    x=0; y=0; z=0;
    for k=1:size(blackProperties,1)
        x(k)=blackProperties(k).Area;
        y(k)=blackProperties(k).Perimeter;
        z(k)=blackProperties(k).MajorAxisLength;
    end
    
    %Graficamos dos de estos vectores en búsqueda de una condición que nos
    %permita segmentar apropiadamente nuestras regiones
    figure
    r= plot (x,y,'o');
    
    s=find([blackProperties.Area]<150);
    %Creamos una matriz auxiliar para poder eliminar nuestras areas
    %pequeñas y comprobar que se eliminen correctamente
    bw=Im1;
    %Con este ciclo eliminamos esas areas
    for n=1:size(s,2)
        d=round(blackProperties(s(n)).BoundingBox);
        bw(d(2):d(2)+d(4),d(1):d(1)+d(3))=1;
    end
    
    Im1=bw;
    %Etiquetamos nuestra imagen binarizada
    [whiteMatrix, n]=bwlabel(Im1);
    %Obtenemos una segunda imagen negada
    Im2=not(Im1);
    %Etiquetamos esta segunda imagen
    [blackMatrix, n2]=bwlabel(Im2);
    %Mostramos la primera imagen etiquetada
    figure(1), imshow(whiteMatrix)
    %Obtenemos nuestros regiones y sus propiedades de la primera matriz, la
    %matriz blanca
    whiteProperties=regionprops(whiteMatrix,'all');
    %Eliminamos el primer elemento de estas regiones ya que este primer
    %elemento representa el fondo y solo nos genera conflicto a la hora de
    %intentar reconocer los numeros.
    whiteProperties(1)=[];
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
%     aux=0;
%     for n=1:size(blackProperties,1)
%         if blackProperties(n).Area > 1500 || blackProperties(n).Perimeter > 149
%             aux=aux+1;
%             figure(3), imshow(not(blackProperties(n).Image))
%             blackProperties(n).Area 
%             blackProperties(n).MajorAxisLength
%             blackProperties(n).Perimeter
%             result(aux,:)=blackProperties(n);
%             pause
%         end
%     end

    conteo=0;
    
    for n=1:size(blackProperties,1)
        if blackProperties(n).Area > 1500 || blackProperties(n).Perimeter > 149
%             imshow(blackProperties(n).Image)
%             pause
            if blackProperties(n).MajorAxisLength < 78.85
               cont=2;
            else
                if blackProperties(n).Orientation > 20
                   cont=2; 
                else
                    if blackProperties(n).Area > 2000 && blackProperties(n).Area < 3000
                        cont=2;
                    else
                        if blackProperties(n).MajorAxisLength > 200
                            cont=4;
                        else
                            cont=3;
                        end
                    end
                end
            end
        else
            cont=1;
        end
        conteo=conteo+cont;
        cont=0;
    end
    
    conteo
    