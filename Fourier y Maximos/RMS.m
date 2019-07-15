%Calcula los valores RMS de nuestros cuatro pesos

load Peso1.txt
load Peso2.txt
load Peso3.txt
load Peso4.txt

Biceps=abs(Peso1(:,1));
Triceps=(Peso1(:,2));

RMSBiceps(1)=rms(Biceps);
RMSTriceps(1)=rms(Triceps);

Biceps=abs(Peso2(:,1));
Triceps=(Peso2(:,2));

RMSBiceps(2)=rms(Biceps);
RMSTriceps(2)=rms(Triceps);

Biceps=abs(Peso3(:,1));
Triceps=(Peso3(:,2));

RMSBiceps(3)=rms(Biceps);
RMSTriceps(3)=rms(Triceps);

Biceps=abs(Peso4(:,1));
Triceps=(Peso4(:,2));

RMSBiceps(4)=rms(Biceps);
RMSTriceps(4)=rms(Triceps);

RMSBiceps
RMSTriceps
