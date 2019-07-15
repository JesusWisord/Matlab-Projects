x=y(2400:5200);
t=0:1/Fs:total;
nfft=1024;
X=fft(x,nfft);
X=X(1:nfft/2);
mx=abs(X);
f=(0:nfft/2-1)*Fs/nfft;
figure(1);
plot(x)
title('Audio Wave Signal');
xlabel('Time (s)');
ylabel('Amplitude');
figure(2);
plot(f,mx);
title('Power Spectrum of Audio Wave');
xlabel('Frequency (Hz)');
ylabel('Power');