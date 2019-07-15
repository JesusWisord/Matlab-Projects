function [fitness] = recocidoSimulado(TEMPERATURA_INICIAL, TEMPERATURA_FINAL, L, ALFA, MATRIZ)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%%Declaracion de variables constantes
    
    
    Temperatura=TEMPERATURA_INICIAL;
    
    matriz=MATRIZ;
    
    %Declaracion de vector y ganancia
    
    

    aux_2=1;
    
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

            if ganancia_vecina <= fitness
                fitness=ganancia_vecina;
                vector=vector_vecino;
            else
                e=exp((fitness-ganancia_vecina)/Temperatura);
                if  e > rand
                    fitness=ganancia_vecina;
                    vector=vector_vecino;
                end
            end
        end


        Temperatura=Temperatura*ALFA;

        vector_temperaturas(aux_2)=fitness;
        aux_2=aux_2+1;

        fitness;
    end

%     plot(vector_temperaturas,'o')
end

