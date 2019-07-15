function [ output_args ] = untitled( input_args )
%UNTITLED Summary of this function goes here
%   Prueba de reconocimiento de patrones por rectangulos y centroides


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% Prueba de Patrones por Centroides %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Cerramos y limpiamos todo en memoria para prevenir el confundir resultados
%con algún programa anterior o simplemente para liberar memoria.
    close all, clear all, clc
    %Leemos nuestra imagen de prueba ya habiendo hecho nuestras pruebas
    %previamente.
    ImOr=double(imread('test96.bmp'));
    
    Im1=ImOr
    %La binarizamos
    Im1=imbinarize(Im1);
    %Creamos un elemento estructural para erosionar nuestra imagen y así
    %"limpiarla" un poco. Es necesario cerrar bien las estructuras y así
    %nuestro comando de regionprops pueda funcionar apropiadamente
    h=[0,1,0;1,1,1;0,1,0];
    %Aplicamos una erosión
    Im1=imerode(Im1,h);
    %Después aplicamos una apertura
    Im1=imopen(Im1,h);


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
    
    
    
    %Se puede apreciar que los numeros mas pequeños no se encuentran bien
    %definidos para poder encontrar el cuadro para diferenciar si son 6 o 9
    %por lo que buscaremos areas pequeñas de nuestra matriz para
    %eliminarlas y asi intentar que nuestra clasificacion sea lo mas
    %precisa posible.
    s=find([blackProperties.Area]<1200);
    %Creamos una matriz auxiliar para poder eliminar nuestras areas
    %pequeñas y comprobar que se eliminen correctamente
    bw=Im1;
    %Con este ciclo eliminamos esas areas
    for n=1:size(s,2)
        d=round(blackProperties(s(n)).BoundingBox);
        bw(d(2):d(2)+d(4),d(1):d(1)+d(3))=1;
    end
    %Mostramos el resultado y si es apropiado procedemos a guardarlo, si no
    %fuese asi podemos cambiar el area a buscar y volver a procesar la
    %imagen
    imshow(bw);
    %Volvemos esta matriz nuestra matriz original
    Im1=bw;
    %Y volvemos a repetir el proceso de etiquetado y sacar las propiedades
    %de cada una de las matrices, la oscura y la clara.
    [whiteMatrix, n]=bwlabel(Im1);
    Im2=not(Im1);
    [blackMatrix, n2]=bwlabel(Im2);
    figure(1), imshow(whiteMatrix)
    whiteProperties=regionprops(whiteMatrix,'all');
    whiteProperties(1)=[];
    blackProperties=regionprops(blackMatrix,'all');
    resultsNine=(whiteMatrix*0)+1;
    resultsSix=(whiteMatrix*0)+1;
    hold on

    %Volvemos a mostrar la imagen con los recuadros de las areas que
    %encontro nuestro programa
    for n=1:size(blackProperties,1)
        rectangle('Position',blackProperties(n).BoundingBox,'EdgeColor','g','LineWidth',2)
        plot(blackProperties(n).Centroid(1),blackProperties(n).Centroid(2),'*')
    end

    for n=1:size(whiteProperties,1)
        rectangle('Position',whiteProperties(n).BoundingBox,'EdgeColor','b','LineWidth',2)
        plot(whiteProperties(n).Centroid(1),whiteProperties(n).Centroid(2),'o')
    end
    
    
    
    %Con una nueva matriz llamada CentroidBlack obtendremos los siguientes
    %datos en cada renglon. Primero es la coordenada en X del centroide de
    %la region, el siguiente es la coordenada en Y del mismo centroide.
    %Despues conseguiremos la coordenada en X de donde comienza el
    %rectangulo que encierra nuestra region, luego la coordenada en Y del
    %mismo rectangulo. El siguiente numero es la longitud en X del
    %rectangulo y al final tenemos la longitud en Y del mismo rectangulo.
    for aux=1:size(blackProperties,1)
    CentroidBlack(aux,1)=blackProperties(aux).Centroid(1);
    CentroidBlack(aux,2)=blackProperties(aux).Centroid(2);
    CentroidBlack(aux,3)=blackProperties(aux).BoundingBox(1);
    CentroidBlack(aux,4)=blackProperties(aux).BoundingBox(2);
    CentroidBlack(aux,5)=blackProperties(aux).BoundingBox(3);
    CentroidBlack(aux,6)=blackProperties(aux).BoundingBox(4);
    end
    
    %Se repite el proceso para la matriz blanca
    for aux=1:size(whiteProperties,1)
    CentroidWhite(aux,1)=whiteProperties(aux).Centroid(1);
    CentroidWhite(aux,2)=whiteProperties(aux).Centroid(2);
    CentroidWhite(aux,3)=whiteProperties(aux).BoundingBox(1);
    CentroidWhite(aux,4)=whiteProperties(aux).BoundingBox(2);
    CentroidWhite(aux,5)=whiteProperties(aux).BoundingBox(3);
    CentroidWhite(aux,6)=whiteProperties(aux).BoundingBox(4);
    CentroidWhite(aux,7)=whiteProperties(aux).Area;
    end
    
    %Como no podemos saber como se van encontrando las regiones es
    %necesario ordenarlas para poder estar seguros que van juntas en cuanto
    %a coordenadas. Para eso usamos este comando sort para ordenar una
    %columna de la matriz y de ahi ordenar lo demas. Ordenamos la
    %coordenada en X del centroide en ambas matrices creando asi una nueva
    %matriz ordenada llamada Black and White, cada una perteneciente a la
    %matriz oscura y clara respectivamente.
    [Black,k] = sort(CentroidBlack(:,1));
    Black = [Black CentroidBlack(k,2)  CentroidBlack(k,3) CentroidBlack(k,4) CentroidBlack(k,5) CentroidBlack(k,6)];

    [White,k] = sort(CentroidWhite(:,1));
    White = [White CentroidWhite(k,2) CentroidWhite(k,3) CentroidWhite(k,4) CentroidWhite(k,5) CentroidWhite(k,6)];

    %Comenzamos nuestro ciclo para clasificar los 6 y 9
    for n=1:size(CentroidWhite,1)
        %Congelamos la imagen para poder mostrar nuestra clasificacion
        hold on
        %Obtenemos las coordenadas de la matriz oscura en dos variables
        blackX=Black(n,1);
        blackY=Black(n,2);
        %Las graficamos con un asterisco en la misma imagen
        plot(blackX,blackY,'*');
        %Repetimos el proceso con las coordenadas de la matriz clara
        whiteX=White(n,1);
        whiteY=White(n,2);
        %De la misma manera las graficamos en la imagen. Aqui ya podemos
        %apreciar como se clasifiracan los numeros. Si el asterisco esta
        %mas arriba que la esfera entonces es un 9, si es al reves es un 6.
        plot(whiteX,whiteY,'o');
        %Obtenemos las coordenadas del rectangulo que rodea nuestro
        %elemento en una nueva variable
        d=round(Black(n,:));
        %Este auxS es para evitar utilizar los dos primeros numeros que se
        %refieren a las coordenadas del centroide
        auxS=2;
        %Si el asterisco es mas alto que la esfera entonces tenemos un 9 
        if (blackY > whiteY) 
            %Esto unicamente es para copiar el rectangulo de la region que
            %encontro regionprops en nuestra matriz de resultados
            resultsNine(d(auxS+2):d(auxS+2)+d(auxS+4),d(auxS+1):d(auxS+1)+d(auxS+3))=Im1(d(auxS+2):d(auxS+2)+d(auxS+4),d(auxS+1):d(auxS+1)+d(auxS+3));
            %Si en cambio la esfera es mas alta que el asterisco entonces
            %es un 6
        else if (blackY < whiteY) 
            %Igualmente copiamos el rectangulo de la region en nuestra
            %matriz de resultados.
            resultsSix(d(auxS+2):d(auxS+2)+d(auxS+4),d(auxS+1):d(auxS+1)+d(auxS+3))=Im1(d(auxS+2):d(auxS+2)+d(auxS+4),d(auxS+1):d(auxS+1)+d(auxS+3));
            end
        end

    end
    
    %Mostramos nuestros resultados
    figure(2), imshow(resultsNine)
    figure(3), imshow(resultsSix)    

    pause    
    close all, clear all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% Prueba de Patrones por Extrema %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
