clearvars

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
espacio=[ones(10000,1),espacio];
D=DIMENSIONES;

Gauss=zeros(100,100,4);

    Tamano=size(Clase_1,1);
    
    for i=1:K_VAR
        M(i,:)=Clase_1(randi(Tamano),1:2);
        Sigma(:,:,i)=eye(DIMENSIONES);
        Pi_var(i)=1/K_VAR;
    end
    
    for n=1:2

        for i=1:(Tamano)
           PS(i,1)=Pi_var(1)*Tamano*Clase_1(i,1)*M(1,1)*Sigma(1,1);
           PS(i,2)=Pi_var(2)*Tamano*Clase_1(i,2)*M(1,2)*Sigma(1,2);
           PS(i,3)=Pi_var(1)*Tamano*Clase_1(i,1)*M(2,1)*Sigma(2,1);
           PS(i,4)=Pi_var(2)*Tamano*Clase_1(i,2)*M(2,2)*Sigma(2,2);
        end
        PSln=[PS(:,1),PS(:,4)];
%         likelihood=ln(PSln);
        PS=PS./sum(PS,2);


        PS=[PS(:,1),PS(:,4)];

        for i=1:K_VAR;
           M_2(i,:)=sum([PS(:,i).*Clase_1(:,1),PS(:,2).*Clase_1(:,i)])./sum(PS(:,i));
           Sigma_2(:,:,i)=(([PS.*(Clase_1-M(i,:))])'*([PS.*(Clase_1-M(i,:))]))./sum(PS);
           Pi_var_2(i)=sum(PS(:,i))/Tamano;
        end
        
%         likelihood_2=ln(PSln);
        
        M=M_2;
        Sigma=Sigma_2;
        Pi_var=Pi_var_2;
        
        
    end
    
    
    if j==1
        MClase_1_1=M;
        SigmaClase_1_1=Sigma;
        PiClase_1_1=Pi_var;
        PSClase_1_1=PS;
    elseif j==2
        MClase_1_2=M;
        SigmaClase_1_2=Sigma;
        PiClase_1_2=Pi_var;
        PSClase_1_2=PS;
    elseif j==3
        MClase_1_3=M;
        SigmaClase_1_3=Sigma;
        PiClase_1_3=Pi_var;
        PSClase_1_3=PS;
    else
        MClase_1_4=M;
        SigmaClase_1_4=Sigma;
        PiClase_1_4=Pi_var;
        PSClase_1_4=PS;
    end
