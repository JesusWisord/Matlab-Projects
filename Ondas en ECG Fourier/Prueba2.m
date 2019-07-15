load Respiracion.txt
% load Mate.txt

V1=Respiracion(:,1);
V2=Respiracion(:,2);
V3=Respiracion(:,3);
V4=Respiracion(:,4);

tam=size(V1,1);
Seg=tam/200;
ventana=(tam/Seg)*4;

for n=1:tam/(ventana)-1
    aux=1;
    min=ventana*(n);
    %plot(1:ventana, V1(min:min+ventana-1))
    Signal=V4(min:min+ventana-1); 
    Fs = 200;            % Sampling frequency                    
    T = 1/Fs;             % Sampling period       
    L = size(Signal,1)-1;             % Length of signal
    if (mod(L,2))~=0
        L=L+1;
    end
    t = (0:L-1)*T; 
    Y = fft(Signal);
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    f = Fs*(0:(L/2))/L;
    figure(2)
    plot(f,P1) 
    title('V1 Spectrum')
    xlabel('f (Hz)')
    ylabel('|P1(f)|')
    
    figure(1), plot(1:size(Signal),Signal);
    for m=1:size(P1)
       Promedio(n,m)=P1(m); 
    end
end

Promedio=mean(Promedio)
h= figure(3), plot(f,Promedio);
saveas(h,'Fourier 4 Respiracion.png','png')



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

for n=1:size(Promedio,2)
   
    if(f(n)<3.5 && f(n)>2)
        delta=delta+Promedio(n);
    end
    
    if(f(n)>4 && f(n)<7.5)
        theta=theta+Promedio(n);
    end
    
    if(f(n)>8 && f(n)<13.5)
        alfa=alfa+Promedio(n);
    end
    
    if(f(n)>14 && f(n)<20)
        beta=beta+Promedio(n);
    end
    
end

bars(1)=delta;
bars(2)=theta;
bars(3)=alfa;
bars(4)=beta;

[pks,locs]=findpeaks(Promedio,'MinPeakHeight',0.05,'MinPeakDistance', .2);
findpeaks(Promedio,'MinPeakHeight',0.05,'MinPeakDistance', .2);
pks
(locs*.25)-.25
bars