%Volvemos a leer nuestra imagen para repetir el proceso de nuevo
    Im1=ImOr;
%Aplicamos binarizacion a nuestra imagen
    Im1=imbinarize(Im1);
    %Pre-procesamos nuestra imagen para limpiarla de posible ruido. Esto es
    %cerrar las estructuras para que puedan ser detectadas como una unica
    %estructura y no como dos separadas
    h=[0,1,0;1,1,1;0,1,0];
    Im1=imerode(Im1,h);
    Im1=imopen(Im1,h);
%Creamos nuestras matrices de resultados
    results=(Im1*0)+1;
    results2=results;
    results3=results;
%Etiquetamos nuestras imagenes tanto la original como una segunda pero
%negada
    [whiteMatrix, n]=bwlabel(Im1);
    Im2=not(Im1);
    [blackMatrix, n2]=bwlabel(Im2);
    %Mostramos nuestra imagen mas clara para apreciar los resultados
    h=figure(1), imshow(whiteMatrix)
    %Aplicamos el comando de regionprops para obtener nuestras regiones y
    %sus propiedades
    whiteProperties=regionprops(whiteMatrix,'all');
    %Eliminamos el primer elemento de esta ya que este nos detecta el fondo
    %como un elemento
    whiteProperties(1)=[];
    %Igualmente hacemos esto con nuestra matriz oscura para obtener otros
    %elementos que nos pueden servir mas adelante
    blackProperties=regionprops(blackMatrix,'all');
    %Creamos nuestra matriz de resultados
    results=(whiteMatrix*0)+1;
    %Aplicamos un hold on para poder 'pintar' sobre nuestra imagen
    hold on
    
    %creamos vectores que nos ayuden a contar cuantos "vertices" de nuestra
    %imagen estan por arriba o por debajo del centro, igualmente cuantos a
    %la derecha o a izquierda del centro.
    upper=zeros(1,size(blackProperties,1));
    down=upper
    left=upper;
    right=upper;
