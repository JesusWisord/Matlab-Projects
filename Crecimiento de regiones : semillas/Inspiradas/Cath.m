clear
close all

VIAS=5;

dataRaw=importdata('datos_yinyang.dat');
datos_x=dataRaw(:,1:2);
datos_y=dataRaw(:,3);

X=[datos_x datos_y];

figure(1)
plot(datos_x(datos_y==1,1),datos_x(datos_y==1,2),'r*')
hold on
plot(datos_x(datos_y==-1,1),datos_x(datos_y==-1,2),'b*')
title('datos originales')
hold off

TAMANO=size(datos_x,1);

T=zeros(TAMANO,2);

for i=1:TAMANO
    if datos_y(i) == 1
        T(i,1) = 1;
    else
        T(i,2) = 1;
    end
end

X_g=datos_x;
X_g=[ones(TAMANO,1),X_g];

W_g=inv(X_g'*X_g)*X_g';

%Entrenamiento
W_g=W_g*T;


% evaluar un espacio
x1=linspace(-1,1,100);
x2=linspace(-1,1,100);

[esp1,esp2]=meshgrid(x1,x2);
espacio=[reshape(esp1,10000,1),reshape(esp2,10000,1)];
espacio=[ones(10000,1),espacio];
y=W_g'*espacio';

clase_datos=W_g'*[ones(200,1) datos_x]';
[val,pos]=max(clase_datos);

[a,b]=max(y);
clase=zeros(10000,1);

for i=1:10000
    clase(i)=b(i);
    if i<201
        if pos(i) == 1
            datos_clase(i)=1;
        else
            datos_clase(i)=-1;
        end
    end
end





figure (2)
plot(datos_x(datos_clase==1,1),datos_x(datos_clase==1,2),'r*')
hold on
plot(datos_x(datos_clase==-1,1),datos_x(datos_clase==-1,2),'b*')
title('Entrenamiento de clase')
hold off


hold off

figure(3), imagesc(x1,x2,reshape(clase,100,100));
hold on
plot(datos_x(datos_y==1,1),datos_x(datos_y==1,2),'r*')
plot(datos_x(datos_y==-1,1),datos_x(datos_y==-1,2),'b*')
title('espacio entrenado')
hold off

divisor=floor(round(TAMANO/VIAS));

suma=TAMANO;
intervalos=0:divisor:200;

for i=1:VIAS
   
    test_x=datos_x(intervalos(i)+1:intervalos(i+1),:);
    test_y=datos_y(intervalos(i)+1:intervalos(i+1),:);
    entrenamiento_x=datos_x;
    entrenamiento_y=datos_y;
    entrenamiento_x(intervalos(i)+1:intervalos(i+1),:)=[];
    entrenamiento_y(intervalos(i)+1:intervalos(i+1),:)=[];
    
    TAMANO=size(entrenamiento_x,1);

    T=zeros(TAMANO,2);

    for j=1:TAMANO
        if datos_y(j) == 1
            T(j,1) = 1;
        else
            T(j,2) = 1;
        end
    end
    
    X_g=entrenamiento_x;
    X_g=[ones(TAMANO,1),X_g];

    W_g=inv(X_g'*X_g)*X_g';

    %Entrenamiento
    W_g=W_g*T;
    
    % evaluar un espacio
    x1=linspace(-1,1,100);
    x2=linspace(-1,1,100);

    [esp1,esp2]=meshgrid(x1,x2);
    espacio=[reshape(esp1,10000,1),reshape(esp2,10000,1)];
    espacio=[ones(10000,1),espacio];
    y=W_g'*espacio';

    clase_datos=W_g'*[ones(size(test_x,1),1) test_x]';
    [val,pos]=max(clase_datos);

    [a,b]=max(y);
    clase=zeros(10000,1);

    for j=1:10000
        clase(j)=b(j);
        if j<=size(test_x,1)
            if pos(j) == 1
                test_clase(j)=1;
            else
                test_clase(j)=-1;
            end
        end
    end

    f2 = figure (2)
    plot(test_x(test_clase==1,1),test_x(test_clase==1,2),'ro')
    hold on
    plot(test_x(test_clase==-1,1),test_x(test_clase==-1,2),'ko')
    title('Datos Clasificados')
    hold off
    msg=strcat('Datos Clasificados via ',num2str(i),'.png')
    saveas(f2,msg)

    f3 = figure(3), imagesc(x1,x2,reshape(clase,100,100));
    hold on
    plot(test_x(test_y==1,1),test_x(test_y==1,2),'ro')
    plot(test_x(test_y==-1,1),test_x(test_y==-1,2),'ko')
    title('Espacio Clasificado')
    hold off
    msg=strcat('Espacio Clasificados via ',num2str(i),'.png')
    saveas(f3,msg)
    
    auxiliar_1=test_y==1;
    auxiliar_2=test_clase'==1;
    
    verd=auxiliar_1+auxiliar_2;
    c1_vp=size(find(verd==2),1);
    c1_vn=size(find(verd==0),1);
    
    neg=auxiliar_1-auxiliar_2;
    c1_fp=size(find(neg==-1),1);
    c1_fn=size(find(neg==1),1);
    
    fprintf('Matriz de confusion Clase 1\n')
    fprintf('Verdaderos positivos: %d - Verdaderos negativos: %d\n', c1_vp, c1_vn)
    fprintf('Falsos positivos: %d - Falsos negativos: %d\n', c1_fp, c1_fn)
    
    auxiliar_1=test_y==-1;
    auxiliar_2=test_clase'==-1;
    
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


