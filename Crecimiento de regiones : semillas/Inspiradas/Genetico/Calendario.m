clearvars

%Constantes
TABLA=xlsread('datos para calendario.xls');
PERSONAL_DISPONIBLE=8;
ESTACIONES_DISPONIBLES=6;
SEMANAS=50;
HORAS_POR_PERSONA=8;
BITS=7;

%Hiperparametros

% tamanoPoblacion=SEMANAS;
% probabilidadMutacion=0.05;
% probabilidadCruza=0.1;
% numeroDeGeneraciones=150;

%Mejores Parametros
%Sin poblacion
tamanoPoblacion=SEMANAS;
probabilidadMutacion=0.05;
probabilidadCruza=0.3;
numeroDeGeneraciones=75;

%Con poblacion

% tamanoPoblacion=5;
% probabilidadMutacion=0.05;
% probabilidadCruza=0.2;
% numeroDeGeneraciones=25;


%Limites


%Solucion Inicial
%Aleatoria
solucionInicial=round(rand(SEMANAS,201));


for contadorGlobal=1:tamanoPoblacion
    %Busco todos los 1's pues representan cuales aparatos entre los 200 que
    %tenemos entrarán a mantenimiento
    [pos]=find(solucionInicial(contadorGlobal,1:200)==1);
    %Los ordeno aleatoriamente
    pos_rand = pos(randperm(length(pos)));

    clear personal tiempo estaciones costos estacion
    %Obtengo su respectivo personal requerido, tiempo requerido, estaciones
    %requeridas y el costo.
    personal(:)=TABLA(pos_rand,2);
    tiempo(:)=TABLA(pos_rand,3);
    estaciones(:)=TABLA(pos_rand,4);
    costos(:)=TABLA(pos_rand,5);
    
    %Inicializo variables a utilizar
    contador=1;
    suma=0;
    estacion(1)=0;
    
    %Vamos a recorrer todas nuestras posiciones anteriores
    %Este ciclo es para asegurar que nuestras estaciones no se exceden, es
    %decir que queden aparatos que ocupen solo esas estaciones
    while contador<=size(estaciones,2)
       suma=suma+estaciones(contador);
       if suma>6
           suma=suma-estaciones(contador);
           estacion(end+1)=contador-1;
           suma=0;
           continue
       end
       contador=contador+1;
    end
    
    %Lo que obtengo en estaciones son los intervalos de posiciones, le
    %agrego el último valor que corresponde con la ultima posicion que
    %tenemos
    estacion(end+1)=size(estaciones,2);
    %Inicializo variables
    tiempoRequerido=zeros(size(estacion,2)-1,6);
    personalRequerido=zeros(size(estacion,2)-1,6);
    posiciones=zeros(size(estacion,2)-1,6);
    estacionesRequeridas=zeros(size(estacion,2)-1,6);
    costosRequeridos=zeros(size(estacion,2)-1,6);

    for i=1:(size(estacion,2)-1)
        %Creo vectores que correspondan a las estaciones ocupadas con su
        %respectivo tiempo, personal y costo.
        difference=-(estacion(i))+estacion(i+1);
        tiempoRequerido(i,1:difference)=tiempo(estacion(i)+1:estacion(i+1));
        personalRequerido(i,1:difference)=personal(estacion(i)+1:estacion(i+1));
        estacionesRequeridas(i,1:difference)=estaciones(estacion(i)+1:estacion(i+1));
        posiciones(i,1:difference)=pos_rand(estacion(i)+1:estacion(i+1));
        costosRequeridos(i,1:difference)=costos(estacion(i)+1:estacion(i+1));
    end
    
    %Obtengo que para cada tanda de equipos que entran a las estaciones
    %cuantos trabajadores ocupan.
    personalRequerido_suma=sum(personalRequerido,2);
    
    maxTiempoRequerido=max(tiempoRequerido,[],2);
    tiempoTotalPorDia(contadorGlobal)=sum(maxTiempoRequerido);
    personalRequeridoPorHoras(contadorGlobal)=ceil(tiempoTotalPorDia(contadorGlobal)/8);
    
    costoSemanal(contadorGlobal)=(sum(sum(costosRequeridos)));
end

minimoPersonalNumerico=min(personalRequeridoPorHoras)+1;
%personalRequeridoPorHoras=personalRequeridoPorHoras-(minimoPersonalNumerico);

costosParaFitness=costoSemanal./(personalRequeridoPorHoras);

fitness=costosParaFitness;


%Obtengo el fitness de cada renglon

% fitness=costoSemanal;