%Comenzamos nuestro ciclo por cada elemento encontrado y con esto
%dibujaremos todas las propiedades que utilizaremos
    for k = 1:length(blackProperties)
        %Obtenemos las coordenadas de nuestros extremos en dos vectores que
        %posteriormente vamos a graficar en la imagen
        x=blackProperties(k).Extrema(:,1);
        y=blackProperties(k).Extrema(:,2);
        plot(x,y,'*');
        %Creamos un rectangulo que nos muestre la region que estamos
        %analizando
        rectangle('Position', blackProperties(k).BoundingBox,'EdgeColor','g','LineWidth',2)
        %Obtenemos en dos variables el centroide de nuestra region
        centerX=blackProperties(k).Centroid(1);
        centerY=blackProperties(k).Centroid(2);
        %Igualmente la graficaremos
        plot(centerX,centerY,'o');
        %Obtenemos el largo y ancho de nuestro 'caja' que encierra nuestra
        %region
        lengthX=blackProperties(k).BoundingBox(3);
        lengthY=blackProperties(k).BoundingBox(4);
        %Creamos dos lineas que crucen por el centroide de nuestra region
        %para asi graficar nuestros ejes
        line ([centerX-round(lengthX/2) centerX+round(lengthX/2)],[centerY centerY], 'color', 'magenta', 'marker', 'p', 'LineStyle', '-.')
        line ([centerX centerX],[centerY-round(lengthY/2) centerY+round(lengthY/2)], 'color', 'magenta', 'marker', 'p', 'LineStyle', '-.')
        %Con esto contaremos cuales de nuestros extremos estan arriba o
        %abajo y a la derecha o izquierda.
        for c=1:8
            if x(c) >= centerX
                upper(k)=upper(k)+1;
            else
                down(k)=down(k)+1;
            end
            if y(c) >= centerY
                right(k)=right(k)+1;
            else
                left(k)=left(k)+1;
            end
        end
    end
    

    %Comenzamos un nuevo ciclo, esta vez para clasificar
    for c=1:length(blackProperties)
        %Obtenemos las coordenadas del rectangulo a copiar de las
        %propiedades previamente obtenidas
        d=round(blackProperties(c).BoundingBox);
        %Al utilizar el mismo ciclo anterior lo tenemos que adecuar
        %haciendo esta variable 0
        auxS=0;
        %Ahora si tenemos que hay mas "extremos" abajo que arriba hablamos
        %de 9
        if down(c) > upper (c)
            results(d(auxS+2):d(auxS+2)+d(auxS+4),d(auxS+1):d(auxS+1)+d(auxS+3))=Im1(d(auxS+2):d(auxS+2)+d(auxS+4),d(auxS+1):d(auxS+1)+d(auxS+3));
        %En cambio si hay mas arriba que abajo entonces es un 6
        else if down(c) < upper (c)
            results2(d(auxS+2):d(auxS+2)+d(auxS+4),d(auxS+1):d(auxS+1)+d(auxS+3))=Im1(d(auxS+2):d(auxS+2)+d(auxS+4),d(auxS+1):d(auxS+1)+d(auxS+3));
            %Si resultan iguales se procede a verificar los lados.
            %Igualmente si hay mas en la derecha que en la izquierda es un
            %6
            else if right(c) > left(c)
                    results2(d(auxS+2):d(auxS+2)+d(auxS+4),d(auxS+1):d(auxS+1)+d(auxS+3))=Im1(d(auxS+2):d(auxS+2)+d(auxS+4),d(auxS+1):d(auxS+1)+d(auxS+3));
                %Si hay mas en izquierda que en derecha es un 9
                else if right(c) < left(c)
                        results(d(auxS+2):d(auxS+2)+d(auxS+4),d(auxS+1):d(auxS+1)+d(auxS+3))=Im1(d(auxS+2):d(auxS+2)+d(auxS+4),d(auxS+1):d(auxS+1)+d(auxS+3));
                    else
                        %Si existieran otros patrones que no concuerdan con
                        %estas caracteristicas en teoria no es ni 6 ni 9
                        %por lo tanto lo guardamos en una nueva matriz
                        results3(d(auxS+2):d(auxS+2)+d(auxS+4),d(auxS+1):d(auxS+1)+d(auxS+3))=Im1(d(auxS+2):d(auxS+2)+d(auxS+4),d(auxS+1):d(auxS+1)+d(auxS+3));
                    end
                end 
            end
        end
    end

    %Mostramos nuestros resultados
    figure(1), imshow(results)
    figure(2), imshow(results2)
    figure(3), imshow(results3)



end

