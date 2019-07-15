% load Mate.txt
load Ojos.txt
% load Respiracion.txt

V1=Ojos(:,1);
V2=Ojos(:,2);
V3=Ojos(:,3);
V4=Ojos(:,4);

t=1:size(V1,1);

figure(1)
h=plot(t,V1)
% saveas(h,'Grafica1 Respiracion.png','png')

figure(2)
h=plot(t,V2)
% saveas(h,'Grafica2 Respiracion.png','png')

figure(3)
h=plot(t,V3)
% saveas(h,'Grafica3 Respiracion.png','png')

figure(4)
h=plot(t,V4)
% saveas(h,'Grafica4 Respiracion.png','png')

Fs = 200;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = size(V1,1)-1;             % Length of signal
if (mod(L,2))~=0
    L=L+1
end
t = (0:L-1)*T; 
Y = fft(V1);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
figure(1)
h=plot(f,P1) 
title('V1 Spectrum')
xlabel('f (Hz)')
ylabel('|P1(f)|')

% Fs = 12000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = size(V2,1)-1;             % Length of signal
if (mod(L,2))~=0
    L=L+1
end
t = (0:L-1)*T; 
Y = fft(V2);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
figure(2)
h=plot(f,P1) 
title('V2 Spectrum')
xlabel('f (Hz)')
ylabel('|P1(f)|')

% Fs = 200;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = size(V3,1)-1;             % Length of signal
if (mod(L,2))~=0
    L=L+1
end
t = (0:L-1)*T; 
Y = fft(V3);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
figure(3)
h=plot(f,P1) 
title('V3 Spectrum')
xlabel('f (Hz)')
ylabel('|P1(f)|')

% Fs = 12000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = size(V4,1)-1;             % Length of signal
if (mod(L,2))~=0
    L=L+1
end
t = (0:L-1)*T; 
Y = fft(V4);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
figure(4)
h=plot(f,P1) 
title('V4 Spectrum')
xlabel('f (Hz)')
ylabel('|P1(f)|')