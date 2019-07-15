% Se calcula las áreas bajo la curva de nuestros cuatro pesos

load Peso1.txt
load Peso2.txt
load Peso3.txt
load Peso4.txt

Biceps=Peso1(:,1);
Biceps=abs(Biceps);
Triceps=Peso1(:,2);
Triceps=abs(Triceps);
Tiempo=0:size(Triceps,1)-1;


[peaksB,locs]=findpeaks(Biceps,'MinPeakDistance', 1000);
[peaksT,locs]=findpeaks(Triceps,'MinPeakDistance', 1000);

AUCBiceps(1)=trapz(peaksB);
AUCTriceps(1)=trapz(peaksT);

Biceps=Peso2(:,1);
Biceps=abs(Biceps);
Triceps=Peso2(:,2);
Triceps=abs(Triceps);

[peaksB,locs]=findpeaks(Biceps,'MinPeakDistance', 1000);
[peaksT,locs]=findpeaks(Triceps,'MinPeakDistance', 1000);

AUCBiceps(2)=trapz(peaksB);
AUCTriceps(2)=trapz(peaksT);

Biceps=Peso3(:,1);
Biceps=abs(Biceps);
Triceps=Peso3(:,2);
Triceps=abs(Triceps);

[peaksB,locs]=findpeaks(Biceps,'MinPeakDistance', 1000);
[peaksT,locs]=findpeaks(Triceps,'MinPeakDistance', 1000);

AUCBiceps(3)=trapz(peaksB);
AUCTriceps(3)=trapz(peaksT);

Biceps=Peso4(:,1);
Biceps=abs(Biceps);
Triceps=Peso4(:,2);
Triceps=abs(Triceps);

[peaksB,locs]=findpeaks(Biceps,'MinPeakDistance', 1000);
[peaksT,locs]=findpeaks(Triceps,'MinPeakDistance', 1000);

AUCBiceps(4)=trapz(peaksB);
AUCTriceps(4)=trapz(peaksT);

AUCBiceps
AUCTriceps