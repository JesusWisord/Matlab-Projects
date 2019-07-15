% load Ojos.txt
load Mate.txt

V1=Mate(:,1);
V2=Mate(:,2);
V3=Mate(:,3);
V4=Mate(:,4);

tam=size(V1,1);
ventana=(tam/300)*4;

for n=1:tam/(ventana)-1
    aux=1;
    min=ventana*(n);
    %plot(1:ventana, V1(min:min+ventana-1))
    Signal=V1(min:min+ventana-1);
    
%     figure(1), plot(1:size(Signal),Signal);
    Promedio(n)=mean(Signal);
end


Fs = 200;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = size(Promedio,2)-1;             % Length of signal
if (mod(L,2))~=0
    L=L+1;
end
t = (0:L-1)*T; 
Y = fft(Promedio);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
figure(2)
plot(f,P1) 
title('V1 Spectrum')
xlabel('f (Hz)')
ylabel('|P1(f)|')

% figure(1), plot(1:size(P1,2),P1)
% Signal=P1
% P1=0;


% Fs = 200;            % Sampling frequency                    
% T = 1/Fs;             % Sampling period       
% L = size(Signal,2)-1;             % Length of signal
% if (mod(L,2))~=0
%     L=L+1;
% end
% t = (0:L-1)*T; 
% Y = fft(Signal);
% P2 = abs(Y/L);
% P1 = P2(1:L/2+1);
% P1(2:end-1) = 2*P1(2:end-1);
% f = Fs*(0:(L/2))/L;
% figure(2)
% plot(f,P1) 
% title('V1 Spectrum')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')
% 
% 

delta=0;
theta=0;
alfa=0;
beta=0;

for n=1:size(f,2)
   
    if(f(n)<3.5 && f(n)>0.1)
        delta=delta+P1(n);
    end
    
    if(f(n)>4 && f(n)<7.5)
        theta=theta+P1(n);
    end
    
    if(f(n)>8 && f(n)<13.5)
        alfa=alfa+P1(n);
    end
    
    if(f(n)>14 && f(n)<20)
        beta=beta+P1(n);
    end
    
end

bars(1)=delta;
bars(2)=theta;
bars(3)=alfa;
bars(4)=beta;
