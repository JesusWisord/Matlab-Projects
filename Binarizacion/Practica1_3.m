function [ r ] = untitled( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    %Cerramos cualquier ventana de figura que pueda estar abierta en Matlab
    %para evitar confusiones
    close all;
    %El proceso inicial es leer la imagen y darle un formato doble para
    %poder manipular sus datos con mayor facilidad
    %Creamos una opci?n para cambiar de imagen 1 a imagen 2
    
    opc=input('Selecccione la imagen 1 presionando 1 o la imagen 2 presionando 1: ')
    if opc==1
        Imagen1=double(imread('Imagen1.tif'));
    else
        Imagen1=double(imread('Imagen2.tif'));
    end
    
    %Obtenemos el tama?o de nuestra imagen en dos variables distintas, una
    %para columnas, otra para renglones
    [m,n]=size(Imagen1);
    
    %Guardaremos dos patrones para poder aplicar nuestro m?todo de
    %binarizacion de densidades unimodales. Estos ser?n elegidos de la
    %imagen directamente de manera subjetiva. Una parte m?s clara y una m?s
    %obscura
    
    %Dependiendo de la imagen las ventanas de entrenamiento cambiaran.
    
    if opc==1
        %entreamiento1 es la imagen oscura
        entrenamiento1=Imagen1(459:500,241:290);
    
        %entremamiento2 es la imagen clara
        entrenamiento2=Imagen1(392:412,150:225);
    else
        %entreamiento1 es la imagen oscura
        entrenamiento1=Imagen1(251:354,104:220);
    
        %entremamiento2 es la imagen clara
        entrenamiento2=Imagen1(376:403,288:339);
    end
    
    
    %Calculamos medias y desviaciones est?ndares de ambos histogramas
    mediaEntre1=mean(mean(entrenamiento1));
    mediaEntre2=mean(mean(entrenamiento2));
    
    %Guardamos estos dos datos en un nuevo vector que posteriormente
    %devolveremos en nuestro programa
    r(1)=mediaEntre1;
    r(2)=mediaEntre2;
    
    suma1=0; suma2=0;
    
    for i=1:size(entrenamiento1,1)
        for j=1:size(entrenamiento1,2)
            suma1=suma1+(entrenamiento1(i,j)-mediaEntre1)^2;
        end
    end
    
    for i=1:size(entrenamiento2,1)
        for j=1:size(entrenamiento2,2)
            suma2=suma2+(entrenamiento2(i,j)-mediaEntre2)^2;
        end
    end
    
    desvEstanEntre1=suma1/((size(entrenamiento1,1)*size(entrenamiento1,2))-1);
    desvEstanEntre2=suma2/((size(entrenamiento2,1)*size(entrenamiento2,2))-1);
    desvEstanEntre1=sqrt(desvEstanEntre1);
    desvEstanEntre2=sqrt(desvEstanEntre2);
    
    %Suponemos que las probabilidades son iguales. P1 es la probabilidad
    %negra y P2 la probabilidad blanca.
    P1=.5; P2=P1;
    
    %Validamos que las desviaciones est?ndar sean iguales, si no lo son
    %aplicamos la siguiente f?rmula
    
    if (desvEstanEntre1 ~= desvEstanEntre2);
        desvEstan=desvEstanEntre1+desvEstanEntre2;
        desvEstan=desvEstan/2;
    else
        desvEstan=desvEstanEntre1;
    end
    
    %Igualmente la desviacion estandar es un dato que tendremos que
    %devolver
    r(3)=desvEstan;
    
    %Aplicamos nuestra f?rmula
    T1= ( (mediaEntre1+mediaEntre2)/2 ) ;
    T2= ( ((desvEstan).^2)/(mediaEntre1-mediaEntre2) )*log(P1/P2);
    T=T1+T2
    
    %Utilizamos T como umbral
    
    for i=1:m;
        for j=1:n;
            if Imagen1(i,j)>=round(T);
                binaryCalculated(i,j)=1;
            else
                binaryCalculated(i,j)=0;
            end
        end
    end
    
    
    %Mostramos nuestra primera imagen binarizada calculada 
    figure ('Name', 'Binary Image (Calculated)'), imshow(binaryCalculated)
    %La guardamos
    imwrite(binaryCalculated, 'Binary Image (Calculated).jpg', 'jpg')
    
    %Mostramos y guardamos nuestro histograma
    fig=figure('Name', 'Histogram Image (Calculated)'), histogram(binaryCalculated*255,0:255);
    hold on 'Histogram Image (Calculated)'
    figure(fig), stem(round(T),0,'blue')
    saveas(fig, 'Histogram Image (Calculated).png','png');
    
    pause
    
    %Tenemos que comprobar que las P's no sean iguales, si lo son el ciclo
    %se detiene, si no, seguir?. Si llega a 10 iteraciones igualmente
    %concluir?
    
    for aux=1:10
       
        
    %Volvemos a recalcular las probabilidades de que el pixel tenga un
    %valor 0 o 1
    
    pixeles=m*n;
    histog=imhist(binaryCalculated);
    P1_2=histog(1)/pixeles;
    P2_2=histog(256)/pixeles;
    
    %Volvemos a calcular y aplicar T para umbralizar la imagen original
    T1= ( (mediaEntre1+mediaEntre2)/2 ); 
    T2= ( ((desvEstan)^2)/(mediaEntre1-mediaEntre2) )*log(P1/P2);
    T=T1+T2
    
    
    for i=1:m;
        for j=1:n;
            if Imagen1(i,j)>T;
                binaryCalculated2(i,j)=1;
            else
                binaryCalculated2(i,j)=0;
            end
        end
    end
    
    close ('Binary Image (Calculated)')
    close ('Histogram Image (Calculated)')
    
    h= figure ('Name', 'Binary Image (Calculated)'), imshow(binaryCalculated2)
    DATOS='Binary Image (Calculated)';
    saveas(h,[DATOS,'_',num2str(aux)],'jpg')
    
    
    hist= figure('Name', 'Histogram Image (Calculated)'), histogram(binaryCalculated2,0:255);
    HISTODATOS='Histogram Image (Calculated)';
    hold on 'Histogram Image (Calculated)'
    figure(hist), stem(round(T),0,'blue')
    saveas(hist,[HISTODATOS,'_',num2str(aux)],'jpg');
    
    pause
    
    if P1~=P1_2
        P1=P1_2
        P2=P2_2
        r(4)=P1;
        r(5)=P2;
    else
        break
    end
    
        
    end

end

