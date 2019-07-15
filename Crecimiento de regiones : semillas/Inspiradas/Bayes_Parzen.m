%clear
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

Sigma_1=zeros(2,2);
for i=1:size(Clase_1,1)
    Sigma_1=Sigma_1+((Clase_1(i,:)-Promedio_C1)'*(Clase_1(i,:)-Promedio_C1));
end
Sigma_1=Sigma_1*1/size(Clase_1,1);

Sigma_2=zeros(2,2);
for i=1:size(Clase_2,1)
    Sigma_2=Sigma_2+((Clase_2(i,:)-Promedio_C2)'*(Clase_2(i,:)-Promedio_C2));
end
Sigma_2=Sigma_2*1/size(Clase_2,1);

Sigma_3=zeros(2,2);
for i=1:size(Clase_3,1)
    Sigma_3=Sigma_3+((Clase_3(i,:)-Promedio_C3)'*(Clase_3(i,:)-Promedio_C3));
end
Sigma_3=Sigma_3*1/size(Clase_3,1);

Sigma_4=zeros(2,2);
for i=1:size(Clase_4,1)
    Sigma_4=Sigma_4+((Clase_4(i,:)-Promedio_C4)'*(Clase_4(i,:)-Promedio_C4));
end
Sigma_4=Sigma_4*1/size(Clase_4,1);

D=2


x1=linspace(-20,15,100);
x2=linspace(-20,15,100);

[esp1,esp2]=meshgrid(x1,x2);
espacio=[reshape(esp1,10000,1),reshape(esp2,10000,1)];
espacio=[ones(10000,1),espacio];

for i=1:100
    for j=1:100
        Gauss_C1(i,j)=(1/(2*pi)^D/2);
        Gauss_C1(i,j)=Gauss_C1(i,j)*1/abs(det(Sigma_1));
        Gauss_C1(i,j)=Gauss_C1(i,j)*exp( (-1/2)*( ([esp1(i,j),esp2(i,j)]-Promedio_C1)*( inv(Sigma_1) )* ([esp1(i,j),esp2(i,j)]-Promedio_C1)') );
        Gauss_C2(i,j)=(1/(2*pi)^D/2);
        Gauss_C2(i,j)=Gauss_C2(i,j)*1/abs(det(Sigma_2));
        Gauss_C2(i,j)=Gauss_C2(i,j)*exp( (-1/2)*( ([esp1(i,j),esp2(i,j)]-Promedio_C2)*( inv(Sigma_2) )* ([esp1(i,j),esp2(i,j)]-Promedio_C2)') );
        Gauss_C3(i,j)=(1/(2*pi)^D/2);
        Gauss_C3(i,j)=Gauss_C3(i,j)*1/abs(det(Sigma_3));
        Gauss_C3(i,j)=Gauss_C3(i,j)*exp( (-1/2)*( ([esp1(i,j),esp2(i,j)]-Promedio_C3)*( inv(Sigma_3) )* ([esp1(i,j),esp2(i,j)]-Promedio_C3)') );
        Gauss_C4(i,j)=(1/(2*pi)^D/2);
        Gauss_C4(i,j)=Gauss_C4(i,j)*1/abs(det(Sigma_4));
        Gauss_C4(i,j)=Gauss_C4(i,j)*exp( (-1/2)*( ([esp1(i,j),esp2(i,j)]-Promedio_C4)*( inv(Sigma_4) )* ([esp1(i,j),esp2(i,j)]-Promedio_C4)') );
    end
end

mesh(esp1,esp2,Gauss_C1)
hold on
mesh(esp1,esp2,Gauss_C2)
mesh(esp1,esp2,Gauss_C3)
mesh(esp1,esp2,Gauss_C4)
hold off

pause


h=1.5;

x1=linspace(-20,15,35/h);
x2=linspace(-20,15,35/h);

[esp1,esp2]=meshgrid(x1,x2);
tamano=size(x1,2);
Espacio=[reshape(esp1,tamano*tamano,1),reshape(esp2,tamano*tamano,1)];



[esp1,esp2]=meshgrid(x1,x2);

for i=1:tamano*tamano
    K=0;
    r=size(Clase_1,1);
    for j=1:size(Clase_1,1)
        if abs(Clase_1(j,1)-Espacio(i,1))<h/2 && abs(Clase_1(j,2)-Espacio(i,2))<h/2 
            K=K+1;
        end
    end
    condicional(i,1)=K/(r*h^2);
    
    K=0;
    r=size(Clase_2,1);
    for j=1:size(Clase_2,1)
        if abs(Clase_2(j,1)-Espacio(i,1))<h/2 && abs(Clase_2(j,2)-Espacio(i,2))<h/2 
            K=K+1;
        end
    end
    condicional(i,2)=K/(r*h^2);
    
    K=0;
    r=size(Clase_3,1);
    for j=1:size(Clase_3,1)
        if abs(Clase_3(j,1)-Espacio(i,1))<h/2 && abs(Clase_3(j,2)-Espacio(i,2))<h/2 
            K=K+1;
        end
    end
    condicional(i,3)=K/(r*h^2);
    
    K=0;
    r=size(Clase_4,1);
    for j=1:size(Clase_4,1)
        if abs(Clase_4(j,1)-Espacio(i,1))<h/2 && abs(Clase_4(j,2)-Espacio(i,2))<h/2 
            K=K+1;
        end
    end
    condicional(i,4)=K/(r*h^2);
end

Clase_1_Parzen=condicional(:,1);
Clase_2_Parzen=condicional(:,2);
Clase_3_Parzen=condicional(:,3);
Clase_4_Parzen=condicional(:,4);

% figure(2)
% mesh(x1,x2,reshape(Clase_1_Parzen,tamano,tamano))
% hold on
% mesh(x1,x2,reshape(Clase_2_Parzen,tamano,tamano))
% mesh(x1,x2,reshape(Clase_3_Parzen,tamano,tamano))
% mesh(x1,x2,reshape(Clase_4_Parzen,tamano,tamano))

figure (1)
subplot(2,2,1)
imagesc(x1,x2,reshape(Clase_1_Parzen,tamano,tamano))

subplot(2,2,2)
imagesc(x1,x2,reshape(Clase_2_Parzen,tamano,tamano))

subplot(2,2,3)
imagesc(x1,x2,reshape(Clase_3_Parzen,tamano,tamano))

subplot(2,2,4)
imagesc(x1,x2,reshape(Clase_4_Parzen,tamano,tamano))


% figure (2)
% imagesc(x1,x2,reshape(condicional,tamano,tamano,4))
% hold on
% imagesc(x1,x2,reshape(condicional(:,2),tamano,tamano))
% imagesc(x1,x2,reshape(condicional(:,3),tamano,tamano))
% imagesc(x1,x2,reshape(condicional(:,4),tamano,tamano))
% 
plot(raray(raray(:,3)==1,1),raray(raray(:,3)==1,2),'r*')
plot(raray(raray(:,3)==2,1),raray(raray(:,3)==2,2),'g*')
plot(raray(raray(:,3)==3,1),raray(raray(:,3)==3,2),'b*')
plot(raray(raray(:,3)==4,1),raray(raray(:,3)==4,2),'c*')





