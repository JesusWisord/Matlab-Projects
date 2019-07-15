function [  ] = mtf ( input_args )
%Creacion de 4 im?genes por medio de comandos de MATLAB

%   El programa crea 4 imagenes utilizando unicamente comandos de Matlab.
%   La primera imagen es guardada como "rampa.jpg" la cual representa una
%   gradiente de negro a blanco de izquierda a derecha. La segunda imagen
%   es guardada como "circulo.jpg" la cual crea un fondo negro con un
%   circulo blanco en el centro de 80 pixeles de radio. La tercera imagen
%   es guardada como "circulo_rampa.jpg" y es una combinacion de las dos
%   imagenes anteriores. Un fondo negro, con un circulo en el centro con la
%   gradiente de la primera imagen. La cuarta y ultima imagen creada es una
%   funcion modular de transferencia utilizada normalmente para medir la
%   percepcion de frecuencias espaciales en el ojo humano. Esto se realiza
%   mediante una funcion seno y ciertos parametros de entrada para obtener
%   de salida un cambio de frecuencias y medir con esto que es capaz de ver
%   el ojo humano por medio del usuario.

I=zeros(256); %Inicializamos nuestra matriz de 256x256
I2=I; %Creamos una segunda y tercera matriz del mismo tama?o
I3=I;
for j=1:256; %Recorremos columnas de la matriz
    for i=1:256; %Recorremos renglones de la matriz
        
        a=sqrt((i-128).^2 + (j-128).^2);
% Creamos una variable a que nos ayudar? a almacenar el valor del radio de
% 80 pixeles de un c?rculo con centro en 128,128 (el centro de nuestra
% imagen).
        I(i,j)=j-1; 
%Llenamos nuestra matriz por renglones llendo de 0 a 255 creando as? una
%rampa
        
        if a <= 80
            I2(i,j)=255;
%Si nuestra variable a es menor o igual a 80 esto significa que el pixel
%analizado esta dentro del radio de 80 pixeles que deseamos para nuestro
%circulo.
        else
            I2(i,j)=0;
% Si el pixel esta fuera de este rango entonces le asignaremos un valor de
% 0 para que sea un pixel negro.
        end
        I3(i,j)=(I(i,j)*I2(i,j))/255;
% Para combinar ambas imagenes anteriores es necesario multiplicar el valor
% de cada pixel en cada matriz y dividirlo entre 255. Esto nos permite
% hacer que si el valor de la imagen del circulo es 0 esta se mantendra en
% negro al multiplicarlo y dividirlo entre cualquier numero. En cambio si
% el valor del pixel en el circulo es 255 (por ser un circulo blanco) este
% tomara el valor de la rampa de nuestra primera imagen ya que se esta
% dividiendo entre 255.
            
    end
end

%Transformamos todas nuestras matrices a matrices con valores de 8 bits
I=uint8(I);
I2=uint8(I2);
I3=uint8(I3);
%Inicializamos los parametros para nuestra funcion MTF
f_0 = 0.5; k= 3.5; k1= 0.9;
%Creamos un vector lineal de 1024 elementos con valores desde 0 a pi
x=linspace(0,pi,1024);
%Creamos nuestro vector y con la funci?n seno que crear? nuestra funci?n
%modular de transferencia (MTF)
y= (sin ( 2*pi*f_0* ( k.^(k1*x) )-1 )+1)/2;
%Creamos otro vector lineal de 1024 elementos que tendr? valores de 0 a
%1023
n=linspace(0,1023,1024);
%Creamos nuestro vector de amplitud con nuestro vector n como referencia
s=0.8*exp(0.005415*n);
%Transponemos nuestro vector para obtener un vector de 1024x1 elementos
s=s';
%Hacemos la multiplicacion matricial de y*s para obtener una imagen de
%1024x1024 pixeles de nuestra MTF
I4=s*y;
%Transformamos nuestra matriz a bytes
I4=uint8(I4);
%Guardamos cada una de nuestras matrices como imagen 'jpg'
imwrite(I4,'mtf.jpg','jpg');
imwrite(I, 'rampa.jpg', 'jpg');
imwrite(I2,'circulo.jpg','jpg');
imwrite(I3, 'circulo_rampa.jpg', 'jpg');


end

