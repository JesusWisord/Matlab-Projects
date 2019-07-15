function [ I, I2, I3 ] = Comandos( input_args )
%Comandos y ciclos en Imagenes en escala de grise
%   Este programa prueba comandos para modificar imagenes en escala de
%   grises y luego se realiza la misma accion utilizando ciclos recorriendo
%   pixel por pixel la imagen. Se compara el resultado con cada accion.


%Leemos la imagen de Resonancia Magnetica

I=imread('RMI2.jpg');
%I2 sera nuestra matriz destinada a comandos, en este caso hacemos una
%inversion de colores en escala de grises
I2=imcomplement(I);
%I3 sera nuestra matriz destinada a ciclos, creamos la matriz llena de
%seros del tama?o de nuestra matriz original. 
I3=zeros(size(I));


%Recorremos toda la matriz
for j=1:size(I,1);
    for i=1:size(I,2);
% Al hacer la resta de 255 menos el valor de la posici?n podemos
% asegurarnos de obtener el valor contrario al que tenemos, transformamos 0
% en 255 y viceversa, igualmente con valores intermedios.
        I3(i,j)=255-I(i,j);
    end
end
%Se transforma la matriz a un formato de 8 bits.
I3=uint8(I3);

%Se guardan las imagenes obtenidas

imwrite(I2,'negativo_comando.jpg');
imwrite(I3,'negativo_ciclo.jpg');

%Rotacion 90 grados


%Se utiliza el comando de rotacion de 90 grados para girar la imagen y
%guardarla en una nueva matriz
I2=rot90(I);

for j=1:size(I,1);
    for i=1:size(I,2);
%Las columnas pasan a ser los renglones de nuestra matriz y los renglones
%tienen que ser las columnas pero en sentido inverso, as? que tenemos que
%restar el tama?o de nuestra matriz menos nuestra variable i que va
%cambiando en nuesro ciclo for. le aumentamos uno a este valor para
%permitir que nuestra matriz vaya desde el 400 a 1, o desde nuestro valor
%limite a 1.
        I3(i,j)=I(j,size(I,1)-i+1);
    end
end

%Se guardan las imagenes

imwrite(I2,'rotacion_comando.jpg');
imwrite(I3,'rotacion_ciclo.jpg');

%reflejo Espejo


%Utilizamos el comando para crear una imagen reflejo de nuestra imagen
%original
I2=fliplr(I);

for j=size(I,2):-1:1;
    for i=1:size(I,1);
%creamos un valor auxiliar que vaya desde nuestro valor limite a 1.
        a=size(I,2)-j+1;
%Este valor nos permitira guardar la primera columna de la imagen original
%en la ultima columna de nuestra nueva imagen.
        I3(i,a)=I(i,j);
    end
end

%Guardamos nuestras imagenes

 imwrite(I2,'reflejo_comando.jpg');
 imwrite(I3,'reflejo_ciclo.jpg');

%Recorte

%utilizamos el comando de imcrop. Utilizando herramientas de imagen
%obtenemos las coordenadas de inicio y fin de nuestra imagen, inicio en
%(248,153) y el final en (325,245). El comando imcrop funciona con
%coordenadas como primeros parametros y tama?os como segundo parametro, es
%por eso que usamos una resta para obtener este tama?o en los segundos
%parametros
I2=imcrop(I, [248, 153, 325-248, 245-153]);
%creamos nuestras variables con estos valores
x=248; y=153;
sizex=325-248; sizey=245-153;
%Inicializamos nuestra matriz con el tama?o que tendr? nuestro recorte
I3=zeros(sizey,sizex);
%le damos formato de 8 bits
I3=uint8(I3);

for j=1:sizex;
    for i=1:sizey;
%Aqui vamos recorriendo la matriz para copiar los valores de nuestro
%recorte en nuestra nueva matriz
        I3(i,j)=I(y+i,x+j);
    end
end

%Guardamos nuestras imagenes recortadas.

 imwrite(I2,'recorte_comando.jpg');
 imwrite(I3,'recorte_ciclo.jpg');


%Logaritmo
%Devolvemos nuestras matrices al tama?o original
I3=zeros(size(I));
%Le damos formato doble a nuestra matriz
I2=double(I);
%Normalizamos nuestros valores
I2=I2/255;
%Aplicamos el logaritmo en toda la matriz
I2=1.9*log(1+I2);
%La devolvemos a valores de 8 bits
I2=im2uint8(I2);


for j=1:400;
    for i=1:400;
%Para el ciclo utilizamos el mismo concepto. Un valor en formato doble de
%nuestra matriz original dividido entre 255 y le aplicamos el logaritmo a
%este valor para finalmente guardarlo en la matriz original.
        I3(i,j)=1.9*log(1+(double ( I(i,j) ) ) /255 );
    end
end

%guardamos nuestras imagenes
imwrite(I2,'logaritmo_comando.jpg');
imwrite(I3,'logaritmop_ciclo.jpg');

%Correccion Gamma

%Leemos nuestra nueva imagen oscura que utilizaremos para la correccion
%gamma
I=imread('pp.jpeg');
I2=rgb2gray(I);
%Al ser una imagen a color la transformaremos a escala de grises
I=rgb2gray(I);
%le damos formato doble
I2=double(I2);
%aplicamos nuestra correcci?n gamma
I2=255*((I2/255).^(1/1.5));
%le damos formato de 8 bits
I2=uint8(I2);
%creamos la matriz de ciclos con el tama?o de nuestra nueva imagen
I3=zeros(size(I));

for j=1:size(I,1);
    for i=1:size(I,2);
%creamos nuestra variable auxiliar para facilitar la aplicacion de la
%correccion gamma
        a=1/1.5;
%creamos otra variable auxiliar que albergue el valor en formato doble de
%nuestro pixel actual
        aux=double(I(i,j));
%Guardamos el valor de nuestra correccion gamma en nuestra matriz
        I3(i,j)=255*((aux/255).^(a));
    end
end
%Damos el formato de 8 bits a nuestra matriz
I3=uint8(I3);


%guardamos nuestras imagenes

imwrite(I2,'gamma_comando.jpg');
imwrite(I3,'gamma_ciclo.jpg');





end

