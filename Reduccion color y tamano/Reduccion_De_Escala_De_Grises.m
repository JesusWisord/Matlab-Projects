% Reducci?n de Matices de Grises, de 256 niveles a 2 niveles
%   Este programa trabaja con una matriz de 3 dimensiones (256x256x3) para
%   crear distintas matrices con la reduccion en niveles de grises de la
%   imagen proporcionada, llamada en este caso como "tarea1.jpg". El
%   programa transforma todo n?mero igual o menor a 127 en par y todo igual
%   o mayor a 128 en impar logrando la primera reduccion y trabajando a
%   partir de esta matriz. Los colores se van distanciando cada vez mas a
%   partir de potencias de 2 para ir dividiendo entre 2 la reduccion de
%   niveles.

I=imread('tarea1.jpg'); 
%Leemos la imagen
[ml,nl]=size(I); 
%Obtenemos el tamano en dos variables

p=zeros(ml,nl,7);
%Creamos una matriz de 3 dimensiones para albergar cada una de las matrices
%en una sola variable, en total tenemos 7 conjuntos de matrices.

for z=1:7; 
%Inicializamos nuestros conteos para recorrer todas las 7 matrices con 3 
%for, uno por cada dimensi?n de la matriz
    for j=1:nl;
        for i=1:ml;

            if I(i,j)>=128 & I(i,j)<255; 
%Nuestra escala de gris va de 0 a 255, todo n?mero arriba de 128 lo haremos
%impar para preservar el 255
                
                if z==1; 
%Creamos un caso especial para la primera matriz ya que en esta nos 
% basaremos para la b?squeda de las dem?s matrices. Este primer caso nos
% ayuda a crear los nones en la primera matriz disminuyendo los niveles, 
%tendremos ahora 128 matices de gris
                if mod(I(i,j),2)==0 
%Esto es para convertir todo n?mero par en impar
                   p(i,j,1)=I(i,j)+1;
                else
                   p(i,j,1)=I(i,j);
                end
                end
                
            if z~=1 
%Aqu? trabajos desde la segunda matriz hasta la septima
                    x=0; 
%Creamos una nueva variable para controlar nuestro
% nuestro residuo. 
                for k=2.^z-1:-1:0; 
%Se crea nuestra variable dependiendo de la matriz que estemos trabajando, 
%esto afectar? nuestra potencia de k
                    if mod(I(i,j),2.^z)==x; 
%Aqui lo que intentamos es probar
%si el residuo se encuentra dentro del rango de nuestra potencia, es decir
%si nuestra potencia es de 2, nuestro residuo se puede encontrar entre 0 y
%3, si es as? le sumaremos k que ir? de 1 a 0 dependiendo del caso.
                       p(i,j,z)=I(i,j)+(k); 
                       break;
                    end
                    x=x+1; 
%Al no poder utilizar un for directamente, creamos un incremento manual.
                end
                if x==2.^z-2 
%Si el residuo no fue el que esperamos significara que el n?mero que 
%estamos analizando es correcto y puede almacenarse en la nueva matriz.
                       p(i,j,z)=p(i,j,1);
                end
            end
               
            end

            if I(i,j)==255 
%Si nuestro numero es 255, entonces por default lo almacenaremos en la 
%nueva matriz.
                p(i,j,z)=255;
            end

            if I(i,j)<=127 & I(i,j)>0; 
%Ahora analizamos desde 127 a 0 para convertirlos en pares
                if z==1 
%De nuevo creamos un caso especial para la primera matriz para poder 
%transformar todos los n?meros a pares.
                    if mod(I(i,j),2.^z)~=0
                    p(i,j,z)=I(i,j)-(1); 
                    ans=p(i,j,z);
                   else
                     p(i,j,z)=I(i,j);
                     ans=p(i,j,z);
                    end
                else
%Si z no es 1 entonces estamos en cualquiera de las
% otras matrices.
                    
                    if mod(I(i,j),2.^z)~=0 
%En este caso buscamos que ademas
% de ser n?meros pares cumplan con la propiedad de ser divisibles entre la
% potencia en la que estamos trabajando, es decir, si la potencia es 3,
% significa que es 2.^3=8, todos los n?meros por debajo de 127 deber?n ser
% divisibles entre 8 para ir disminuyendo nuestros matices de gris.
                    a=mod(p(i,j,z-1),2.^z);
                    p(i,j,z)=p(i,j,z-1)-(a); 
%le restamos lo que haga falta para que sea un numero divisible de 
%nuestra potencia
                   else
                     p(i,j,z)=p(i,j,z-1);
                    end
                end
            end

        end
    end
end

%Extraemos cada una de las matrices en una nueva variable para poder
%exportarlas como matrices simples de 2 dimensiones.

m1= uint8(p(:,:,1));
m2= uint8(p(:,:,2));
m3= uint8(p(:,:,3));
m4= uint8(p(:,:,4));
m5= uint8(p(:,:,5));
m6= uint8(p(:,:,6));
m7= uint8(p(:,:,7));

