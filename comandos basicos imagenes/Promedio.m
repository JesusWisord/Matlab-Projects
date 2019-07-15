function [ output_args ] = Promedio( input_args )
%Promedio de una imagen
%   Programa que lee 4 imagenes especificas, una sin turbulencias y 3 con
%   distintos niveles de turbulencia. Sacaremos promedio de nuestras 3
%   imagenes turbulentas para comparar la eficacia de un promedio entre
%   estas para disminuir esta turbulencia.


%Leemos nuestras 4 imagenes, una sin turbulencias y otras 3 con distintos
%niveles de turbulencia
I=imread('aerial_view_no_turb.tif');
I2=imread('aerial_view_turb_c1.tif');
I3=imread('aerial_view_turb_C2.tif');
I4=imread('aerial_view_turb_c3.tif');
%Les damos un formato doble a nuestras imagenes a modificar
I2=double(I2);
I3=double(I3);
I4=double(I4);
%Sumamos nuestras tres imagenes en una nueva matriz
res=I2+I3+I4;
%Dividimos este resultado entre 3 para obtener un promedio de nuestras
%turbulencias
res=res/3;
%Devolvemos un formato de 8 bits
res=uint8(res);
%Guardamos nuestra imagen
imwrite(res,'promedio.jpg','jpg');
%Mostramos nuestras dos imagenes para compararlas
figure(2), imshow(res);
figure(1), imshow(I);



end

