function [ I2, prom ] = Histograma( input_args )
% Operaciones con Histogramas
%  Este programa prueba comandos de histogramas como ecualizacion a la vez
%  que prueba una implementacion de operaciones mediante ciclos de los
%  mismos comandos. 

%Leemos nuestra imagen
I=imread('RMI2.jpg');
%creamos un vector para la frecuencia de cada valor de nuestra matriz
frec=zeros(1,256);
%Obtenemos el tama?o de nuestra matriz en dos variables.
[fil, col]=size(I);

%Histograma manual

%Recorremos nuestra matriz para obtener la repetici?n de cada uno de los
%valores de gris en nuestro vector.
for j=1:400;
    for i=1:400;
        a=I(i,j);
        frec(1,a+1)=frec(a+1)+1;
    end
end

%Creamos nuestro vector de valores en x
x=1:256;

%Ense?amos y guardamos nuestro histograma manual utilizando el comando bar
%para crear una gr?fica de barras dependiendo de la frecuencia de cada
%valor.

figure(1), bar(x,frec);
print('histograma_manual','-dpng');

%Mostramos el histograma normal utilizando imhist

figure(2), imhist(I);
print('histograma_comando','-dpng');

%Damos un formato doble a nuestra matriz
I2=double(I);

%Ecualizacion

%Para la ecualizacion necesitaremos un suma de nuestros valores, un vector
%de ecualizacion y un vector de la frecuencia ademas de tener el numero del
%total de nuestros pixeles.
suma=zeros(1,256);
ecual=suma;
frec1=suma;
totalpix=fil*col;

%Lo primero por hacer es obtener la frecuencia relativa de nuestros niveles
%de gris de nuestra imagen. 
for k=1:256

    frec1(k)=frec(k)/totalpix;
    
    if k==1;
    suma(k)=frec1(k);
    end
%Al mismo tiempo iremos obteniendo la suma de todos estos valores en una
%suma secuencial
    if k>1;
        suma(k)=suma(k-1) + frec1(k);
    end
    
%Despues conseguiremos el valor de ecualizacion de para cada nivel de gris
    ecual(k) = suma(k)*256;

end

%Creamos una matriz que albergara nuestra ecualizacion
Imgeq=zeros(fil,col);

%Albergaremos en esta nueva matriz el valor de nuestra ecualizacion
for i=1:fil

    for j=1:col
        
%Nuestra variable K tomar? el valor del pixel en nuestra matriz en formato
%doble
        k = I2(i,j);
%Se asigna el valor de ecualizacion del nivel de gris del pixel original a
%nuestra nueva matriz
        Imgeq(i,j)=ecual(k+1);

    end

end

%Guardamos nuestra matriz en formato de 8 bits
Imgeq = uint8(Imgeq);
%Utilizamos un comando de ecualizacion para modificar nuestra imagen
%original y lo guardamos en otra matriz
ImOEq = histeq(I);

%Comparamos ambas imagenes para ver los resultados.

 figure(1), imhist(Imgeq);
 print('ecual_manual','-dpng');
 figure(2), imhist(ImOEq);
 print('ecual_comando','-dpng');

%Binarizar imagen

%Creamos variables para obtener nuestra frecuencia mayor y menor. Esto es
%para obtener el valor del gris de un valle y una cresta.
max=0;
min=totalpix;

%recorremos nuestro vector de frecuencias para encontrar nuestro valor
%m?ximo y m?nimo, el m?nimo tendr? que ser un numero distinto a 0.
for k=1:256
   
    if max<frec(k);
        max=frec(k);
    end
    
    if min>frec(k)&&frec(k)~=0;
        min=frec(k);
    end
    
end

%Obtenemos la posicion de cada valor para obtener el valor del gris que le
%corresponde, se le resta uno porque nuestros valores van de 1 a 256
posmax=find(frec==max)-1;
posmin=find(frec==min)-1;

%Obtenemos el valor promedio entre estos valores para conseguir un valor
%intermedio entre la cresta y el valle.
prom=(posmax+posmin)/2;
%Se redondea este valor
prom=round(prom);

%Reiniciamos nuestras matrices
I2=zeros(fil,col);
I=uint8(I);


%Recorremos nuestra matriz
for i=1:fil
    for j=1:col
        
%Si nuestro valor esta por encima del promedio este tomara un valor de 255
        if I(i,j)>prom;
            I2(i,j)=255;
        else
%Si en cambio esta por debajo o es igual tomara un valor de 0
        if I(i,j)<=prom;
            I2(i,j)=0;
        end
        end
        
    end
end

%Devolvemos el formato a nuestra matriz
I2=uint8(I2);

%Guardamos nuestra imagen binaria
imwrite(I2,'Imagen_binaria.jpg','jpg')

%Obtenemos otros dos limites para poder crear nuestro histograma resaltando
%nuestro valor umbral
prominf=round(prom/2);
promsup=round(prom/2+prom);

y=frec;

%Los siguientes For nos permiten obtener una matriz llena de 0, prom y 255.
%Esto nos permitira crear un histograma que nos permita resaltar nuestro
%valor umbral para la binarizacion.

for k=prominf:-1:2;
   
    y(1)=y(1)+y(k);
    y(k)=0;
    
end

for k=prominf:prom-1;
   
    y(prom)=y(prom)+y(k);
    y(k)=0;
    
end

for k=promsup:-1:prom+1;
   
    y(prom)=y(prom)+y(k);
    y(k)=0;
    
end

for k=promsup:255;
   
    y(256)=y(256)+y(k);
    y(k)=0;
    
end

%Histograma con umbral
 
  figure(1), bar(x,y);
  print('histograma_umbral','-dpng');

%Niveles de grises
I2=I;

%A partir de nuestro promedio tomamos 30 valores inferiores y 70
%superiores para este caso especifico. Este rango de valores ser?n
%resaltados (multiplicados por 1.5) para aumentar estos niveles de gris.

for k=prom-30:prom+70;
    for i=1:size(I,1);
        for j=1:size(I,2);
            if I(i,j)==k;
                I2(i,j)=I(i,j)*1.5;
            end
        end
    end
end

%Guardamos nuestra imagen y nuestro histograma de la imagen

imwrite(I2,'Resaltar_grises.jpg','jpg');
figure(1), imhist(I2);
print('Histograma_Resalt','-dpng');

end

