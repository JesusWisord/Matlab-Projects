load ('Semana 13/ECG1.dat')
load ('Semana 13/ECG2.dat')

[B,A]=sos2tf(SOS,G)
Salida1=filtfilt(B,A,ECG1)

ECG_Filt1=filtfilt(B,A,ECG1);
ECG_Rect1=abs(ECG_Filt1_2);

[peaks1,locs]=findpeaks(ECG_Rect1,'MinPeakDistance', 6500, 'MinPeakHeight', 1);

AUC_EHG=trapz(peaks1);

Fs = 900;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = size(P,1)-1;             % Length of signal
if (mod(L,2))~=0
    L=L-1
end
t = (0:L-1)*T; 
Y = fft(P);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
figure(5)
plot(f,P1) 
title('Signal Spectrum')
xlabel('f (Hz)')
ylabel('|P1(f)|')