function [promedio,maximo] = algoritmoGenetico(tamanoPoblacion,probabilidadMutacion,probabilidadCruza,numeroDeGeneraciones)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
poblacionInicial=round(rand(tamanoPoblacion,20));


for i=1:tamanoPoblacion
    genotipo_x1=num2str(poblacionInicial((i),1:10));
    genotipo_x2=num2str(poblacionInicial((i),11:20));

    x1=-10+bin2dec(genotipo_x1)*(20/(2^10-1));
    x2=-10+bin2dec(genotipo_x2)*(20/(2^10-1));

    fitnessInicial(i)=150+((x1)^2)*sin(40*pi*x1)+((x2)^2)*sin(20*pi*x2);
end

fitness=fitnessInicial;
poblacionMejor=poblacionInicial;

for generaciones=1:numeroDeGeneraciones
   
    fitnessTotal=sum(fitness);
    
    %Ruleta
    ruleta=fitness./fitnessTotal; 
    
    acum_ruleta=cumsum(ruleta);
    
    %Poblacion Mejor
    for i=1:tamanoPoblacion
       random_number(i)=rand;
       suma=0;
       for n=1:tamanoPoblacion
           if suma<random_number(i) && acum_ruleta(n)>=random_number(i)
            poblacionMejor_pos(i)=(n);
            poblacionMejor_temporal(i,:)=poblacionMejor(n,:);
           end
           suma=acum_ruleta(n);
        end
    end
    
    poblacionMejor=poblacionMejor_temporal;
    
    condicion=1;
    
    %Probabilidad de cruce
    while (condicion)
        probabilidadParaCruza=rand(1,tamanoPoblacion);
        probabilidadParaCruza=probabilidadParaCruza>(1-probabilidadCruza);
        poblacionDeCruza=probabilidadParaCruza.*poblacionMejor_pos;
        poblacionDeCruza(find(poblacionDeCruza==0))=[];
        poblacionDeCruza=unique(poblacionDeCruza);
        condicion=mod(size(poblacionDeCruza,2),2);
    end
    
    %Cruce 
%     poblacionDeCruza=probabilidadParaCruza.*poblacionMejor;
%     poblacionDeCruza(find(poblacionDeCruza==0))=[];
%     poblacionDeCruza=unique(poblacionDeCruza);
    
    %Son dos padres para x1 y dos padres para x2
    for i=1:2:size(poblacionDeCruza,2)
        corte_1=randi(8)+1;
        corte_2=randi(8)+1;
        
        posicion_padre_1=poblacionMejor_pos(poblacionDeCruza(i));
        posicion_padre_2=poblacionMejor_pos(poblacionDeCruza(i+1));
        
        padre_1_x1=poblacionMejor(posicion_padre_1,1:10);
        padre_1_x2=poblacionMejor(posicion_padre_1,11:20);
        
        padre_2_x1=poblacionMejor(posicion_padre_2,1:10);
        padre_2_x2=poblacionMejor(posicion_padre_2,11:20);
        
        hijo_1_x1=[padre_1_x1(1:corte_1), padre_2_x1(corte_1+1:end)];
        hijo_2_x1=[padre_2_x1(1:corte_1), padre_1_x1(corte_1+1:end)];
        
        hijo_1_x2=[padre_1_x2(1:corte_2), padre_2_x2(corte_2+1:end)];
        hijo_2_x2=[padre_2_x2(1:corte_2), padre_1_x2(corte_2+1:end)];
        
        hijo_1=[hijo_1_x1 hijo_1_x2];
        hijo_2=[hijo_2_x1 hijo_2_x2];
        
        poblacionMejor(posicion_padre_1,:)=hijo_1;
        poblacionMejor(posicion_padre_2,:)=hijo_2;
        
    end
    
    
    %Mutacion
    
    genesAMutacion=rand(tamanoPoblacion,20);
    genesAMutacion=genesAMutacion>(1-probabilidadMutacion);
    
    [x,y]=find(genesAMutacion==1);
    
    for i=1:size(x,1)
       poblacionMejor(x(i),y(i))=~poblacionMejor(x(i),y(i)); 
    end
    
    
    for i=1:tamanoPoblacion
        genotipo_x1=num2str(poblacionMejor((i),1:10));
        genotipo_x2=num2str(poblacionMejor((i),11:20));

        x1=-10+bin2dec(genotipo_x1)*(20/(2^10-1));
        x2=-10+bin2dec(genotipo_x2)*(20/(2^10-1));

        fitness(i)=150+((x1)^2)*sin(40*pi*x1)+((x2)^2)*sin(20*pi*x2);
    end
    
%     figure(2)
%     plot(fitness)
%     title('Fitness por individuo')
%     xlabel('Individuo')
%     ylabel('Fitness del Inidividuo')
%     pause;
    fitness_promedio(generaciones)=mean(fitness,2);
    fitness_mayor(generaciones)=max(fitness);
    
    
    
end

promedio=mean(fitness_promedio,2);
maximo=mean(fitness_mayor);

figure(1), plot(fitness_promedio)
title('Fitness a traves del tiempo (promedio)')
xlabel('Generaciones')
ylabel('Promedio del fitness de la población')
% figure(2), plot(fitness_mayor)

end

