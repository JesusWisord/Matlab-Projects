clear all
close all
clc
%% Constantes
N=30;
x=linspace(-2.5,2.5,N);
y=linspace(-2.5,2.5,N);
m1=60;
s1=8;
m2=140;
s2=6;
m3=10;
s3=5;
variables=3;

%creacion de la imagen
im=zeros(N,N);
for k=1:size(im,1)
    for j=1:size(im,2)
        if(sqrt(x(k)^2+y(j)^2)<2)
            if(sqrt(x(k)^2+y(j)^2)>1)
                im(k,j)=m1+s1*randn(1);
            else
                 im(k,j)=m2+s2*randn(1);
            end
        else
            im(k,j)=m3+s3*randn(1);
        end
    end
end
figure(1),imagesc(x,y,im),colormap gray

 %es mi solucion inicial 
sol_in=randi(variables,N);
figure (2), imagesc(sol_in);
colormap gray 

%% Variables para fitness

for n=1:variables
   contador=1;
   for i=1:N
       for j=1:N
            if sol_in(i,j)==n
                values(n,contador)=im(i,j);
                coordenada_x(n,contador)=i;
                coordenada_y(n,contador)=j;
                contador=contador+1;
            end
       end
   end
end

values(values==0)=NaN;
coordenada_x(coordenada_x==0)=NaN;
coordenada_y(coordenada_y==0)=NaN;

promedios=mean(values','omitnan');
varianzas=var(values','omitnan');


%Distancias


distancias=coordenada_x*0;

% for a=1:variables
%    for b=1:(size(coordenada_x,2)-1)
%        for c=1 : (size(coordenada_x,2)-1)
%            distance = ((coordenada_x(a,c)) - (coordenada_x(a,b)))^2 + ((coordenada_y(a,c)) - (coordenada_y(a,b)))^2;
%            distance = sqrt(distance);
%             if ~isnan(distance)
%                 distancias(a,b)=distancias(a,b)+distance;
%             end
%        end
%    end
% end

%Distancias al centro

for a=1:variables
   for b=1:(size(coordenada_x,2))
       distance = (coordenada_x(a,b) - round(N/2))^2 + (coordenada_y(a,b) - round(N/2))^2;
       distance = sqrt(distance);
        if ~isnan(distance)
            distancias(a,b)=distancias(a,b)+distance;
        end
   end
end

prom_distancias=mean((distancias)','omitnan');

fitness=sum(varianzas)/var(promedios)+var(prom_distancias);
% fitness=sum(varianzas)/var(promedios);

%% Recocido Simulado

TEMPERATURA_INICIAL= 10000;
TEMPERATURA_FINAL= .001;
L= 300;
ALFA= .99;

Temperatura=TEMPERATURA_INICIAL;

aux_2=1;
sol_vec=sol_in;
while Temperatura>TEMPERATURA_FINAL

    for aux=1:L

        %Definicion de coordenadas
        x=round(rand*(N-1))+1;
        y=round(rand*(N-1))+1;
        sol_vec=sol_in;
        sol_vec(x,y)=round(rand*2)+1;

        while sol_vec(x,y)==sol_in(x,y)
            sol_vec(x,y)=round(rand*2)+1;
        end


        for n=1:variables
           contador=1;
           for i=1:N
               for j=1:N
                    if sol_vec(i,j)==n
                        values_vec(n,contador)=im(i,j);
                        coordenada_x_vec(n,contador)=i;
                        coordenada_y_vec(n,contador)=j;
                        contador=contador+1;
                    end
               end
           end
        end

        values_vec(values_vec==0)=NaN;
        coordenada_x_vec(coordenada_x_vec==0)=NaN;
        coordenada_y_vec(coordenada_y_vec==0)=NaN;

        promedios_vec=mean(values_vec','omitnan');
        varianzas_vec=var(values_vec','omitnan');


        %Distancias


        distancias_vec=coordenada_x_vec*0;

%        Distancias al centro

        for a=1:variables
           for b=1:(size(coordenada_x_vec,2))
               distance = (coordenada_x_vec(a,b) - round(N/2))^2 + (coordenada_y_vec(a,b) - round(N/2))^2;
               distance = sqrt(distance);
                if ~isnan(distance)
                    distancias_vec(a,b)=distancias_vec(a,b)+distance;
                end
           end
        end

%         for a=1:variables
%            for b=1:(size(coordenada_x_vec,2)-1)
%                for c=1 : (size(coordenada_x_vec,2)-1)
%                    distance = ((coordenada_x_vec(a,c)) - (coordenada_x_vec(a,b)))^2 + ((coordenada_y_vec(a,c)) - (coordenada_y_vec(a,b)))^2;
%                    distance = sqrt(distance);
%                     if ~isnan(distance)
%                         distancias_vec(a,b)=distancias_vec(a,b)+distance;
%                     end
%                end
%            end
%         end

        prom_distancias_vec=mean((distancias_vec)','omitnan');

        fitness_vec=sum(varianzas_vec)/var(promedios_vec)+var(prom_distancias_vec);
%         fitness_vec=sum(varianzas_vec)/var(promedios_vec);




        if fitness_vec<fitness
            sol_in=sol_vec;
            fitness=fitness_vec;
        else
            e=exp((fitness-fitness_vec)/Temperatura);
            if  e > rand
                fitness=fitness_vec;
                sol_in=sol_vec;
            end
        end


    end


    Temperatura=Temperatura*ALFA;
    fitness_vector(aux_2)=fitness;
    aux_2=aux_2+1;
%     figure (3), imagesc(sol_in);
%     colormap gray 

end

figure (3), imagesc(sol_in);
colormap gray 
title('Solución final');

figure(4), plot(fitness_vector,'.')
title('Fitness a través del tiempo')
xlabel('Iteraciones')
ylabel('Valor del Fitness')
