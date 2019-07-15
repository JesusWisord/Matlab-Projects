function [ A,B,C ] = MascaraGaussiana(  )
%Este programa lee una imagen y le aplica una mascara Gaussiana
%   De manera manual y por medio de comandos se aplica una mascara
%   Gaussiana de bajo valor a una imagen desplegando y guardando ambos
%   resultados.

%Cerramos las ventanas que puedan estar abiertas
close all

%Leemos la imagen
A=imread('MRIspine1.tif');
%La transformamos a formato doble
A=double(A);
%Normalizamos la imagen
A=A/255;
%Obtenemos el tama?o de nuestra matriz
[i,j]=size(A);
%Creamos nuestras matrices
m1=[1,2,1;2,4,2;1,2,1];
m1=(1/16)*m1;
%Creamos una matriz auxiliar con un borde de ceros
Ap=zeros(i+2,j+2);
%Llenamos el centro de nuestra matriz auxiliar con la imagen original.
Ap(2:i+1,2:j+1)=A;
%Creamos nuestra matriz donde guardaremos nuestra imagen filtrada
B=zeros(i,j);
%Creamos una segunda matriz para guardar nuestra imagen filtrada
C=B;
%Aplicamos el comando para el filtrado.
C=conv2(A,m1);


%Creamos nuestro ciclo empezando desde (2,2) y terminar? en el pixel
%(i+1,j+1). Esto para recorrer la matriz auxiliar pero unicamente los
%pixeles de nuestra imagen y no el borde lleno de ceros.
for x=2:i+1;
    for y=2:j+1;
        
%Creamos 9 variables representando nuestra vecindad de 8-vecinos de cada
%pixel con el pixel de esta vecindad. Cada elemento de nuestra matriz del
%filtro se multiplicara por su correspondiente en la vecindad. 
       v1= m1(1,1)*Ap(x-1,y-1);
       v2= m1(1,2)*Ap(x-1,y);
       v3= m1(1,3)*Ap(x-1,y+1);
       v4= m1(2,1)*Ap(x,y-1);
       v5= m1(2,2)*Ap(x,y);
       v6= m1(2,3)*Ap(x,y+1);
       v7= m1(3,1)*Ap(x+1,y-1);
       v8= m1(3,2)*Ap(x+1,y);
       v9= m1(3,3)*Ap(x+1,y+1);
%Recordamos que nuestra matriz de la imagen debe empezar a llenarse desde
%(1,1) por lo que comenzamos (x-1,y-1). Este pixel ser? la suma de todas
%nuestras variables.
       B(x-1,y-1)=v1+v2+v3+v4+v5+v6+v7+v8+v9;
      
       
        
    end
end

%Mostramos nuestras tres im?genes en ventanas y guardamos las imagenes en
%la misma carpeta donde se encuentra el programa
figure(1); imshow(A), title('Imagen Original');
figure(2), imshow(B), title('Convolucion');
imwrite(B,'2.1 Convolucion Manual.jpg', 'jpg');
figure(3), imshow(C), title('Convolucion 2');
imwrite(C,'2.1 Convolucion Comando.jpg', 'jpg');



end
