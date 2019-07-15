function [C, M, Y] = Modelos_de_Color( input_args )
%Modelos de Color
%   Este programa lee una imagen llamada 'flowers1.ppm', una imagen en RGB
%   y la transforma en CMY y a HSI y de vuelta a RGB.

%Leemos nuestra imagen 
Im=imread('flowers1.ppm');

%Separamos nuestras matrices de colores en 3 matrices destinadas a cada
%color
R=double(Im(:,:,1));
G=double(Im(:,:,2));
B=double(Im(:,:,3));

%Normalizamos nuestros valores
R=R/255; G=G/255; B=B/255;

%Obtenemos el negativo de cada color para as? tener nuestro color Cyan del
%Rojo, Magenta del Verde y Amarilo del Azul
C=1-R; M=1-G; Y=1-B;

%Creamos una nueva matriz llamada CMY y asignamos cada color a su
%respectiva matriz
CMY(:,:,1)=C; CMY(:,:,2)=M; CMY(:,:,3)=Y;

%Regresamos a nuestro RGB original a partir de CMY con una simple operacion
%guardando en una nueva matriz para poder hacer comparaciones en nuestras
%matrices
RGB1(:,:,1)=1-C; RGB1(:,:,2)=1-M; RGB1(:,:,3)=1-Y;

%Recorremos pixel por pixel nuestra matriz
for i=1:size(Im,1);
    for j=1:size(Im,2);
        
        %Creamos dos variables auxiliares para, posteriormente, hacer
        %nuestra division de manera mas sencilla y optimizar mas la lectura
        %del codigo
        aux=(1/2)*( (R(i,j)-G(i,j))+(R(i,j)-B(i,j)) );
        %En esta parte agregamos un valor de 0.00000001 para a?adir
        %estabilidad a la operacion
        aux1=( (R(i,j)-G(i,j))^2 + ((R(i,j)-B(i,j))*(G(i,j)-B(i,j))) )^(1/2)+0.00000001;
        %Creamos una matriz Tetta que nos ayudara a calcular nuestro valor
        %de Hue (Brillo) de nuestra nueva matriz
        Tetta(i,j)= acosd (aux/aux1);
        %Dependiendo de nuestro sector B G usaremos uno u otro valor de
        %Tetta
        if B(i,j)<=G(i,j)
            H(i,j)=(round(Tetta(i,j)));
        else
            H(i,j)=(360-round(Tetta(i,j)));
        end
        %Usamos otra variable auxiliar para encontrar nuestro valor minimo
        %de nuestros pixeles
        num=min([R(i,j),G(i,j),B(i,j)]);
        %Creamos una segunda variable auxiliar igualmente aumentando
        %0.00000001 para darle estabilidad
        aux2=3/(R(i,j)+G(i,j)+B(i,j)+0.00000001);
        %Calculamos nuestro valor S o Saturaci?n
        S(i,j)=1-(aux2*num);
        %Calculamos nuestro valor de Intensidad
        I(i,j)=(1/3)*(R(i,j)+B(i,j)+G(i,j));
    
    end
end
%Guardamos nuestra matriz HSI con los valores calculados en nuestras
%antiguas matrices y posteriormente normalizamos nuestra matriz H para
%tener valores de 0 a 1.
HSI(:,:,1)=H/360; HSI(:,:,2)=S; HSI(:,:,3)=I;
%Ecualizamos nuestra matriz I para obtener una Intensidad m?s separada y
%obtener una imagen con mejor nitidez.
I=histeq(I);

%Volvemos a recorrer nuestra matriz pixel por pixel
for i=1:size(Im,1);
    for j=1:size(Im,2);
        
        %Dependiendo de nuestro valor en H obtendremos nuestros valores RGB
        %con las siguientes formulas
        if 0 <= H(i,j) & H(i,j) < 120;
            H2(i,j)=H(i,j);
            B2(i,j)=I(i,j)*(1-S(i,j));
            R2(i,j)=I(i,j)*(1+((S(i,j)*cosd(H2(i,j)))/ cosd(60-H2(i,j))));
            G2(i,j)= 3*I(i,j) - (R2(i,j)+B2(i,j));
        end
        if 120 <= H(i,j) & H(i,j) < 240;
            H2(i,j)=H(i,j)-120;
            R2(i,j)=I(i,j)*(1-S(i,j));
            G2(i,j)=I(i,j)*(1+((S(i,j)*cosd(H2(i,j)))/ cosd(60-H2(i,j))));
            B2(i,j)= 3*I(i,j) - (R2(i,j)+G2(i,j));
        end
        if 240 <= H(i,j) & H(i,j) < 360;
            H2(i,j)=H(i,j)-240;
            G2(i,j)=I(i,j)*(1-S(i,j));
            B2(i,j)=I(i,j)*(1+((S(i,j)*cosd(H2(i,j)))/ cosd(60-H2(i,j))));
            R2(i,j)= 3*I(i,j) - (G2(i,j)+B2(i,j));
        end
        
        
            
        
    end
end

%Guardamos nuestra segunda matriz de RGB ya ecualizada.
RGB2(:,:,1)=R2; RGB2(:,:,2)=G2; RGB2(:,:,3)=B2;


%Guardamos todas nuestras matrices en formato jpg.

imwrite(Im,'Original.jpg','jpg');
imwrite(CMY,'CMY.jpg','jpg');
imwrite(RGB1,'CMY_A_RGB.jpg','jpg');
imwrite(HSI,'HSI.jpg','jpg');
imwrite(RGB2,'Cambio_En_HSI.jpg','jpg');
end

