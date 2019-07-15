function [ganancia] = recocidoSimulado(TEMPERATURA_INICIAL, TEMPERATURA_FINAL, L, ALFA)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%%Declaracion de variables constantes
    
%     TEMPERATURA_INICIAL=5; TEMPERATURA_FINAL=.001;
%     ALFA=.95; L=5;

    Matriz=[0 0 0 0;
        0.28 0.25 .15 .20;
        0.45 0.41 0.25 0.33;
        0.65 0.55 0.40 0.42;
        0.78 0.65 0.50 0.48;
        0.90 .75 .62 .53;
        1.02 .80 .73 .56;
        1.13 .85 .82 .58;
        1.23 .88 .90 .60;
        1.32 .90 .96 .60;
        1.38 .90 1 .60];

    Matriz=Matriz*-1;

    %MAXIMO=10; MINIMO=0; SUMA=10;
    

    Temperatura=TEMPERATURA_INICIAL;

    %Declaracion de vector y ganancia

    primer_numero=round(rand*10);
    suma=primer_numero;
    segundo_numero=round(rand*(10-suma));
    suma=suma+segundo_numero;
    tercer_numero=round(rand*(10-suma));
    suma=suma+tercer_numero;
    cuarto_numero=10-suma;
    vector=[primer_numero segundo_numero tercer_numero cuarto_numero];
    vector_vecino=vector;


    aux_2=1;

    ganancia=Matriz(vector(1)+1,1)+Matriz(vector(2)+1,2)+Matriz(vector(3)+1,3)+Matriz(vector(4)+1,4);
    while Temperatura>TEMPERATURA_FINAL


        for aux=1:L
            %Declaracion de numeros a cambiar para calcular vecino
            vecino_1=round((rand*3))+1;
            vector_vecino=vector;
            while isequal(vector,vector_vecino)
                if vector(vecino_1)<=10 && vector(vecino_1)>0
                   vector_vecino(vecino_1)=vector_vecino(vecino_1)-1;
                else
                    vecino_1=round((rand*3))+1;
                end
            end

            while sum(vector_vecino)<10
                vecino_2=round((rand*3))+1;
                if vecino_2==vecino_1
                    vecino_2=round((rand*3))+1;
                else
                    if vector(vecino_2)<10 && vector(vecino_2)>=0
                        vector_vecino(vecino_2)=vector_vecino(vecino_2)+1;
                    else
                        vecino_2=round((rand*3))+1;
                    end
                end
            end

            ganancia_vecina=Matriz(vector_vecino(1)+1,1)+Matriz(vector_vecino(2)+1,2)+Matriz(vector_vecino(3)+1,3)+Matriz(vector_vecino(4)+1,4);

            if ganancia_vecina <= ganancia
                ganancia=ganancia_vecina;
                vector=vector_vecino;
            else
                e=exp((ganancia-ganancia_vecina)/Temperatura);
                if  e > rand
                    ganancia=ganancia_vecina;
                    vector=vector_vecino;
                end
            end
        end


        Temperatura=Temperatura*ALFA;

        vector_temperaturas(aux_2)=ganancia;
        aux_2=aux_2+1;

        ganancia;
    end

%     plot(vector_temperaturas,'o')
end

