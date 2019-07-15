function [ output_args ] = Apertura( input_args )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

I=double(imread('OutputBaselineBrain.png'))/255; %Leemos nuestra imagen y le
%damos un formato doble
[m,n]=size(I); %Obtenemos el tama?o de nuestra imagen.
se=ones(3);%Creamos nuestro elemento estructural

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
           IM2(x,y)=v(4)&&v(5)&&v(6); %Mediante el operativo AND obtenemos
%el valor 1 siempre y cuando nuestros 3 pixeles anteriores sean 1.
           v=zeros(1,9);
        end
end

for x=2:m-2;            %Recorremos nuestra matriz pixel por pixel para
        for y=2:n-2;    %aplicar nuestro elemento estructural

%Cada elemento obtenido de juntar nuestra imagen con el elemento
%estructural se guarda en un vector
           v(1)= se(1,1)*IM2(x-1,y-1);
           v(2)= se(1,2)*IM2(x-1,y);
           v(3)= se(1,3)*IM2(x-1,y+1);
           v(4)= se(2,1)*IM2(x,y-1);
           v(5)= se(2,2)*IM2(x,y);
           v(6)= se(2,3)*IM2(x,y+1);
           v(7)= se(3,1)*IM2(x+1,y-1);
           v(8)= se(3,2)*IM2(x+1,y);
           v(9)= se(3,3)*IM2(x+1,y+1);
           Max=max(v); %Obtenemos el valor m?s alto en este vector, es decir
%que si existe un valor 1 en este vector lo encontramos.
           IM3(x,y)=Max; %Si existe un valor 1 en nuestro vector se guarda 
%en la nueva imagen, si no es as? simplemente guardamos un 0.
        end
        v=0;
end

se=[0,0,0;1,1,1;0,0,0];%Creamos nuestro elemento estructural

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
           IM4(x,y)=v(4)&&v(5)&&v(6); %Mediante el operativo AND obtenemos
%el valor 1 siempre y cuando nuestros 3 pixeles anteriores sean 1.
        end
        v=0;
end

for x=2:m-3;            %Recorremos nuestra matriz pixel por pixel para
        for y=2:n-3;    %aplicar nuestro elemento estructural

%Cada elemento obtenido de juntar nuestra imagen con el elemento
%estructural se guarda en un vector
           v(1)= se(1,1)*IM3(x-1,y-1);
           v(2)= se(1,2)*IM3(x-1,y);
           v(3)= se(1,3)*IM3(x-1,y+1);
           v(4)= se(2,1)*IM3(x,y-1);
           v(5)= se(2,2)*IM3(x,y);
           v(6)= se(2,3)*IM3(x,y+1);
           v(7)= se(3,1)*IM3(x+1,y-1);
           v(8)= se(3,2)*IM3(x+1,y);
           v(9)= se(3,3)*IM3(x+1,y+1);
           Max=max(v); %Obtenemos el valor m?s alto en este vector, es decir
%que si existe un valor 1 en este vector lo encontramos.
           IM5(x,y)=Max; %Si existe un valor 1 en nuestro vector se guarda 
%en la nueva imagen, si no es as? simplemente guardamos un 0.
        end
        v=0;
end

%Mostramos y guardamos nuestras 2 imagenes.
figure(1), imshow(I), title('Original');
figure(2), imshow(IM2), title('Apertura rectangulo');
imwrite(IM2,'Apertura Rectangulo.jpg','jpg');
figure(3), imshow(IM3), title('Apertura Linea');
imwrite(IM3,'Apertura Linea.jpg','jpg');
end

