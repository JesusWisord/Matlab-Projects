function [ Porcentajes ] = untitled( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    Porcentajes=zeros(2,24);
    %Leemos nuestra imagen en formato doble y normalizada
    imagenOriginal=double(imread('mri200.jpg'))/255;
    %Obtenemos el tama?o de la imagen en dos variables
    [m,n,z]=size(imagenOriginal);
    %Mostramos nuestra imagen con nuestras ventanas mostradas, cada una con
    %un color distinto
    figure(1), imshow(imagenOriginal);
    hold on
    line ([1 76],[1 76], 'color', 'magenta', 'marker', 'p', 'LineStyle', '-.')
    line ([140 165],[358 369], 'color', 'red', 'marker', 'p', 'LineStyle', '-.')
    line ([230 273],[108 135], 'color', 'cyan', 'marker', 'p', 'LineStyle', '-.')
    line ([201 222],[255 281], 'color', 'green', 'marker', 'p', 'LineStyle', '-.')
    %Obtenemos nuestras ventanas de entrenamiento. Iremos de la mas oscura
    %a la mas clara siendo la 1 negra y la 4 blanca.
    im1=imagenOriginal(1:76,1:76);
    im2=imagenOriginal(108:135,230:273);
    im3=imagenOriginal(255:281,201:222);
    im4=imagenOriginal(358:369,140:165);
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
    
    %Mostramos nuestra imagen resultante en un pseudocolor para poder
    %apreciar los 4 colores distintos facilmente
    figure (2), imshow(imagen1/255)
    saveas(figure (2),'GrayScale 1.jpg', 'jpg');
    zoom1=imagen1(400:500,100:200);
    figure(3), imshow(zoom1/255);
    saveas(figure (3),'GrayScale 100x100.jpg','jpg');
    % pause
    %Antes de continuar con la segmentaci?n propiamente dicha y las
    %siguientes iteraciones crearemos una grafica que ilustre nuestras
    %medias y sus respectivas probabilidades para su asignacion
    
     %Comenzaremos calculando nuestros valores para la primera media
    %Necesitamos vectores de x ^ y
    
    med(1)=mean1+(s1*.25);
    med(2)=mean1+(s1*.75);
    med(3)=mean2+(s2*.25);
    med(4)=mean2+(s2*.75);
    med(5)=mean3+(s3*.25);
    med(6)=mean3+(s3*.75);
    
    for x=1:256
        %Esta parte calculara la y para nuestra primera media
        if x<=(round(med(1)))
            y1(x)=1;
        elseif x<=(round(med(2)))
            y1(x)=( med(2)-x ) / ( med(2)-med(1) )
        else
            y1(x)=0;
        end
        
        %Esta parte calcula y para la segunda media
        if x>(round(med(1))) && x<=(round(med(2)))
            y2(x)=(x-med(1)) / (med(2)-med(1));
        elseif x<(round(med(3))) && x>(round(med(2)))
            y2(x)=1;
        elseif x<=(round(med(4))) && x>(round(med(2)))
            y2(x)=( med(4)-x ) / ( med(4)-med(3) );
            
        else
            y2(x)=0;
        end
        
        %Esta parte calcula y para la tercera media
        if x>(round(med(3))) && x<=(round(med(4)))
            y3(x)=(x-med(3)) / (med(4)-med(3));
        elseif x<(round(med(5))) && x>(round(med(4)))
            y3(x)=1;
        elseif x<=(round(med(6))) && x>(round(med(4)));
            y3(x)=( med(6)-x ) / ( med(6)-med(5) );
            
        else
            y3(x)=0;
        end
        
        %Esta parte calcula y para la cuarta media
        if x>(round(med(5))) && x<=(round(med(6)));
            y4(x)=(x-med(5)) / (med(6)-med(5));
        elseif x>(round(med(6)))
            y4(x)=1
        else
            y4(x)=0;
        end
        
        if y1(x)>1
            y1(x)=1;
        end
        if y2(x)>1
            y2(x)=1;
        end
        if y3(x)>1
            y3(x)=1;
        end
        if y4(x)>1
            y4(x)=1;
        end
        if y1(x)<0
            y1(x)=0;
        end
        if y2(x)<0
            y2(x)=0;
        end
        if y3(x)<0
            y3(x)=0;
        end
        if y4(x)<0
            y4(x)=0;
        end
    end
    x=1:256;
    p=figure('Name' , 'Grafica'), plot(x,y1,'r',x,y2,'c', x, y3, 'b',x,y4,'black');
    saveas(p,'Grafica.jpg','jpg');
    
    histog=imhist(imagen1/255);
    P1=histog(mean1+1)/(m*n)
    P2=histog(mean2+1)/(m*n)
    P3=histog(mean3+1)/(m*n)
    P4=histog(mean4+1)/(m*n)
    
    Porcentajes(1,1)=mean1;
    Porcentajes(2,1)=mean2;
    Porcentajes(3,1)=mean3;
    Porcentajes(4,1)=mean4;
    Porcentajes(1,2)=P1*100;
    Porcentajes(2,2)=P2*100;
    Porcentajes(3,2)=P3*100;
    Porcentajes(4,2)=P4*100;
    
    
    for z=1:5;
        %Obtenemos un vector con los valores de nuestra imagen para poder
        %actualizar nuestras probabilidades
        histog=imhist(imagen1/255);

        %Recalculamos nuestras probabilidades. Recordemos que nuestros valores
        %van de 0 a 255 pero nuestro vector va de 1 a 256 por lo que es
        %necesario sumar (+1) al vector para asi obtener el valor correcto en
        %el vector
        P1=histog(mean1+1)/(m*n)
        P2=histog(mean2+1)/(m*n)
        P3=histog(mean3+1)/(m*n)
        P4=histog(mean4+1)/(m*n)

        %Con nuestras probabilidades volveremos a binarizar. Para esto
        %necesitamos recalcular nuestros umbrales y para esto necesitamos una
        %nueva proporcion de nuestras distancias. 

        Prop1=(P1/P2)/2;
        Prop2=(P2/P3)/2;
        Prop3=(P3/P4)/2;
        
        if (Prop1>1)
            Prop1=1;
        end
        if (Prop2>1)
            Prop2=1;
        end
        if (Prop3>1)
            Prop3=1;
        end


        umbral1=round(mean1+s1/4+(Prop1*s1/2));
        umbral2=round(mean2+s2/4+(Prop2*s2/2));
        umbral3=round(mean3+s3/4+(Prop3*s3/2));

        %Aplicamos la binarizacion nuevamente

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

        %Mostramos nuestra imagen resultante en un pseudocolor para poder
        %apreciar los 4 colores distintos facilmente
        h=figure (3), imshow(imagen1/255)
        DATOS='Grayscale';
        saveas(h,[DATOS,'_',num2str(z+1)],'jpg')
        DATOS2='Grayscale 100x100'
        zoom1=imagen1(400:500,100:200);
        h2=figure(3), imshow(zoom1/255);
        saveas(h2,[DATOS2,'_',num2str(z+1)],'jpg');
        % pause
        Porcentajes(1+(z*4),1)=mean1;
        Porcentajes(2+(z*4),1)=mean2;
        Porcentajes(3+(z*4),1)=mean3;
        Porcentajes(4+(z*4),1)=mean4;
        Porcentajes(1+(z*4),2)=P1*100;
        Porcentajes(2+(z*4),2)=P2*100;
        Porcentajes(3+(z*4),2)=P3*100;
        Porcentajes(4+(z*4),2)=P4*100;
    end
    
end

