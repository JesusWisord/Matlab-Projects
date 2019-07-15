function [ pxy ] = untitled( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    %Cerramos cualquier ventana de figura que pueda estar abierta en Matlab
    %para evitar confusiones
    close all;
    %El proceso inicial es leer la imagen y darle un formato doble para
    %poder manipular sus datos con mayor facilidad
    Imagen1=double(imread('Imagen1.tif'));
    %Obtenemos el tama?o de nuestra imagen en dos variables distintas, una
    %para columnas, otra para renglones
    [m,n]=size(Imagen1);
    
    %Obtenemos un vector con el histograma de nuestra imagen
    g=imhist(Imagen1/255);
    g=g';
    
    %Calculamos la probabiidad de cada nivel de gris en un nuevo vector
    for aux=1:256
        pg(aux)=g(aux)/(m*n);
    end
    
    
    %El vector g representa nuestros niveles de gris as? que lo creamos con
    %valores de 0 a 255
    
    g=0:255;
    
    
    %Creamos nuestros dos primeros vectores de medias utilizando la formula
    %ya dada en la practica
    
    for aux=1:256 
        %Inicializamos nuestras sumas como 0 al inicio de cada ciclo
        suma1=0; suma2=0;
        %Nuestra variable aux corresponde al nivel de T que estamos
        %guardando, y nos sirve para hacer toda la sumatoria desde g=0
        %hasta T (En este caso empieza en 1)
        for y=1:aux
            suma1=suma1+(g(y)*pg(y));
            suma2=suma2+pg(y);
        end
        media0(aux)=suma1/suma2;
    end
    
    for aux=1:255 
        %Inicializamos nuestras sumas como 0 al inicio de cada ciclo
        suma1=0; suma2=0;
         %En este caso nuestra suma comienza en nuestra variable aux (que
         %en la f?rmula funciona como T) hasta n que en este caso lo
         %ponemos como 255 porque siempre utilizamos un T+1 y el 256
         %exceder?a el tama?o del vector
        for y=aux+1:256
            suma1=suma1+(g(y)*pg(y));
            suma2=suma2+pg(y);
        end
        media1(aux)=suma1/suma2;
    end
    media1(256)=0;
    
    %Ahora pasamos a calcular los demas vectores necesarios para nuestra
    %binarizaci?n
    
    %Comenzamos con Ey
    %aux es el ciclo que estamos utilizando, podria decirse que es
    %nuestra T general para guardar las sumatorias
    for aux=1:256
        %Inicializamos nuestras sumas como 0 al inicio de cada ciclo
        suma1=0; suma2=0;
        %T aqu? ir? desde el primer valor de nuestro vector hasta nuestra
        %variable aux como lo indica la formula
        for T=1:aux
            suma1=suma1+(media0(T)*pg(T));
        end
        %Esta parte va desde T+1 hasta n
        for auxg=aux:255
            suma2=suma2+(media1(auxg+1)*pg(auxg+1));
        end
        Ey(aux)=suma1+suma2;
    end
    
    %Ahora calculamos Ex
    Ex=0;
    for aux=1:256
       Ex=Ex+( g(aux)*pg(aux) );
    end
    
    
    %Procedemos con los momentos de segundo orden comenzando con Eyy
    for aux=1:256
        %Inicializamos nuestras sumas como 0 al inicio de cada ciclo
        suma1=0; suma2=0;
         %Esta suma va desde g=0 (T=1 para no exceder dimensiones del vector)
         %hasta nuestro l?mite del ciclo, en este caso aux
        for T=1:aux
            suma1=suma1+(media0(T)^2*pg(T));
        end
        %Esta suma va desde n+1 (auxg) hasta nuestro l?mite (n) del ciclo 255
        %ya que 256 excede nuestro vector
        for auxg=aux+1:255
            suma2=suma2+(media1(auxg)^2*pg(auxg));
        end
        Eyy(aux)=suma1+suma2;
    end
    
    %Continuamos con Exx
    Exx=0;
    for aux=1:256
       Exx=Exx+( g(aux)^2*pg(aux) );
    end
    
    %Calculamos Exy
    for aux=1:256
        suma1=0; suma2=0;
        for T=1:aux
            suma1=suma1+( g(T)*media0(T)*pg(T) );
        end
        for auxg=aux+1:255
            suma2=suma2+( g(auxg)*media1(T)*pg(auxg) );
        end
        Exy(aux)=suma1+suma2;
    end
    
    %Por ultimo debemos calcular las Varianzas comenzando por Vx
    Vx=Exx-(Ex)^2;
    %Continuamos con Vy
    
    for T=1:256
       Vy(T)=Eyy(T)-( Ey(T) )^2;
    end
    
    %Aplicando nuestra f?rmula final obtenemos el vector pxy
    
    for T=1:256
        pxy(T)= ( Exy(T) - ( Ex*Ey(T) ) ) / ( sqrt(Vx*Vy(T)) );
    end
    
    %Buscamos el valor m?ximo de nuestro vector 
    Topt=max(pxy);
    
    %Aplicamos nuestra binarizaci?n
    for i=1:m
        for j=1:n
            if Imagen1(i,j) < Topt
            end
        end
    end

end

