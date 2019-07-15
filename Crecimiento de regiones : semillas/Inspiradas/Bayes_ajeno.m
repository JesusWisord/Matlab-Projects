close all
clear 
clc

Datos=importdata('raray.txt');
%% Clase 1

C1=Datos((Datos(:,3)==1),1:2);
mu1=mean(C1);
[r,~]=size(C1);
covar1=((C1-mu1)'*(C1-mu1))./r;
x1=linspace(-20,15,100);
x2=linspace(-20,15,100);
[X1,X2]=meshgrid(x1,x2);
Espacio=[reshape(X1,10000,1) ,reshape(X2,10000,1)];
condicional1=zeros(10000,1);
for i=1:size(Espacio)
    condicional1(i)=(1/(2*pi))*(1/sqrt(det(covar1)))*exp(-0.5*((Espacio(i,:)-mu1)*((covar1)^-1)*(Espacio(i,:)-mu1)'));
end
figure(1), mesh(X1,X2,reshape(condicional1,100,100))
hold on;
h=3;
for i=1:size(Espacio)
    K=0;
    for j=1:size(C1)
        if abs(C1(j,1)-Espacio(i,1))<h/2 && abs(C1(j,2)-Espacio(i,2))<h/2 
            K=K+1;
        end
    end  
    cond(i,1)=K/(r*h^2);
end
figure(2), mesh(X1,X2,reshape(cond,100,100))
    hold on
%% Clase 2
C2=Datos((Datos(:,3)==2),1:2);
mu2=mean(C2);
[r2,~]=size(C2);
covar2=((C2-mu2)'*(C2-mu2))./r2;
condicional2=zeros(10000,1);
for i=1:size(Espacio)
    condicional2(i)=(1/(2*pi))*(1/sqrt(det(covar2)))*exp(-0.5*((Espacio(i,:)-mu2)*((covar2)^-1)*(Espacio(i,:)-mu2)'));
end
figure(1),mesh(X1,X2,reshape(condicional2,100,100))
hold on
for i=1:size(Espacio)
    K=0;
    for j=1:size(C2)
        if abs(C2(j,1)-Espacio(i,1))<h/2 && abs(C2(j,2)-Espacio(i,2))<h/2 
            K=K+1;
        end
    end  
    cond2(i,1)=K/(r2*h^2);
end
figure(2), mesh(X1,X2,reshape(cond2,100,100))
hold on
%% Clase 3
C3=Datos((Datos(:,3)==3),1:2);
mu3=mean(C3);
[r,~]=size(C3);
covar3=((C3-mu3)'*(C3-mu3))./r;
condicional3=zeros(10000,1);
for i=1:size(Espacio)
    condicional3(i)=(1/(2*pi))*(1/sqrt(det(covar3)))*exp(-0.5*((Espacio(i,:)-mu3)*((covar3)^-1)*(Espacio(i,:)-mu3)'));
end
figure(1),mesh(X1,X2,reshape(condicional3,100,100))
hold on
for i=1:size(Espacio)
    K=0;
    for j=1:size(C3)
        if abs(C3(j,1)-Espacio(i,1))<h/2 && abs(C3(j,2)-Espacio(i,2))<h/2 
            K=K+1;
        end
    end  
    cond3(i,1)=K/(r*h^2);
end
figure(2), mesh(X1,X2,reshape(cond3,100,100))
hold on
%% Clase 4
C4=Datos((Datos(:,3)==4),1:2);
mu4=mean(C4);
[r,~]=size(C4);
covar4=((C4-mu4)'*(C4-mu4))./r;
condicional4=zeros(10000,1);
for i=1:size(Espacio)
    condicional4(i)=(1/(2*pi))*(1/sqrt(det(covar4)))*exp(-0.5*((Espacio(i,:)-mu4)*((covar4)^-1)*(Espacio(i,:)-mu4)'));
end
figure(1),mesh(X1,X2,reshape(condicional4,100,100))
hold on
for i=1:size(Espacio)
    K=0;
    for j=1:size(C4)
        if abs(C4(j,1)-Espacio(i,1))<h/2 && abs(C4(j,2)-Espacio(i,2))<h/2 
            K=K+1;
        end
    end  
    cond4(i,1)=K/(r*h^2);
end
figure(2), mesh(X1,X2,reshape(cond4,100,100))
hold on
plot(Datos(:,1),Datos(:,2),'*')
