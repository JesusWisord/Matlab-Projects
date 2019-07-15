clearvars
close all

raray = load('raray.txt');

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

TAMANO(1)=size(Clase_1,1);
TAMANO(2)=size(Clase_2,1);
TAMANO(3)=size(Clase_3,1);
TAMANO(4)=size(Clase_4,1);

DIMENSIONES=2;
K_VAR=2;

x1=linspace(-20,15,100);
x2=linspace(-20,15,100);

[esp1,esp2]=meshgrid(x1,x2);
espacio=[reshape(esp1,10000,1),reshape(esp2,10000,1)];
D=DIMENSIONES;

C_1=clasificador(Clase_1, DIMENSIONES, K_VAR, espacio);
C_2=clasificador(Clase_2,DIMENSIONES,K_VAR,espacio);
C_3=clasificador(Clase_3,DIMENSIONES,K_VAR,espacio);
C_4=clasificador(Clase_4,DIMENSIONES,K_VAR,espacio);

% for k=1:2
%     for i=1:100
%         for j=1:100
%             Gauss_C1(i,j)=(1/(2*pi)^D/2);
%             Gauss_C1(i,j)=Gauss_C1(i,j)*1/abs(det(SigmaClase_1(:,:,k)));
%             Gauss_C1(i,j)=Gauss_C1(i,j)*exp( (-1/2)*( ([esp1(i,j),esp2(i,j)]-Promedio_C1)*( inv(SigmaClase_1(:,:,k)) )* ([esp1(i,j),esp2(i,j)]-Promedio_C1)') );
%         end
%     end
% end

figure
imagesc(x1,x2,reshape(C_1,100,100))
hold on
plot(Clase_1(:,1),Clase_1(:,2),'r*')
plot(Clase_2(:,1),Clase_2(:,2),'g*')
plot(Clase_3(:,1),Clase_3(:,2),'b*')
plot(Clase_4(:,1),Clase_4(:,2),'c*')
hold off

figure
imagesc(x1,x2,reshape(C_2,100,100))
hold on
plot(Clase_1(:,1),Clase_1(:,2),'r*')
plot(Clase_2(:,1),Clase_2(:,2),'g*')
plot(Clase_3(:,1),Clase_3(:,2),'b*')
plot(Clase_4(:,1),Clase_4(:,2),'c*')
hold off

figure
imagesc(x1,x2,reshape(C_3,100,100))
hold on
plot(Clase_1(:,1),Clase_1(:,2),'r*')
plot(Clase_2(:,1),Clase_2(:,2),'g*')
plot(Clase_3(:,1),Clase_3(:,2),'b*')
plot(Clase_4(:,1),Clase_4(:,2),'c*')
hold off

figure
imagesc(x1,x2,reshape(C_4,100,100))
hold on
plot(Clase_1(:,1),Clase_1(:,2),'r*')
plot(Clase_2(:,1),Clase_2(:,2),'g*')
plot(Clase_3(:,1),Clase_3(:,2),'b*')
plot(Clase_4(:,1),Clase_4(:,2),'c*')
hold off

% nvias=3;
% particiones=floor(size(raray,1)/nvias);
% 
% via(:,:,1)=raray(1:particiones,:);
% via(:,:,2)=raray(particiones+1:particiones*2,:);
% via(:,:,3)=raray((particiones*2)+1:particiones*3,:);
% 
% for i=1:nvias
%     Clase_1=via(via(:,3,i)==1,1:2,i);
%     Clase_2=via(via(:,3,i)==2,1:2,i);
%     Clase_3=via(via(:,3,i)==3,1:2,i);
%     Clase_4=via(via(:,3,i)==4,1:2,i);
%     
%     C_1=clasificador(Clase_1,DIMENSIONES,K_VAR,espacio);
%     C_2=clasificador(Clase_2,DIMENSIONES,K_VAR,espacio);
%     C_3=clasificador(Clase_3,DIMENSIONES,K_VAR,espacio);
%     C_4=clasificador(Clase_4,DIMENSIONES,K_VAR,espacio);
%     
%     close all
%     
%     switch i
%         case 1
%             figure
%             imagesc(x1,x2,reshape(C_1,100,100))
%             hold on
%             plot(via(:,1,2),via(:,2,2),'*')
%             plot(via(:,1,3),via(:,2,3),'*')
%             figure
%             imagesc(x1,x2,reshape(C_2,100,100))
%             hold on
%             plot(via(:,1,2),via(:,2,2),'*')
%             plot(via(:,1,3),via(:,2,3),'*')
%             figure
%             imagesc(x1,x2,reshape(C_3,100,100))
%             hold on
%             plot(via(:,1,2),via(:,2,2),'*')
%             plot(via(:,1,3),via(:,2,3),'*')
%             figure
%             imagesc(x1,x2,reshape(C_4,100,100))
%             hold on
%             plot(via(:,1,2),via(:,2,2),'*')
%             plot(via(:,1,3),via(:,2,3),'*')
%         case 2
%             figure
%             imagesc(x1,x2,reshape(C_1,100,100))
%             hold on
%             plot(via(:,1,3),via(:,2,3),'*')
%             plot(via(:,1,1),via(:,2,1),'*')
%             figure
%             imagesc(x1,x2,reshape(C_2,100,100))
%             hold on
%             plot(via(:,1,3),via(:,2,3),'*')
%             plot(via(:,1,1),via(:,2,1),'*')
%             figure
%             imagesc(x1,x2,reshape(C_3,100,100))
%             hold on
%             plot(via(:,1,3),via(:,2,3),'*')
%             plot(via(:,1,1),via(:,2,1),'*')
%             figure
%             imagesc(x1,x2,reshape(C_4,100,100))
%             hold on
%             plot(via(:,1,3),via(:,2,3),'*')
%             plot(via(:,1,1),via(:,2,1),'*')
%         case 3
%             figure
%             imagesc(x1,x2,reshape(C_1,100,100))
%             hold on
%             plot(via(:,1,2),via(:,2,2),'*')
%             plot(via(:,1,1),via(:,2,1),'*')
%             figure
%             imagesc(x1,x2,reshape(C_2,100,100))
%             hold on
%             plot(via(:,1,2),via(:,2,2),'*')
%             plot(via(:,1,1),via(:,2,1),'*')
%             figure
%             imagesc(x1,x2,reshape(C_3,100,100))
%             hold on
%             plot(via(:,1,2),via(:,2,2),'*')
%             plot(via(:,1,1),via(:,2,1),'*')
%             figure
%             imagesc(x1,x2,reshape(C_4,100,100))
%             hold on
%             plot(via(:,1,2),via(:,2,2),'*')
%             plot(via(:,1,1),via(:,2,1),'*')
%     end
%     pause
% end


function [Clasificador, M, Sigma, Pi_var] = clasificador(Clase, DIMENSIONES, K_VAR, espacio, opc)

    Tamano=size(Clase,1);
    for i=1:K_VAR
        M(i,:)=Clase(randi(Tamano),1:2);
        Sigma(:,:,i)=eye(DIMENSIONES);
        Pi_var(i)=1/K_VAR;
    end
    
    for z=1:2
       
        for i=1:Tamano
            for j=1:K_VAR
                PS(i,j)=Pi_var(j)*(((1/(2*pi)))*(1/sqrt(det(Sigma(:,:,j))))*exp(-0.5*((Clase(i,:)-M(j,:))*((Sigma(:,:,j))^-1)*(Clase(i,:)-M(j,:))')));
            end
        end
        
        PS=PS./sum(PS,2);

        for i=1:K_VAR
            M(i,:)=sum(PS(:,i).*Clase)/sum(PS(:,i));
%             aux=zeros(2);
%             for j=1:Tamano
%                 aux=aux+((PS(j,i).*(Clase(j,:)-M(i,:)))'*(PS(j,i).*(Clase(j,:)-M(i,:))))./sum(PS);
%             end
%             Sigma(:,:,i)=aux;
            Sigma(:,:,i)=( (PS.*(Clase-M(i,:)))' * (PS.*(Clase-M(i,:))) )./sum(PS);
            Pi_var(:)=mean(PS)';
        end 
    end
    
    condicional=zeros(size(espacio,1),1);
    
    for i=1:size(espacio)
        for j=1:K_VAR
        condicional(i)=condicional(i)+(Pi_var(j)*((1/(2*pi))*(1/sqrt(det(Sigma(:,:,j))))*exp(-0.5*((espacio(i,:)-M(j,:))*((Sigma(:,:,j))^-1)*(espacio(i,:)-M(j,:))'))));
        end
    end
    
    Clasificador=condicional;
    %Clasificador_alfa=Clasificador_alfa./sum(Clasificador_alfa)
    
end

