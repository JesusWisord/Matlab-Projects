clearvars

VIAS=3;
porcentajeAceptacion=.5;

load('dos_Espirales.mat');

Clase_1=x(:,y==1)';
Clase_2=x(:,y==0)';

Promedio_C1=mean(Clase_1);
Promedio_C2=mean(Clase_2);

TAMANO(1)=size(Clase_1,1);
TAMANO(2)=size(Clase_2,1);

DIMENSIONES=2;
K_VAR=2;

x1=linspace(-1,1,100);
x2=linspace(-1,1,100);

[esp1,esp2]=meshgrid(x1,x2);
espacio=[reshape(esp1,10000,1),reshape(esp2,10000,1)];
espacio=[espacio];
D=DIMENSIONES;

Gauss=zeros(100,100,2);
C_1=clasificador(Clase_1,DIMENSIONES,K_VAR, espacio);
C_2=clasificador(Clase_2,DIMENSIONES,K_VAR, espacio);

figure (1)
imagesc(x1,x2,reshape(C_1,100,100))
hold on
plot(Clase_1(:,1),Clase_1(:,2),'r*')
plot(Clase_2(:,1),Clase_2(:,2),'g*')

figure (2)
imagesc(x1,x2,reshape(C_2,100,100))
hold on
plot(Clase_1(:,1),Clase_1(:,2),'r*')
plot(Clase_2(:,1),Clase_2(:,2),'g*')

%% Validacion por vias

intervalos=0:round(2000/VIAS):2000;
intervalos(end+1)=2000;

datos_x=x';
datos_y=y';

for i=1:VIAS
   
    test_x=datos_x(intervalos(i)+1:intervalos(i+1),:);
    test_y=datos_y(intervalos(i)+1:intervalos(i+1),:);
    entrenamiento_x=datos_x;
    entrenamiento_y=datos_y;
    entrenamiento_x(intervalos(i)+1:intervalos(i+1),:)=[];
    entrenamiento_y(intervalos(i)+1:intervalos(i+1),:)=[];
    
    Clase_1=entrenamiento_x(entrenamiento_y==1,:);
    Clase_2=entrenamiento_x(entrenamiento_y==0,:);

    Promedio_C1=mean(Clase_1);
    Promedio_C2=mean(Clase_2);

    TAMANO(1)=size(Clase_1,1);
    TAMANO(2)=size(Clase_2,1);
    
    C_1=clasificador(Clase_1,DIMENSIONES,K_VAR, espacio);
    C_2=clasificador(Clase_2,DIMENSIONES,K_VAR,espacio);
    Cp_1=clasificador(Clase_1,DIMENSIONES,K_VAR, test_x);
    Cp_2=clasificador(Clase_2,DIMENSIONES,K_VAR, test_x);
    
    test_clase1=Cp_1>porcentajeAceptacion;
    test_clase2=Cp_2<porcentajeAceptacion;
    
    f2 = figure (3)
    imagesc(x1,x2,reshape(C_1,100,100))
    hold on
    plot(Clase_1(:,1),Clase_1(:,2),'r*')
    plot(Clase_2(:,1),Clase_2(:,2),'g*')
    msg=strcat('Clase 1 via ',num2str(i),'.png')
    saveas(f2,msg)
    
    f3 = figure (4)
    imagesc(x1,x2,reshape(C_2,100,100))
    hold on
    plot(Clase_1(:,1),Clase_1(:,2),'r*')
    plot(Clase_2(:,1),Clase_2(:,2),'g*')
    msg=strcat('Clase 2 via ',num2str(i),'.png')
    saveas(f2,msg)
    
    f2 = figure (5)
    mesh(esp1,esp2,reshape(C_1,100,100))
    hold on
    plot(Clase_1(:,1),Clase_1(:,2),'r*')
    plot(Clase_2(:,1),Clase_2(:,2),'g*')
    msg=strcat('Clase 1 3D via ',num2str(i),'.png')
    saveas(f2,msg)
    
    f2 = figure (6)
    mesh(esp1,esp2,reshape(C_2,100,100))
    hold on
    plot(Clase_1(:,1),Clase_1(:,2),'r*')
    plot(Clase_2(:,1),Clase_2(:,2),'g*')
    msg=strcat('Clase 2 3D via ',num2str(i),'.png')
    saveas(f2,msg)
    
    auxiliar_1=test_y==1;
    auxiliar_2=test_clase1==1;
    
    verd=auxiliar_1+auxiliar_2;
    c1_vp=size(find(verd==2),1);
    c1_vn=size(find(verd==0),1);
    
    neg=auxiliar_1-auxiliar_2;
    c1_fp=size(find(neg==-1),1);
    c1_fn=size(find(neg==1),1);
    
    fprintf('Matriz de confusion Clase 1\n')
    fprintf('Verdaderos positivos: %d - Verdaderos negativos: %d\n', c1_vp, c1_vn)
    fprintf('Falsos positivos: %d - Falsos negativos: %d\n', c1_fp, c1_fn)
    
    auxiliar_1=test_y==0;
    auxiliar_2=test_clase2==0;
    
    verd=auxiliar_1+auxiliar_2;
    c2_vp=size(find(verd==2),1);
    c2_vn=size(find(verd==0),1);
    
    neg=auxiliar_1-auxiliar_2;
    c2_fp=size(find(neg==-1),1);
    c2_fn=size(find(neg==1),1);
    
    fprintf('Matriz de confusion Clase 2\n')
    fprintf('Verdaderos positivos: %d - Verdaderos negativos: %d\n', c2_vp, c2_vn)
    fprintf('Falsos positivos: %d - Falsos negativos: %d\n', c2_fp, c2_fn)
    
    pause

end



%% Funcion
function [Clasificador, M, Sigma, Pi_var] = clasificador(Clase, DIMENSIONES, K_VAR, espacio, opc)

    Tamano=size(Clase,1);
    for i=1:K_VAR
        M(i,:)=[Clase(randi(Tamano),1:2)];
        Sigma(:,:,i)=eye(DIMENSIONES);
        Pi_var(i)=1/K_VAR;
    end
    
    for z=1:2
       
        for i=1:Tamano
            for j=1:K_VAR
                a=Pi_var(j);
                b=((1/(2*pi)));
                c=(1/sqrt(det(Sigma(:,:,j))));
                d=exp ( -0.5*((Clase(i,:)-M(j,:)) * ((Sigma(:,:,j))^-1) * (Clase(i,:)-M(j,:))') );
                PS(i,j)=Pi_var(j) * (  a * b * d );
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

