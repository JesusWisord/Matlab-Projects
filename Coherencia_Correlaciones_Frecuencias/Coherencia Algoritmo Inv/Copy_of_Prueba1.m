%Se define nuestra frecuencia de muestreo

Fs=0.5;

%Se leen nuestros datos
load('FHR.dat');
load('UA.dat');

%Se calcula la coherencia de las señales y se muestra la grafica
figure(1), mscohere(UA,FHR,[],[],[],Fs), title('Coherence Estimate Via Welch Pre-Processing')

%Se define el tamaño de la ventana para promediar la señal. Cada 18
%muestras se promediará y se comparará con el valor anterior, en caso de
%que sea superior al anterior se guardará la muestra en un vector para
%tomar de referencia para las ventanas en el BPRSA
T=18;
%Se utiliza un auxiliar para guardar las localizaciones de las muestras
%"marcadas"
aux=1;

%Comenzamos a recorrer el ciclo para calcular promedios cada 18 muestras.
%Inmediatamente se compara con el valor anterior para saber si la muestra
%puede ser utilizada en el algoritmo BPRSA
for c=1:450-17;
   
   %Fijamos la muestra de inicio
   start=c;
   %Tomamos la muestra final para tener 18 muestras
   finish=c+17;
   %Se calcula el promedio de esas 18 muestras y se guardan en un vector
   meanAux(c)=mean(UA(start:finish));
   
   %Si estamos en la muestra 2 (para poder comparar con la anterior) y si
   %la muestra actual es mayor a la anterior entonces guardamos la
   %localización de esa muestra y aumentamos nuestro auxiliar para obtener
   %un vector limpio.
   if c>1 && meanAux(c)>meanAux(c-1)
      locs(aux)=c;
      aux=aux+1;
   end
   
end

%Reiniciamos nuestra variable auxiliar.
aux=1;
%Definimos el tamaño de nuestras matrices de BPRSA para optimizar el
%programa
BPRSA_FHR=zeros(size(locs,2),101);
BPRSA_UA=BPRSA_FHR;
%Definimos nuestra variable de ventana para llenarla
window=0;
%Se calcula el BPRSA
for c=1:size(locs,2)
   
    %El articulo menciona que es mejor utilizar todas las ventanas posibles
    %aun cuando estas puedan tener valores en ceros. Así que si la ventana
    %no puede ser llenada por estar en un espacio anterior al 51 la
    %llenaremos con ceros. 
    if (locs(c)<=50)
        %Marcamos nuestro inicio. En este caso si restaramos de nuestra
        %muestra 50 valores tendriamos un valor negativo, por eso dejamos
        %el inicio en 1 para no tener errores lógicos
        begin=1;
        %Marcamos nuestro final 50 muestras posteriores
        finish=(locs(c)+50);
        %La ventana será llenada con ceros en donde los valores sean
        %menores a 1
        window(1:(50-locs(c)+1))=0;
        %Posteriormente llenamos con los valores reales de la Frecuencia
        %Cardiaca
        window((50-locs(c)+2):101)=FHR(begin:finish);
        %Guardamos nuestro vector
        BPRSA_FHR(c,:)=window;
        %Aplicamos lo mismo con nuestra actividad uterina
        window((50-locs(c)+2):101)=UA(begin:finish);
        %Guardamos esta ventana en una matriz
        BPRSA_UA(c,:)=window;
        
        %Ahora si nuestra ventana en lugar de ser menor a 50 resulta ser
        %mayor a 400 entonces habrá que llenar de ceros la parte derecha
        %del vector
    else, if locs(c)>=401
            
            %Marcamos nuestro inicio 50 muestras anteriores
            begin=locs(c)-50;
            %Nuestro final 50 muestras posteriores
            finish=locs(c)+50;
            %Comenzamos un ciclo de inicio a fin
            for n=begin:finish
                %Si la muestra excede nuestra señal original entonces
                %pondremos un cero en nuestra ventana
                if n>450
                    window(aux)=0;
                %En caso contrario copiamos el valor de nuestra señal a
                %nuestra ventana
                else
                    window(aux)=FHR(n);
                end
                aux=aux+1;
            end
            aux=1;
            %Guardamos la ventana en la matriz correspondiente
            BPRSA_FHR(c,:)=window;
            %Aplicamos el mismo procedimiento con el vector de la Actividad
            %Uterina
            for n=begin:finish
                if n>450
                    window(aux)=0;
                else
                    window(aux)=UA(n);
                end
                aux=aux+1;
            end
            %Lo guardamos en nuestra señal
            BPRSA_UA(c,:)=window;
            else
            %En caso que no se exceda ni antes ni después copiamos
            %directamente los valores a la ventana.
            
            %Marcamos nuestro inicio
                begin=(locs(c)-50);
            %Marcamos nuestro final
                finish=(locs(c)+50);
            %Copiamos los valores para la ventana
                window=FHR(begin:finish);
            %Guardamos la ventana
                BPRSA_FHR(c,:)=window;
            %Hacemos lo mismo con la Actividad Uterina
                window=UA(begin:finish);
            %Lo guardamos
                BPRSA_UA(c,:)=window;
        end
    end
    window=0;
    aux=1;
end

postFHR=mean(BPRSA_FHR);
postUA=mean(BPRSA_UA);

figure(3), mscohere(postUA,postFHR,[],1,10,Fs)

% auxVect1=BPRSA_FHR(find(BPRSA_FHR));
% auxVect2=BPRSA_UA(find(BPRSA_UA));
% 
% minFHR=min(auxVect1);
% minUA=min(auxVect2);
% 
% for x=1:239
%     for y=1:101
%         if BPRSA_FHR(x,y)==0
%             BPRSA_FHR(x,y)=minFHR;
%         end
%         if BPRSA_UA(x,y)==0
%             BPRSA_UA(x,y)=minUA;
%         end
%     end
% end

%Se calcula la coherencia y se vuelve a graficar 
[Pxy,F]=mscohere(mean(BPRSA_FHR),mean(BPRSA_UA));

