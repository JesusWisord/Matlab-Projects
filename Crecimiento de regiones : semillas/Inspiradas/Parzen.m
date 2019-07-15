clearvars

raray = load('raray.txt');

X=raray;

datos_x=raray(:,1:2);
datos_y=raray(:,3);

Clase_1=datos_x(datos_y==1,:);
Clase_2=datos_x(datos_y==2,:);
Clase_3=datos_x(datos_y==3,:);
Clase_4=datos_x(datos_y==4,:);

Promedio_C1=mean(Clase_1);
Promedio_C2=mean(Clase_2);
Promedio_C3=mean(Clase_3);
Promedio_C4=mean(Clase_4);

