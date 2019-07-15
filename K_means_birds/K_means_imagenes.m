%Se inicializa todo
clearvars
clc
close all

%Se lee la imagen pasandola a un formato doble
IMAGEN=double(imread('bird_small.jpg'));

%Se muestren N cantidad de colores que representarán las K's

N=16;
for i=1:N
    x=randi(size(IMAGEN,1));
    y=randi(size(IMAGEN,2));
    K(i)=IMAGEN(x,y,randi(3));
        A=unique(K);
        if size(A)<N
            i=1;
        end
end


%Se recorrera la imagen por capas tomando ejes en [x y z]
%Esta es la primera iteracion
for x=1:size(IMAGEN,1)
    for y=1:size(IMAGEN,2)
        for z=1:size(IMAGEN,3)
            %Se calcularán las N distancias de los niveles de color a las
            %K's para asignar la más cercana
            distancia=abs(IMAGEN(x,y,z)-K);
            k_asignada=find(distancia==min(distancia));
            imagen_k(x,y,z)=K(k_asignada(1));
        end
    end
end

condicion=0;

while  ~condicion
     
    %Se actualizan las K's
    for i=1:N
       suma=sum(IMAGEN(imagen_k==K(i)));
       if suma~=0
          K_nueva(i)=((suma*K(i))/(suma)) 
       else
           K_nueva(i)=K(i)
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
    K=K_nueva;
end


%Se procede a asignar las K's halladas a la imagen grande
IMAGEN_2=double(imread('bird_large.jpg'));

for x=1:size(IMAGEN_2,1)
    for y=1:size(IMAGEN_2,2)
        for z=1:size(IMAGEN_2,3)
            distancia=abs(IMAGEN_2(x,y,z)-K);
            k_asignada=find(distancia==min(distancia));
            imagen_k2(x,y,z)=K(k_asignada(1));
        end
    end
end

imshow(uint8(round(imagen_k2)))
