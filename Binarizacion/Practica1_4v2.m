function [ lvl ] = untitled( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    %Cerramos cualquier ventana de figura que pueda estar abierta en Matlab
    %para evitar confusiones
    close all;
    %El proceso inicial es leer la imagen y darle un formato doble para
    %poder manipular sus datos con mayor facilidad
    opc=input('Selecccione la imagen 1 presionando 1 o la imagen 2 presionando 1: ')
    if opc==1
        Imagen1=double(imread('Imagen1.tif'));
    else
        Imagen1=double(imread('Imagen2.tif'));
    end
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
    
    %Comenzamos con T de 1 a 256 (que es equivalente de 0 a 255)
    for T=1:256
        %Al inicio de cada ciclo reiniciamos nuestras variables
        suma1=0; suma2=0;
        %Este ciclo ir? desde el primer valor hasta nuestro valor T para la
        %sumatoria
       for Taux=1:T
           suma1=suma1+(g(Taux)*pg(Taux));
           suma2=suma2+pg(Taux);
       end
       %Si en algun momento tenemos un valor nulo en suma2 asignaremos
       %directamente un valor de 0 en nuestro vector para evitar valores
       %inexistentes en nuestros vectores
       if suma2==0
           media0(T)=0;
       else
           media0(T)=suma1/suma2;
       end
    end
    
    for T=1:256
        suma1=0; suma2=0;
        %Este ciclo ira desde el valor T+1 hasta el final de nuestro vector
        %para nuestra sumatoria
       for Taux=T+1:256
           suma1=suma1 + (g(Taux)*pg(Taux));
           suma2=suma2 + (pg(Taux));
       end
       %Si en algun momento tenemos un valor nulo en suma2 asignaremos
       %directamente un valor de 0 en nuestro vector para evitar valores
       %inexistentes en nuestros vectores
       if suma2==0
           media1(T)=0;
       else
           media1(T)=suma1/suma2;
       end
    end
    
    for T=1:256
       suma1=0; suma2=0;
       for Taux=1:T
            suma1=suma1+( media0(Taux) * pg(Taux));
       end
       for Taux1=T+1:256
            suma2=suma2+( media1(Taux1) * pg(Taux1) );
       end
       Ey(T)=suma1+suma2;
    end
    
    Ex=0;
    for T=1:256
        Ex=Ex+( g(T)*pg(T) );
    end
    
    for T=1:256
       suma1=0; suma2=0;
       for Taux=1:T
            suma1=suma1+( media0(Taux)^2 * pg(Taux));
       end
       for Taux1=T+1:256
            suma2=suma2+( media1(Taux1)^2 * pg(Taux1) );
       end
       Eyy(T)=suma1+suma2;
    end
    
    Exx=0;
    for T=1:256
        Exx=Exx+(g(T)^2*pg(T));
    end
    
    for T=1:256
       suma1=0; suma2=0;
       for Taux=1:T
            suma1=suma1+( media0(Taux) * pg(Taux) * g(Taux) );
       end
       for Taux1=T+1:256
            suma2=suma2+( media1(Taux1) * pg(Taux1) * g(Taux1) );
       end
       Exy(T)=suma1+suma2;
    end
    
    Vx= Exx - (Ex)^2;
    
    for T=1:256
        Vy(T)= Eyy(T) - (Ey(T))^2;
    end
    
    
    for T=1:256
        var1= Exy(T) - ( Ex*Ey(T) );
        var2= sqrt( Vx*Vy(T) );
        pxy(T)=var1/var2;
    end
    
    %Despues de calcular todos nuestros valores pasaremos a eliminar
    %umbrales improbables que van desde el 0 al 30 y del 200 al 256, estos
    %valores son improbables para nuestras imagenes
    pxy(1:30)=0;
    pxy(200:256)=0;
    
    %Hallaremos la posici?n nuestro valor maximo para elegirlo como umbral
    lvl=find(pxy==max(pxy));
    
    %Aplicamos la binarizacion
    for i=1:m
        for j=1:n
            if Imagen1(i,j)>=lvl(1)
                binary1(i,j)=200/255;
                %Creamos un segundo vector para que en nuestro histograma
                %pueda apreciarse el 0 y el 255
                binary2(i,j)=255;
            else
                binary1(i,j)=60/255;
                binary2(i,j)=0;
            end
        end
    end
    
    %Mostramos y guardamos la imagen, la grafica pxy y el histograma
    figure ('Name', 'Binary Image'), imshow(binary1);
    imwrite(binary1,'Binary Image pxy.jpg','jpg');
    p=figure ('Name', 'Grafica pxy'), stem(pxy);
    saveas(p, 'pxy grafic.png','png');
    h=figure('Name', 'Histogram'), histogram(binary2,0:255);
    hold on 'Histogram'
    stem(lvl,0,'blue');
    saveas(h, 'Histogram pxy.png','png');
    
    %Por ultimo nuestro programa devuelve el valor de lvl que fue el valor
    %que usamos para binarizar.
    

end

