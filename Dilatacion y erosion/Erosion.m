function [ output_args ] = untitled3( input_args )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

I=double(imread('OutputBaselineBrain.png'))/255; %Leemos nuestra imagen y le
%damos un formato doble
[m,n]=size(I); %Obtenemos el tama?o de nuestra imagen.
se=[1,1,1;0,0,0;1,1,1]; %Creamos nuestro elemento estructural, una linea de 
% 3 pixeles.
IM2=imerode(I,se); %Aplicamos el comando para dilatar nuestra imagen 
%con nuestro elemento estructural.

for x=2:m-1;            %Recorremos nuestra matriz pixel por pixel para
        for y=2:n-1;    %aplicar nuestro elemento estructural

%Cada elemento obtenido de juntar nuestra imagen con el elemento
%estructural se guarda en un vector
           v(1)= se(1,1)*I(x-1,y-1);
           v(2)= se(1,2)*I(x-1,y);
           v(3)= se(1,3)*I(x-1,y+1);
           v(4)= se(2,1)||I(x,y-1); %aplicando la operacion logica OR
           v(5)= se(2,2)||I(x,y);   %podemos obtener un valor 1 cuando alguno de 
           v(6)= se(2,3)||I(x,y+1); %estos pixeles presenta un valor 1.
           v(7)= se(3,1)*I(x+1,y-1);
           v(8)= se(3,2)*I(x+1,y);
           v(9)= se(3,3)*I(x+1,y+1);
           IMman(x,y)=v(4)&&v(5)&&v(6); %Mediante el operativo AND obtenemos
%el valor 1 siempre y cuando nuestros 3 pixeles anteriores sean 1.
        end
end

%Mostramos y guardamos nuestras 2 imagenes.
figure(1), imshow(I), title('Original');
figure(2), imshow(IM2), title('Comando');
imwrite(IM2,'Erosion Comando Linea.jpg','jpg');
figure(3), imshow(IMman), title('Manual');
imwrite(IM2,'Erosion Manual Linea.jpg','jpg');

%Repetimos el proceso con un nuevo elemento estructural.

se=[1,0,1;0,0,0;1,0,1]; %Creamos nuestro elemento estructural, una linea de 
% 3 pixeles.
IM2=imerode(I,se); %Aplicamos el comando para dilatar nuestra imagen 
%con nuestro elemento estructural.


for x=2:m-1;            %Recorremos nuestra matriz pixel por pixel para
        for y=2:n-1;    %aplicar nuestro elemento estructural

%Cada elemento obtenido de juntar nuestra imagen con el elemento
%estructural se guarda en un vector
           v(1)= se(1,1)*I(x-1,y-1);
           v(2)= se(1,2)||I(x-1,y);     %Mediante nuestra operacion OR
           v(3)= se(1,3)*I(x-1,y+1);    %obtenemos el valor 1 siempre y
           v(4)= se(2,1)||I(x,y-1);     %siempre y cuando en nuestra imagen
           v(5)= se(2,2)||I(x,y);       %exista este valor de 1.
           v(6)= se(2,3)||I(x,y+1);
           v(7)= se(3,1)*I(x+1,y-1);
           v(8)= se(3,2)||I(x+1,y);
           v(9)= se(3,3)*I(x+1,y+1);
           IMman(x,y)=v(2)&&v(4)&&v(5)&&v(6)&&v(8); %Mediante nuestra 
%operacion AND obtenemos el valor de 1 en nuestra nueva imagen siempre y
%cuando todos nuestros pixeles analizados sean 1.
        end
end

%Mostramos y guardamos nuestras 4 imagenes.
figure(1), imshow(I), title('Original');
figure(2), imshow(IM2), title('Comando Matriz');
imwrite(IM2,'Erosion Comando Cruz.jpg','jpg');
figure(3), imshow(IMman), title('Manual');
imwrite(IMman,'Erosion Manual Cruz.jpg','jpg');

end

