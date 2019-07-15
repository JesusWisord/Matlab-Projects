function [ condicion,x, y, xinc, yinc, img2 ] = untitled( x,y,xinc,yinc )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    %% Leemos nuestras dos imagenes en formato doble y normalizadas
    img=(imread('semilleo 2.jpg'));
    img2=(imread('Imagen Final Semilleo 2.jpg'));

    %% Esquina superior izquierda
    % Esta parte trabajara con la esquina superior izquierda de nuestro
    % pixel cuando el incremento sea igual o mayor a uno. Partiendo de este
    % pixel analizaremos uno a uno los pixeles hacia arriba, hacia abajo,
    % hacia la izquierda y hacia la derecha

    % Al incio de cada ciclo reiniciamos nuestras variables
    auxX=x-xinc;
    auxY=y-yinc;
    %Mientras el pixel a analizar este en nuestro rango el ciclo se
    %repetira
    %Nuestro rango en esta tecnica sera de mas menos 10 
    limSup=img(auxX,auxY)+5;
    limInf=img(auxX,auxY)-5;
    
    while img(auxX,auxY) >= limInf  && img(auxX,auxY) <= limSup
       %Como esta dentro de nuestro rango se asigna un valor de 200 a este
       %pixel en la imagen de resultado
        img2(auxX,auxY)=200;
        %Y se recorre la imagen a la derecha por medio de la variable X
        auxX=auxX+1;
        limSup=img(auxX,auxY)+5;
        limInf=img(auxX,auxY)-5;
    end
    
    %Se reinicializan las variables y se repite el proceso
    auxX=x-xinc;
    auxY=y-yinc;
    while img(auxX,auxY) >= limInf  && img(auxX,auxY) <= limSup
       
        img2(auxX,auxY)=200;
        %En este caso partimos del pixel inicial y recorremos a la
        %izquierda
        auxX=auxX-1;
        limSup=img(auxX,auxY)+5;
        limInf=img(auxX,auxY)-5;
        
    end
    
    %Volvemos a reiniciar nuestras coordenadas
    auxX=x-xinc;
    auxY=y-yinc;
    while img(auxX,auxY) >= limInf  && img(auxX,auxY) <= limSup
       
        img2(auxX,auxY)=200;
        %Recorremos la imagen ahora hacia abajo
        auxY=auxY+1;
        limSup=img(auxX,auxY)+5;
        limInf=img(auxX,auxY)-5;
        
    end
    
    %Reinicializamos una ultima vez
    auxX=x-xinc;
    auxY=y-yinc;
    while img(auxX,auxY) >= limInf  && img(auxX,auxY) <= limSup
       
        img2(auxX,auxY)=200;
        %Y recorremos la imagen hacia arriba
        auxY=auxY-1;
        limSup=img(auxX,auxY)+5;
        limInf=img(auxX,auxY)-5;   
        
    end
    
    %% Esquina inferior derecha
    
    %Sera el mismo proceso pero ahora nuestro pixel inicial sera la esquina
    %superior derecha. Mismos pasos de reiniciar y mismos incrementos para
    %recorrer la imagen hacia arriba, abajo, izquierda y derecha.
    
    
    auxX=x+xinc;
    auxY=y+yinc;
    while img(auxX,auxY) >= limInf  && img(auxX,auxY) <= limSup
       
        img2(auxX,auxY)=200;
        auxX=auxX+1;
        limSup=img(auxX,auxY)+5;
        limInf=img(auxX,auxY)-5;
    end
    
    auxX=x+xinc;
    auxY=y+yinc;
    while img(auxX,auxY) >= limInf  && img(auxX,auxY) <= limSup
       
        img2(auxX,auxY)=200;
        auxX=auxX-1;
        limSup=img(auxX,auxY)+5;
        limInf=img(auxX,auxY)-5;
        
    end
    
    auxX=x+xinc;
    auxY=y+yinc;
    while img(auxX,auxY) >= limInf  && img(auxX,auxY) <= limSup
       
        img2(auxX,auxY)=200;
        auxY=auxY+1;
        limSup=img(auxX,auxY)+5;
        limInf=img(auxX,auxY)-5;
        
    end
    
    auxX=x+xinc;
    auxY=y+yinc;
    while img(auxX,auxY) >= limInf  && img(auxX,auxY) <= limSup
       
        img2(auxX,auxY)=200;
        auxY=auxY-1;
        limSup=img(auxX,auxY)+5;
        limInf=img(auxX,auxY)-5;
        
    end
    
    
    %% Se analizan las proximas esquinas
    
    %Si las proximas esquinas no cumplen la condicion de estar dentro de
    %nuestro rango entonces la condicion se vuelve falsa y se termina el
    %ciclo de semilleo
    
    if img(x-xinc,y-yinc) >= limInf  && img(x-xinc,y-yinc) <= limSup
       condicion=true; 
    else
        condicion=false;
    end
    
   if  img(x+xinc,y+yinc) >= limInf  && img(x+xinc,y+yinc) <= limSup
       condicion=true; 
    else
        condicion=false
    end
    
    %% Se manda el incremento
    %Se devuelve el incremento actualizado
    xinc=xinc+1;
    yinc=yinc+1;
    %Se guarda el resultado en una imagen
    imwrite(img2,'Imagen Final Semilleo 2.jpg','jpg');
end

