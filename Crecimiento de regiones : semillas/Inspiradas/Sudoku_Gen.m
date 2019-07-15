close all
clearvars
clc

%Hiperparametros

tamanoPoblacion=50;
probabilidadMutacion=0.1;
probabilidadCruza=0.7;
numeroDeGeneraciones=50;


SudokuAResolver=[0 0 5 4 0 0 0 7 0;
6 0 7 0 0 2 0 9 0;
2 1 9 0 0 0 4 8 0;
0 6 0 2 5 0 0 0 0;
5 0 0 0 0 0 8 0 2;
7 0 0 0 8 3 9 5 0;
8 0 0 0 0 5 0 0 0;
9 0 4 3 0 0 0 0 0;
0 5 0 0 0 8 7 0 0]


for k=1:tamanoPoblacion
    for i=1:3
        for j=1:3
           variableASumarI=3*(i-1);
           variableASumarJ=3*(j-1);
           cuadranteaux=reshape(randperm(9),3,3);
           cuadranteInicial=SudokuAResolver((1:3)+variableASumarI,(1:3)+variableASumarJ);
           [x,y]=find(cuadranteInicial~=0);
           for n=1:size(x,1)
               auxiliar=cuadranteaux(x(n),y(n));
               cuadranteaux(cuadranteaux==cuadranteInicial(x(n),y(n)))=auxiliar;
               cuadranteaux(x(n),y(n))=cuadranteInicial(x(n),y(n));
           end
           cuadrante(:,:,j)=cuadranteaux;
        end
        individuo(:,:,(1:3)+variableASumarI)=cuadrante;
    end
    poblacionInicial(:,:,k)=[individuo(:,:,1), individuo(:,:,2) individuo(:,:,3);
        individuo(:,:,4), individuo(:,:,5), individuo(:,:,6);
        individuo(:,:,7), individuo(:,:,8), individuo(:,:,9)];
end

for i=1:tamanoPoblacion
    suma=1;
    for j=1:9
        a=unique(poblacionInicial(j,:,i));
        b=unique(poblacionInicial(:,j,i));
        suma=suma+(9-size(a,2))+(9-size(b,1));
    end
    Errores(i)=suma;
end


fitness=1./Errores;
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
            poblacionMejor_temporal(:,:,i)=poblacionMejor(:,:,n);
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
        corte_1=randi(2);
        
        posicion_padre_1=poblacionDeCruza(i);
        posicion_padre_2=poblacionDeCruza(i+1);
        
        padre_1=poblacionMejor(:,:,posicion_padre_1);
        
        padre_2=poblacionMejor(:,:,posicion_padre_2);
        
        hijo_1=[padre_1(:,1:corte_1*3), padre_2(:,(corte_1)*3+1:end)];
        hijo_2=[padre_2(:,1:corte_1*3), padre_1(:,(corte_1)*3+1:end)];
        
        poblacionMejor(:,:,posicion_padre_1)=hijo_1;
        poblacionMejor(:,:,posicion_padre_2)=hijo_2;
        
    end
    
    %Mutacion
    
    genesAMutacion=rand(3,3,tamanoPoblacion);
    genesAMutacion=genesAMutacion>(1-probabilidadMutacion);
    
    [a,b,c] = ind2sub(size(genesAMutacion),find(genesAMutacion == 1));
    
    for i=1:size(a,1)
       variableASumarI=3*(a(i)-1);
       variableASumarJ=3*(b(i)-1);
       cuadranteaux=poblacionInicial((1:3)+variableASumarI,(1:3)+variableASumarJ);
       cuadranteInicial=SudokuAResolver((1:3)+variableASumarI,(1:3)+variableASumarJ);
       [x,y]=find(cuadranteInicial==0);
       random=randi(size(x,1),1,2);
       while size(unique(random),2)<2
           random=randi(size(x,1),1,2);
       end
       for n=1:2
           auxiliar=cuadranteaux(x(random(n)),y(random(n)));
           cuadranteaux(cuadranteaux==cuadranteInicial(x(random(n)),y(random(n))))=auxiliar;
           cuadranteaux(x(random(n)),y(random(n)))=cuadranteInicial(x(random(n)),y(random(n)));
       end
       poblacionInicial((1:3)+variableASumarI,(1:3)+variableASumarJ,c(i))= cuadranteaux;
    end
    
    
    for i=1:tamanoPoblacion
        suma=1;
        for j=1:9
            a=unique(poblacionInicial(j,:,i));
            b=unique(poblacionInicial(:,j,i));
            suma=suma+(9-size(a,2))+(9-size(b,1));
        end
        Errores(i)=suma;
    end
    fitness=1./Errores;
%     figure(2)
%     plot(fitness)
%     title('Fitness por individuo')
%     xlabel('Individuo')
%     ylabel('Fitness del Inidividuo')
%     pause;
    fitness_promedio(generaciones)=mean(fitness,2);
    fitness_mayor(generaciones)=max(fitness);
    
    
    
end

figure(1), plot(fitness_mayor)
title('Fitness a traves del tiempo (promedio)')
xlabel('Generaciones')
ylabel('Promedio del fitness de la población')
% figure(2), plot(fitness_mayor)
