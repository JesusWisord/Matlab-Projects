function [ output_args ] = untitled( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

I=double(imread('OutputBaselineBrain.png'))/255; %Leemos nuestra imagen y le
%damos un formato doble
[m,n]=size(I); %Obtenemos el tama?o de nuestra imagen.
se=[1,1,1;0,0,0;1,1,1]; %Creamos nuestro elemento estructural, una linea de 
% 3 pixeles.
IM2=imdilate(I,se); %Aplicamos el comando para dilatar nuestra imagen 
%con nuestro elemento estructural.
SE=strel('line',3,0); %Mediante un comando creamos un elemento estructural
%una linea, con una longitud de 3 pixeles y una inclinacion de 0 grados.
IM3=imdilate(I,SE); %Aplicamos nuestro comando para dilatar con este nuevo
%elemento estructural.

for x=2:m-1;            %Recorremos nuestra matriz pixel por pixel para
        for y=2:n-1;    %aplicar nuestro elemento estructural

%Cada elemento obtenido de juntar nuestra imagen con el elemento
%estructural se guarda en un vector
           v(1)= se(1,1)*I(x-1,y-1);
           v(2)= se(1,2)*I(x-1,y);
           v(3)= se(1,3)*I(x-1,y+1);
           v(4)= se(2,1)*I(x,y-1);
           v(5)= se(2,2)*I(x,y);
           v(6)= se(2,3)*I(x,y+1);
           v(7)= se(3,1)*I(x+1,y-1);
           v(8)= se(3,2)*I(x+1,y);
           v(9)= se(3,3)*I(x+1,y+1);
           Max=max(v); %Obtenemos el valor m?s alto en este vector, es decir
%que si existe un valor 1 en este vector lo encontramos.
           IMman(x,y)=Max; %Si existe un valor 1 en nuestro vector se guarda 
%en la nueva imagen, si no es as? simplemente guardamos un 0.
        end
end

%Mostramos y guardamos nuestras 4 imagenes.
figure(1), imshow(I), title('Original');
figure(2), imshow(IM2), title('Comando Matriz');
imwrite(IM2,'Dilatacion Comando Matriz Linea.jpg','jpg');
figure(3), imshow(IM3), title('Comando Strel');
imwrite(IM3,'Dilatacion Comando Strel Linea.jpg','jpg');
figure(4), imshow(IMman), title('Manual');
imwrite(IMman,'Dilatacion Manual Linea.jpg','jpg');

%Repetimos el proceso con un nuevo elemento estructural.

se=[1,0,1;0,0,0;1,0,1]; %Creamos nuestro elemento estructural, una linea de 
% 3 pixeles.
IM2=imdilate(I,se); %Aplicamos el comando para dilatar nuestra imagen 
%con nuestro elemento estructural.


for x=2:m-1;            %Recorremos nuestra matriz pixel por pixel para
        for y=2:n-1;    %aplicar nuestro elemento estructural

%Cada elemento obtenido de juntar nuestra imagen con el elemento
%estructural se guarda en un vector
           v(1)= se(1,1)*I(x-1,y-1);
           v(2)= se(1,2)*I(x-1,y);
           v(3)= se(1,3)*I(x-1,y+1);
           v(4)= se(2,1)*I(x,y-1);
           v(5)= se(2,2)*I(x,y);
           v(6)= se(2,3)*I(x,y+1);
           v(7)= se(3,1)*I(x+1,y-1);
           v(8)= se(3,2)*I(x+1,y);
           v(9)= se(3,3)*I(x+1,y+1);
           Max=max(v); %Obtenemos el valor m?s alto en este vector, es decir
%que si existe un valor 1 en este vector lo encontramos.
           IMman(x,y)=Max; %Si existe un valor 1 en nuestro vector se guarda 
%en la nueva imagen, si no es as? simplemente guardamos un 0.
        end
end

%Mostramos y guardamos nuestras 4 imagenes.
figure(1), imshow(I), title('Original');
figure(2), imshow(IM2), title('Comando Matriz');
imwrite(IM2,'Dilatacion Comando Cruz.jpg','jpg');
figure(4), imshow(IMman), title('Manual');
imwrite(IMman,'Dilatacion Manual Cruz.jpg','jpg');

end

