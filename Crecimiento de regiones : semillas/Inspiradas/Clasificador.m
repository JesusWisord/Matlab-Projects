close all
clear
clc

c1=importdata('c1_1.mat');
c2=importdata('c2_1.mat');
%% Entrenamiento
figure(1),plot(c1(:,1),c1(:,2),'*')
hold on
plot(c2(:,1),c2(:,2),'o')
X=[c1;c2];
X=[ones(200,1),X];
T=[ones(100,1);-1*ones(100,1)];
PseudoX=((X'*X)^-1)*X';
W=PseudoX*T;

%% Clasificacion de espacio
x1=linspace(-8,10,100);
x2=linspace(-8,10,100);
[X1,X2]=meshgrid(x1,x2);
Espacio=[reshape(X1,10000,1) ,reshape(X2,10000,1)];
Espacio=[ones(10000,1),Espacio];
Y=W'*Espacio';
clase=ones(10000,1);
clase(Y<0)=-1;
Clase=[reshape(clase,100,100)];

figure(2),imagesc(x1,x2,Clase)
hold on
plot(c1(:,1),c1(:,2),'*')
hold on
plot(c2(:,1),c2(:,2),'o')

%% Validacion cruzada de 4 vias
Esperado=[ones(25,1);-1*ones(25,1)];
Grupo=ones(50,3,4);
T1=[ones(25,1);-1*ones(25,1);ones(25,1);-1*ones(25,1);ones(25,1);-1*ones(25,1);];
ClaseG=ones(50,4);

for i=1:4
    Grupo(:,2:3,i)=[c1(1+((i-1)*25):i*25,:);c2(1+((i-1)*25):i*25,:)];
end

XG(:,:,1)=[Grupo(:,:,1);Grupo(:,:,2);Grupo(:,:,3)];
XG(:,:,2)=[Grupo(:,:,1);Grupo(:,:,2);Grupo(:,:,4)];
XG(:,:,3)=[Grupo(:,:,1);Grupo(:,:,3);Grupo(:,:,4)];
XG(:,:,4)=[Grupo(:,:,2);Grupo(:,:,3);Grupo(:,:,4)];

for i=1:4
    PseudoXG(:,:,i)=((XG(:,:,i)'*XG(:,:,i))^-1)*XG(:,:,i)';
    WG(:,:,i)=PseudoXG(:,:,i)*T1;
    YG(:,:,i)=WG(:,:,i)'*Grupo(:,:,4-i+1)';
    ClaseG(YG(:,:,i)<0,i)=-1;
    Error(:,i)=abs(ClaseG(:,i)-Esperado);
    Porcentaje(i)=((50-(sum(Error(:,i)~=0)))/50)*100;
end

Porcentaje=mean(Porcentaje);

%% 4 Clases
Datos=importdata('raray.txt');
figure(3),plot(Datos(:,1),Datos(:,2),'*')

%% Entrenamiento
X2=[Datos(:,1:2)];
X2=[ones(400,1),X2];
T2=zeros(400,4);
for i=1:4
    T2(Datos(:,3)==i,i)=1;
end
PseudoX2=((X2'*X2)^-1)*X2';
W2=PseudoX2*T2;

%% Espacio
x12=linspace(-20,10,100);
x22=linspace(-10,15,100);
[X12,X22]=meshgrid(x12,x22);
Espacio2=[reshape(X12,10000,1) ,reshape(X22,10000,1)];
Espacio2=[ones(10000,1),Espacio2];
Y2=W2'*Espacio2';
[~,clase2]=max(Y2);
Clase2=reshape(clase2,100,100);
figure(4),imagesc(x12,x22,Clase2)
hold on
posclas=find(Datos(:,3)==1);
clas1=Datos(posclas,1:2);
posclas=find(Datos(:,3)==2);
clas2=Datos(posclas,1:2);
posclas=find(Datos(:,3)==3);
clas3=Datos(posclas,1:2);
posclas=find(Datos(:,3)==4);
clas4=Datos(posclas,1:2);

plot(clas1(:,1),clas1(:,2),'*')
hold on
plot(clas2(:,1),clas2(:,2),'*')
hold on
plot(clas3(:,1),clas3(:,2),'*')
hold on
plot(clas4(:,1),clas4(:,2),'*')
hold on

%% Validacion cruzada 3 vias
Grupo=ones(133,3,3);
for i=1:3
    Grupo(1:133,2:3,i)=[Datos(1+((i-1)*133):i*133,1:2)];
end
%Grupo(134,2:3,3)=[Datos(400,1:2)];
Tn=zeros(133,4,3);
for i=1:3
    Tn(1:133,:,i)=T2(1+((i-1)*133):i*133,:);
end
%Tn(134,:,3)=[T2(400,:)];

XG2(:,:,1)=[Grupo(:,:,1);Grupo(:,:,2)];
XG2(:,:,2)=[Grupo(:,:,1);Grupo(:,:,3)];
XG2(:,:,3)=[Grupo(:,:,2);Grupo(:,:,3)];

TG2(:,:,1)=[Tn(:,:,1);Tn(:,:,2)];
TG2(:,:,2)=[Tn(:,:,1);Tn(:,:,3)];
TG2(:,:,3)=[Tn(:,:,2);Tn(:,:,3)];

Esperado2(:,1)=Datos(267:399,3);
Esperado2(:,2)=Datos(134:266,3);
Esperado2(:,3)=Datos(1:133,3);
for i=1:3
    PseudoXG2(:,:,i)=((XG2(:,:,i)'*XG2(:,:,i))^-1)*XG2(:,:,i)';
    WG2(:,:,i)=PseudoXG2(:,:,i)*TG2(:,:,i);
    YG2(:,:,i)=WG2(:,:,i)'*Grupo(:,:,3-i+1)';
    [~,ClaseG2]=max(YG2(:,:,i));
    Error2(:,i)=abs(ClaseG2'-Esperado2(:,i));
    ans=find(Error2(:,i)~=0);
    Error2(ans,i)=1;
    Porcentaje2(i)=((133-(sum(Error2(:,i)~=0)))/133)*100;
    
    
    YGE(:,:,i)=WG2(:,:,i)'*Espacio2';
    [~,clase2]=max(YGE(:,:,i));
    Clase2=reshape(clase2,100,100);
    figure,imagesc(x12,x22,Clase2)
    hold on
    plot(Grupo(Error2(:,i)==0,2,3-i+1),Grupo(Error2(:,i)==0,3,3-i+1),'o')
    hold on
    plot(Grupo(Error2(:,i)==1,2,3-i+1),Grupo(Error2(:,i)==1,3,3-i+1),'*')
    title(['Porcentaje de certeza: ', num2str(Porcentaje2(i))])
    
end
Porcentajet=mean(Porcentaje2)