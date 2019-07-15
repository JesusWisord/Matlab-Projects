clearvars

DIR='Parte_2/';


IMAGEN=imread(strcat(DIR, 'face04.ppm'));

K=4;

%Modelo HSV

HSV=rgb2hsv(IMAGEN);

minValue=min(min(HSV(:,:,1)));
maxValue=max(max(HSV(:,:,1)));

[vls pks]=findpeaks(imhist(HSV),'minPeakDistance',floor(255/K*.5));

semillas=pks(1:K)/255;

imagen_k_hsv= bayes(K,HSV,semillas);

% imshow(hsv2rgb(imagen_k_hsv));
% figure, imshow(IMAGEN);

%Modelo RGB

imagen_rgb=(IMAGEN);

[vls pks]=findpeaks(imhist(imagen_rgb),'minPeakDistance',floor(255/K*.5));

semillas=pks(1:K);

imagen_k_rgb=bayes(K,double(imagen_rgb),semillas);
%imagen_k_rgb=uint8(imagen_k_rgb);



%Modelo RGB normalizado

imagen_rgb_norm=double(IMAGEN)/255;

[vls pks]=findpeaks(imhist(imagen_rgb_norm),'minPeakDistance',floor(255/K*.5));

semillas=pks(1:K)/255;

imagen_k_rgb_norm=bayes(K,imagen_rgb_norm,semillas);


%Desplegar imagenes

figure(1), imshow(IMAGEN), title('Imagen original')
imwrite(IMAGEN,'ImagenOriginal.png');
figure(2), imshow(hsv2rgb(imagen_k_hsv)), title('Imagen HSV segmentada')
imwrite(hsv2rgb(imagen_k_hsv),'ImagenHSV.png');
figure(3), imshow(uint8(imagen_k_rgb)), title('Imagen RGB segmentada')
imwrite(uint8(imagen_k_rgb),'ImagenRGB.png');
figure(4), imshow((imagen_k_rgb_norm)), title('Imagen RGB normalizada segmentada')
imwrite(imagen_k_rgb_norm,'ImagenRGBnormalizada.png');


%FUNCIONES

function [imagen_k] = bayes(K,IMAGEN,semillas)
    N=K;
    for x=1:size(IMAGEN,1)
        for y=1:size(IMAGEN,2)
            for z=1:size(IMAGEN,3)
                %Se calcularán las N distancias de los niveles de color a las
                %K's para asignar la más cercana
                distancia=abs(IMAGEN(x,y,z)-semillas);
                k_asignada=find(distancia==min(distancia));
                imagen_k(x,y,z)=semillas(k_asignada(1));
            end
        end
    end
    
    condicion=0;
    
    while  ~condicion
     
        %Se actualizan las K's
        for i=1:N
           suma=sum(IMAGEN(imagen_k==(semillas(i))));
           if suma~=0
              K_nueva(i)=((suma*semillas(i))/(suma));
           else
               K_nueva(i)=semillas(i);
           end
        end

        for x=1:size(IMAGEN,1)
            for y=1:size(IMAGEN,2)
                for z=1:size(IMAGEN,3)
                    %Se calcularán las N distancias de los niveles de color a las
                    %K's para asignar la más cercana
                    distancia=abs(IMAGEN(x,y,z)-K_nueva);
                    k_asignada=find(distancia==min(distancia));
                    imagen_k(x,y,z)=K_nueva(k_asignada(1));
                end
            end
        end

        condicion= K_nueva==K;
        K=double(K_nueva);
    end
    
end