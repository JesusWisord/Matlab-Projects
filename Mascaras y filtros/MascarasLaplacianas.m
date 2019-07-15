function [ D ] = MascarasLaplacianas(  )
%Este programa lee una imagen devolviendo dos imagenes con convolucion
%manual y dos con convolucion por comando.
%   Las Mascaras Laplacianas L1 y L2 son creadas en el programa y se
%   implementan en la imagen de manera manual mediante ciclos y de manera
%   m?s autom?tica mediante comandos ya establecidos para Matlab. Al final
%   muestra las im?genes y las guarda.

%Cerramos las ventanas que puedan estar abiertas
close all

A=imread('leaf.bmp'); %Leemos la imagen
A=double(A); %La cambiamos a dobles
A=A/255; %Normalizamos la imagen

%Creamos nuestras matrices para implementar los filtros

L2=ones(3);
L1=[0,1,0;1,-1,1;0,1,0];
L2(2,2)=-8;
%Obtenemos el tama?o de nuestra matriz en dos variables
[i,j]=size(A);
%Creamos una matriz vac?a donde guardaremos nuestra imagen filtrada
B=zeros(i,j);
%Creamos una matriz auxiliar con un borde de ceros
Ap=zeros(i+2,j+2);
%Llenamos el centro de nuestra matriz auxiliar con la imagen original.
Ap(2:i+1,2:j+1)=A;
%Creamos una segunda matriz donde guardaremos nuestra segunda imagen
%filtrada
C=B;

%Creamos nuestro ciclo empezando desde (2,2) y terminar? en el pixel
%(i+1,j+1). Esto para recorrer la matriz auxiliar pero unicamente los
%pixeles de nuestra imagen y no el borde lleno de ceros.
for x=2:i+1;
    for y=2:j+1;

%Creamos 9 variables representando nuestra vecindad de 8-vecinos de cada
%pixel con el pixel de esta vecindad. Cada elemento de nuestra matriz del
%filtro se multiplicara por su correspondiente en la vecindad.
       v1= L1(1,1)*Ap(x-1,y-1);
       v2= L1(1,2)*Ap(x-1,y);
       v3= L1(1,3)*Ap(x-1,y+1);
       v4= L1(2,1)*Ap(x,y-1);
       v5= L1(2,2)*Ap(x,y);
       v6= L1(2,3)*Ap(x,y+1);
       v7= L1(3,1)*Ap(x+1,y-1);
       v8= L1(3,2)*Ap(x+1,y);
       v9= L1(3,3)*Ap(x+1,y+1);
%Recordamos que nuestra matriz de la imagen debe empezar a llenarse desde
%(1,1) por lo que comenzamos (x-1,y-1). Este pixel ser? la suma de todas
%nuestras variables.
       B(x-1,y-1)=v1+v2+v3+v4+v5+v6+v7+v8+v9;


%El mismo proceso se repite para nuestra segunda imagen, esta vez
%utilizando el segundo filtro.

       v1= L2(1,1)*Ap(x-1,y-1);
       v2= L2(1,2)*Ap(x-1,y);
       v3= L2(1,3)*Ap(x-1,y+1);
       v4= L2(2,1)*Ap(x,y-1);
       v5= L2(2,2)*Ap(x,y);
       v6= L2(2,3)*Ap(x,y+1);
       v7= L2(3,1)*Ap(x+1,y-1);
       v8= L2(3,2)*Ap(x+1,y);
       v9= L2(3,3)*Ap(x+1,y+1);
       C(x-1,y-1)=v1+v2+v3+v4+v5+v6+v7+v8+v9;

    end
end

%Se despliegan nuestras 3 imagenes, la original, la primera convolucion y
%la segunda convoluci?n. Todas en la misma ventana. Despu?s se guardan en
%la carpeta donde se encuentra el programa

subplot(1,3,1); imshow(A), title('Imagen Original');
imwrite(A,'Imagen Original.jpg', 'jpg');
subplot(1,3,2), imshow(B), title('Convolucion');
imwrite(B,'Convolucion Manual 1.jpg', 'jpg');
subplot(1,3,3), imshow(C), title('Convolucion 2');
imwrite(C,'Convolucion Manual 2.jpg', 'jpg');

%Dos nuevas variables ser?n nuestras imagenes filtradas con la mismas
%matrices anteriores pero esta vez con comandos.
D=conv2(A,L1,'valid');
E=conv2(A,L2);

%Se muestran estas dos ultimas imagenes en una ventana y se guardan en la
%misma carpeta que el programa
figure (2); subplot (1,2,1), imshow(D), title('Convolucion 1 Comando');
imwrite(D,'Convolucion Comando 1.jpg', 'jpg');
subplot (1,2,2), imshow(E), title('Convolucion 2 Comando');
imwrite(E,'Convolucion Comando 2.jpg', 'jpg');




end
