Fs=1000;
t=0:1/Fs:1-1/Fs;
x=cos(2*pi*100*t)+sin(2*pi*200*t)+0.5*randn(size(t));
y=0.5*cos(2*pi*100*t-pi/4)+0.35*sin(2*pi*200*t-pi/2)+0.5*randn(size(t));

[Pxy,F]=mscohere(x,y,hamming(100),80,100,Fs);
figure
plot(F,Pxy)
title('Magnitude Squared Coherence 2')
xlabel('Frequecy (Hz)');
grid