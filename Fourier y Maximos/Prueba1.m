% Muestra las gráficas de los distintos pesos utilizados. Es necesario
% cambiar las primeras líneas de código para elegir la tabla de datos a
% graficar

load Peso1.txt
load Peso2.txt
load Peso3.txt
load Peso4.txt
Fs=20000;

Biceps=Peso1(:,1); %Se modifica "Peso1" por cualquier .txt
Triceps=Peso1(:,2); %Se modifica "Peso1" por cualquier .txt
Tiempo=0:size(Biceps,1)-1;
Biceps=Biceps';
h=figure (1), title('Biceps raw'), plot(Tiempo, Biceps);
% saveas(h,'Biceps raw 4.png','png')
Triceps=Triceps';
h=figure(2), title('Triceps raw'), plot(Tiempo, Triceps, 'red');
% saveas(h,'Triceps raw 4.png','png')


BicepsRect=abs(Biceps);
h=figure(3), title('Biceps Rect'), plot(Tiempo, BicepsRect, 'blue');
% saveas(h,'Biceps Rect 4.png','png')
TricepsRect=abs(Triceps);
h=figure(4), title('Triceps Rect'), plot(Tiempo, TricepsRect, 'red');
% saveas(h,'Triceps Rect 4.png','png')


% nfft=1024;
% frec=fft(BicepsRect,nfft);
% frec = frec(1:nfft/2); 
% my = abs(frec).^2;
% f = (0:nfft/2-1)*Fs/nfft;

Fs = 20000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = size(Biceps,2)-1;             % Length of signal
if (mod(L,2))~=0
    L=L+1
end
t = (0:L-1)*T; 
Y = fft(Biceps);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
figure(5)
h=plot(f,P1) 
title('Biceps Spectrum')
xlabel('f (Hz)')
ylabel('|P1(f)|')
% saveas(h,'Biceps Spectrum 4.png','png');

t = (0:L-1)*T; 
Y = fft(Triceps);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
figure(6)
h=plot(f,P1) 
title('Triceps Spectrum')
xlabel('f (Hz)')
ylabel('|P1(f)|')
% saveas(h,'Triceps Spectrum 4.png','png');

% pause;
% 
% nfft2=1024;
% frec2=fft(TricepsRect,nfft2);
% frec2 = frec2(1:nfft2/2); 
% my2 = abs(frec2).^2;
% f2 = (0:nfft2/2-1)*Fs/nfft2;
% figure(6), title('Espectro en Frec TricepsRect'), plot(f2,my2,'red');