poblacionMejor=solucionInicial;



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
    for i=1:2:size(poblacionDeCruza,2)
        corte_1=randi(199)+1;
        
        posicion_padre_1=poblacionDeCruza(i);
        posicion_padre_2=poblacionDeCruza(i+1);
        
        padre_1=poblacionMejor(posicion_padre_1,:);
        padre_2=poblacionMejor(posicion_padre_2,:);
                
        hijo_1=[padre_1(1:corte_1), padre_2(corte_1+1:end)];
        hijo_2=[padre_2(1:corte_1), padre_1(corte_1+1:end)];
        
        
        poblacionMejor(posicion_padre_1,:)=hijo_1;
        poblacionMejor(posicion_padre_2,:)=hijo_2;
        
    end
    
    %Mutacion
    
    genesAMutacion=rand(tamanoPoblacion,201);
    genesAMutacion=genesAMutacion>(1-probabilidadMutacion);
    
    [x,y]=find(genesAMutacion==1);
    
    for i=1:size(x,1)
       poblacionMejor(x(i),y(i))=~poblacionMejor(x(i),y(i)); 
    end
    
    
    for contadorGlobal=1:tamanoPoblacion
        %Busco todos los 1's pues representan cuales aparatos entre los 200 que
        %tenemos entrarán a mantenimiento
        [pos]=find(poblacionMejor(contadorGlobal,1:200)==1);
        %Los ordeno aleatoriamente
        pos_rand = pos(randperm(length(pos)));

        clear personal tiempo estaciones costos estacion
        %Obtengo su respectivo personal requerido, tiempo requerido, estaciones
        %requeridas y el costo.
        personal(:)=TABLA(pos_rand,2);
        tiempo(:)=TABLA(pos_rand,3);
        estaciones(:)=TABLA(pos_rand,4);
        costos(:)=TABLA(pos_rand,5);

        %Inicializo variables a utilizar
        contador=1;
        suma=0;
        estacion(1)=0;

        %Vamos a recorrer todas nuestras posiciones anteriores
        %Este ciclo es para asegurar que nuestras estaciones no se exceden, es
        %decir que queden aparatos que ocupen solo esas estaciones
        while contador<=size(estaciones,2)
           suma=suma+estaciones(contador);
           if suma>6
               suma=suma-estaciones(contador);
               estacion(end+1)=contador-1;
               suma=0;
               continue
           end
           contador=contador+1;
        end

        %Lo que obtengo en estaciones son los intervalos de posiciones, le
        %agrego el último valor que corresponde con la ultima posicion que
        %tenemos
        estacion(end+1)=size(estaciones,2);
        %Inicializo variables
        tiempoRequerido=zeros(size(estacion,2)-1,6);
        personalRequerido=zeros(size(estacion,2)-1,6);
        posiciones=zeros(size(estacion,2)-1,6);
        estacionesRequeridas=zeros(size(estacion,2)-1,6);
        costosRequeridos=zeros(size(estacion,2)-1,6);

        for i=1:(size(estacion,2)-1)
            %Creo vectores que correspondan a las estaciones ocupadas con su
            %respectivo tiempo, personal y costo.
            difference=-(estacion(i))+estacion(i+1);
            tiempoRequerido(i,1:difference)=tiempo(estacion(i)+1:estacion(i+1));
            personalRequerido(i,1:difference)=personal(estacion(i)+1:estacion(i+1));
            estacionesRequeridas(i,1:difference)=estaciones(estacion(i)+1:estacion(i+1));
            posiciones(i,1:difference)=pos_rand(estacion(i)+1:estacion(i+1));
            costosRequeridos(i,1:difference)=costos(estacion(i)+1:estacion(i+1));
        end

        %Obtengo que para cada tanda de equipos que entran a las estaciones
        %cuantos trabajadores ocupan.
        personalRequerido_suma=sum(personalRequerido,2);

        maxTiempoRequerido=max(tiempoRequerido,[],2);
        tiempoTotalPorDia(contadorGlobal)=sum(maxTiempoRequerido);
        personalRequeridoPorHoras(contadorGlobal)=ceil(tiempoTotalPorDia(contadorGlobal)/8);

        costoSemanal(contadorGlobal)=(sum(sum(costosRequeridos)));
    end

    minimoPersonalNumerico=min(personalRequeridoPorHoras)+1;
    personalRequeridoPorHoras=personalRequeridoPorHoras-(minimoPersonalNumerico);
    repeticionesDeEquipos=sum(sum(solucionInicial(:,1:200)));

    penalizacionGlobal=repeticionesDeEquipos;

    costosParaFitness=costoSemanal./(personalRequeridoPorHoras);

    fitnessPenalizado=costosParaFitness;


    %Obtengo el fitness de cada renglon

    fitness=costosParaFitness;
    poblacionMejor=solucionInicial;
    
    fitness_vector(generaciones)=1/std(costoSemanal);
    
    %imagesc(poblacionMejor)
    
    
end



