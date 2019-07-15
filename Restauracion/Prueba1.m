function [ FiltroGeom ] = untitled( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%Leemos nuestra imagen con imread, la transformamos a una sola matriz en
%escala de grises con rgb2gray, le damos un formato doble y la normalizamos
ImOr=double(rgb2gray(imread('rm_rodilla.jpg')))/255;
%Creamos una matriz del mismo tama?o pero en ceros.
FiltroGeom=ImOr*0;

%% Filtro Promedio
%Creamos nuestra matriz que usaremos como filtro
FiltroPromedio=ones(3)/9;
%Mostramos nuestra imagen original con un plot
subplot(1,3,1), imshow(ImOr), title('Original');
%Le a?adimos un ruido gaussiano a nuestra imagen
ImRuidoGauss=imnoise(ImOr,'gaussian',0,0.09);
%Mostramos la imagen corrompida en el mismo plot
subplot(1,3,2), imshow(ImRuidoGauss), title('Ruido Gaussiano m=0, varianza=0.09');
%Guardamos esta imagen corrompida
imwrite(ImRuidoGauss,'Imagen con Ruido Gaussiano.jpg','jpg');
%Aplicamos el filtro a la imagen corrompida
ImFiltroProm=conv2(ImRuidoGauss,FiltroPromedio,'full');
%Mostramos la imagen en nuestro Plot
figure(1), subplot(1,3,3), imshow(ImFiltroProm), title('Filtro Promedio');
%Guardamos nuestra imagen filtrada
imwrite(ImFiltroProm,'Imagen con Filtro Promedio.jpg','jpg');

%Pausamos para apreciar el filtro


%% Filtro Promedio Geometrico
%Creamos la matriz del filtro
m1=ones(3);

%Recorremos la imagen en cada pixel donde la m?scara pueda actuar
%completamente
for x=2:size(ImOr,1)-1;
    for y=2:size(ImOr,2)-1;
        
%Creamos 9 variables representando nuestra vecindad de 8-vecinos de cada
%pixel con el pixel de esta vecindad. Cada elemento de nuestra matriz del
%filtro se multiplicara por su correspondiente en la vecindad. 
       v1= m1(1,1)*ImRuidoGauss(x-1,y-1);
       v2= m1(1,2)*ImRuidoGauss(x-1,y);
       v3= m1(1,3)*ImRuidoGauss(x-1,y+1);
       v4= m1(2,1)*ImRuidoGauss(x,y-1);
       v5= m1(2,2)*ImRuidoGauss(x,y);
       v6= m1(2,3)*ImRuidoGauss(x,y+1);
       v7= m1(3,1)*ImRuidoGauss(x+1,y-1);
       v8= m1(3,2)*ImRuidoGauss(x+1,y);
       v9= m1(3,3)*ImRuidoGauss(x+1,y+1);
       
%Aplicamos la formula de un filtro geometrico, multiplicando todas las
%variables y dividiendo entre el n?mero de variables, en este caso, 9.
       
        FiltroGeom(x,y)=(v1*v2*v3*v4*v5*v6*v7*v8*v9).^(1/9);
 
       
        
    end
end
r=2
%Mostramos la imagen en nuestro Plot
figure (2), subplot(1,3,1), imshow(FiltroGeom), title('Filtro Geometrico');
%Guardamos nuestra imagen filtrada
imwrite(ImFiltroProm,'Imagen con Filtro Geometrico.jpg','jpg');

%Pausamos para apreciar el filtro
pause

%% Filtro Promedio Armonico
m1=ones(3);
FiltroArmonico=FiltroGeom*0;
for x=2:size(ImOr,1)-1;
    for y=2:size(ImOr,2)-1;
        
%Creamos 9 variables representando nuestra vecindad de 8-vecinos de cada
%pixel con el pixel de esta vecindad. Cada elemento de nuestra matriz del
%filtro se multiplicara por su correspondiente en la vecindad. 
       v1= m1(1,1)*ImRuidoGauss(x-1,y-1);
       v2= m1(1,2)*ImRuidoGauss(x-1,y);
       v3= m1(1,3)*ImRuidoGauss(x-1,y+1);
       v4= m1(2,1)*ImRuidoGauss(x,y-1);
       v5= m1(2,2)*ImRuidoGauss(x,y);
       v6= m1(2,3)*ImRuidoGauss(x,y+1);
       v7= m1(3,1)*ImRuidoGauss(x+1,y-1);
       v8= m1(3,2)*ImRuidoGauss(x+1,y);
       v9= m1(3,3)*ImRuidoGauss(x+1,y+1);
       suma=(1/v1)+(1/v2)+(1/v3)+(1/v4)+(1/v5)+(1/v6)+(1/v7)+(1/v8)+(1/v9);
       FiltroArmonico(x,y)=(9)/suma;
       
        
    end
end

imwrite(FiltroArmonico, 'Filtro Armonico.jpg', 'jpg');



%% Filtro Mediana
m1=ones(3);
FiltroMediana=FiltroGeom*0;
for z=1:5;
    for x=2:size(ImOr,1)-1;
        for y=2:size(ImOr,2)-1;

    
         if z==1
           v(1)= m1(1,1)*ImRuidoGauss(x-1,y-1);
           v(2)= m1(1,2)*ImRuidoGauss(x-1,y);
           v(3)= m1(1,3)*ImRuidoGauss(x-1,y+1);
           v(4)= m1(2,1)*ImRuidoGauss(x,y-1);
           v(5)= m1(2,2)*ImRuidoGauss(x,y);
           v(6)= m1(2,3)*ImRuidoGauss(x,y+1);
           v(7)= m1(3,1)*ImRuidoGauss(x+1,y-1);
           v(8)= m1(3,2)*ImRuidoGauss(x+1,y);
           v(9)= m1(3,3)*ImRuidoGauss(x+1,y+1);
           M=median(v);
           FiltroMediana(x,y)=M;
         else
           v(1)= m1(1,1)*FiltroMediana(x-1,y-1);
           v(2)= m1(1,2)*FiltroMediana(x-1,y);
           v(3)= m1(1,3)*FiltroMediana(x-1,y+1);
           v(4)= m1(2,1)*FiltroMediana(x,y-1);
           v(5)= m1(2,2)*FiltroMediana(x,y);
           v(6)= m1(2,3)*FiltroMediana(x,y+1);
           v(7)= m1(3,1)*FiltroMediana(x+1,y-1);
           v(8)= m1(3,2)*FiltroMediana(x+1,y);
           v(9)= m1(3,3)*FiltroMediana(x+1,y+1);
           M=median(v);
           FiltroMediana(x,y)=M;
        end


        end
    end
    switch z
        case 1
            Mediana1=FiltroMediana;
            imwrite(Mediana1, 'Filtro Mediana1.jpg', 'jpg');
        case 2
            Mediana2=FiltroMediana;
            imwrite(Mediana2, 'Filtro Mediana2.jpg', 'jpg');
        case 3
            Mediana3=FiltroMediana;
            imwrite(Mediana3, 'Filtro Mediana3.jpg', 'jpg');
        case 4
            Mediana4=FiltroMediana;
            imwrite(Mediana4, 'Filtro Mediana4.jpg', 'jpg');
        case 5
            Mediana5=FiltroMediana;
            imwrite(Mediana5, 'Filtro Mediana5.jpg', 'jpg');
    end
end



end

