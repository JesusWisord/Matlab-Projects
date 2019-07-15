x=fopen('despues_terapia.DAT','r'); %abre el archivo ALLDAT que contiene todos los registros
y=fread(x,'ubit8'); %asigna 8 bits, transforma a -ASCIII
xr=y(105:740); %recorta la se�al PARA CASOS 1
%xr=y(10999:11634); %CASO 2
xr=xr-mean(xr); %centrar a cero
samples=(0:1:635);%numero de muestras del segmento de sacadas 10�
Fs=63.5; %frecuencia de muestreo
t=samples/Fs;
target=-10*square(1/Fs*pi*samples,50)'; %genera se�al cuadrada (se�al blanco)
velocity=abs(diff(xr));
t_2=t(1:635);

f_cutoff = 15; % cutoff frequency
fn=f_cutoff/(Fs);
[B,A] = butter(5,fn,'low');
sal=filter(B,A,xr);
velocityfil=abs(diff(sal));

umbral=0.60*max(velocityfil); % Definicion del umbral de disparo
M=find(velocityfil>umbral); % Enconrtrar los valores de la se�al que superan el umbral y se asignan a la variable M
[pks,locs] = findpeaks(velocityfil,'minpeakheight',umbral);

figure
subplot(2,1,1)
plot(t,xr)
title('Sacada fija 10�')
axis([0 10 -50 50])
xlabel ('s');
grid on;
set(gca,'ytick',0)

subplot(2,1,2)
plot (t,target);
title('Target')
xlabel ('s');
axis([0 10 -50 50])
grid on;
set(gca,'ytick',0)

figure
plot(t_2,velocityfil)

figure
plot(sal)


%latencias

t1=target(64:128);
%t1=t1-mean(t1);
s1=xr(64:128);%eliminar tendencia
%s1=s1-mean(s1);
l1=abs(finddelay(t1,s1)/Fs)

t2=target(128:192);
%t2=t2-mean(t2);
s2=xr(128:192);
%s2=s2-mean(s2);
l2=abs(finddelay(t2,s2)/Fs)

t3=target(192:256);
%t3=t3-mean(t3);
s3=xr(192:256);
%s3=s3-mean(s3);
l3=abs(finddelay(t3,s3)/Fs)

t4=target(256:320);
%t4=t4-mean(t4);
s4=xr(256:320);
%s4=s4-mean(s4);
l4=abs(finddelay(t4,s4)/Fs)

t5=target(320:384);
%t5=t5-mean(t5);
s5=xr(320:384);
%s5=s5-mean(s5);
l5=abs(finddelay(t5,s5)/Fs)

t6=target(384:448);
%t6=t6-mean(t6);
s6=xr(384:448);
%s6=s6-mean(s6);
l6=abs(finddelay(t6,s6)/Fs)

t7=target(448:512);
%t7=t7-mean(t7);
s7=xr(448:512);
%s7=s7-mean(s7);
l7=abs(finddelay(t7,s7)/Fs)

t8=target(512:576);
%t8=t8-mean(t8);
s8=xr(512:576);
%s8=s8-mean(s8);
l8=abs(finddelay(t8,s8)/Fs)

t9=target(576:635);
%t9=t9-mean(t9);
s9=xr(576:635);
%s9=s9-mean(s9);
l9=abs(finddelay(t9,s9)/Fs)

l=[l1;l2;l3;l4;l5;l6;l7;l8;l9];
l = l(l~=0)
latenciaprom=mean(l)*1000

correlacion_cruzada=(max(abs(xcorr(xr,target)))/(norm(xr,2)*norm(target,2))) %calculo de la m�xima correlaci�n cruzada normalizada
[c,lag]=xcorr(xr,target,'coeff');
%Mutual_info=information(xr',target')% base e
hist(l)

velocidad=mean(pks)

xr3=xr/std(xr);
targetn=target/std(target);
%samplecross=cross_sampen(xr3,targetn,2,0.2,0)