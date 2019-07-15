close all
clear all

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

%Se calcula el BPRSA con el vector de localizaciones, por eso utilizamos el
%tamaño de ese vector. 
for c=1:size(locs,2)
   
    %Desechamos todas las ventanas que no esten completas. Siendo ventanas
    %de 101 muestras con 50 muestras anteriores y 50 posteriores debemos
    %empezar desde la muestra 51 y detenernos en la 399.
    if (locs(c)>50 && locs(c)<400)
        %Comenzamos por obtener la muestra que inicia la ventana
        begin=(locs(c)-50);
        %Luego la muestra que termina la ventana
        finish=(locs(c)+50);
        %Se define la ventana con las 101 muestras, con la muestra marcada
        %en medio.
        window=FHR(begin:finish);
        %Se guarda esta ventana en una matriz
        BPRSA_FHR(aux,:)=window;
        %Esa misma ventana se toma de la señal Uterina
        window=UA(begin:finish);
        %Y se guarda en una matriz.
        BPRSA_UA(aux,:)=window;
        aux=aux+1;
    end
    
end

%Ya obtenidas las matrices se calcula un promedio de ambas matrices para
%obtener un unico vector de cada señal que representará nuestra señal
%procesada por el algoritmo BPRSA

postFHR=mean(BPRSA_FHR);
postUA=mean(BPRSA_UA);

figure(2), plot(postFHR,'b'), title('Post processing signals')
hold on
plot(postUA,'r')
legend('Señal FHR', 'Señal AU');
hold off


%Se calcula la coherencia y se vuelve a graficar 

figure(3), mscohere(postUA,postFHR,[],[],[],Fs), title('Coherence Estimate Via Welch Post-Processing')
[Pxy,F]=mscohere(mean(BPRSA_FHR),mean(BPRSA_UA));

%Como dato extra graficaremos los espectros en frecuencia de nuestras
%señales antes y después del procesamiento

Fs = 0.5;
figure(4)
[P1,f1] = periodogram(FHR,[],[],Fs,'power');
[P2,f2] = periodogram(UA,[],[],Fs,'power');
subplot(2,1,1)
plot(f1,P1,'k')
grid
ylabel('P_1')
title('Power Spectrum Pre-Processing')
subplot(2,1,2)
plot(f2,P2,'r')
grid
ylabel('P_2')
xlabel('Frequency (Hz)')

figure(5)
[P1,f1] = periodogram(postFHR,[],[],Fs,'power');
[P2,f2] = periodogram(postUA,[],[],Fs,'power');
subplot(2,1,1)
plot(f1,P1,'k')
grid
ylabel('P_1')
title('Power Spectrum Post-Processing')
subplot(2,1,2)
plot(f2,P2,'r')
grid
ylabel('P_2')
xlabel('Frequency (Hz)')