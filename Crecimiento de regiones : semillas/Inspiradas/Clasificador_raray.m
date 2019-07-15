clear

raray = load('raray.txt');

X=raray;

datos_x=raray(:,1:2);
datos_y=raray(:,3);

TAMANO=size(raray,1);
VIAS=3;

figure(1)
title('Figura original')
plot(raray(raray(:,3)==1,1),raray(raray(:,3)==1,2),'r*')
hold on
plot(raray(raray(:,3)==2,1),raray(raray(:,3)==2,2),'g*')
plot(raray(raray(:,3)==3,1),raray(raray(:,3)==3,2),'b*')
plot(raray(raray(:,3)==4,1),raray(raray(:,3)==4,2),'c*')

T=zeros(400,4);

for i=1:400
    T(i,raray(i,3))=1;
end

X_g=[raray(:,1),raray(:,2)];
X_g=[ones(400,1),X_g];

W_g=inv(X_g'*X_g)*X_g';

%Entrenamiento
W_g=W_g*T;

% evaluar un espacio
x1=linspace(-10,15,100);
x2=linspace(-20,10,100);

[esp1,esp2]=meshgrid(x1,x2);
espacio=[reshape(esp1,10000,1),reshape(esp2,10000,1)];
espacio=[ones(10000,1),espacio];
y=W_g'*espacio';

clase_datos=W_g'*X';
[val,pos]=max(clase_datos);

[a,b]=max(y);
clase=zeros(10000,1);

for i=1:10000
    clase(i)=b(i);
    if i<=400
        clase_x(i)=pos(i);
    end
end

figure (10)
title('Entrenamiento de clase')
plot(raray(clase_x(:)==1,1),raray(clase_x(:)==1,2),'r*')
hold on
plot(raray(clase_x(:)==2,1),raray(clase_x(:)==2,2),'g*')
plot(raray(clase_x(:)==3,1),raray(clase_x(:)==3,2),'b*')
plot(raray(clase_x(:)==4,1),raray(clase_x(:)==4,2),'c*')
hold off

figure(2),imagesc(x1,x2,reshape(clase,100,100));
hold on
plot(raray(raray(:,3)==1,1),raray(raray(:,3)==1,2),'r*')
plot(raray(raray(:,3)==2,1),raray(raray(:,3)==2,2),'g*')
plot(raray(raray(:,3)==3,1),raray(raray(:,3)==3,2),'b*')
plot(raray(raray(:,3)==4,1),raray(raray(:,3)==4,2),'c*')
hold off

divisor=round(TAMANO/3);
suma=TAMANO;

n_vias(1)=divisor;
n_vias(2)=divisor;
n_vias(3)=divisor;

intervalos=cumsum(n_vias);

tercio_1_x=datos_x(1:intervalos(1),:);
tercio_1_y=datos_y(1:intervalos(1),:);

tercio_2_x=datos_x(intervalos(1)+1:intervalos(2),:);
tercio_2_y=datos_y(intervalos(1)+1:intervalos(2),:);

tercio_3_x=datos_x(intervalos(2)+1:intervalos(3),:);
tercio_3_y=datos_y(intervalos(2)+1:intervalos(3),:);

%Primera validación

entrenamiento_1_x=[tercio_1_x; tercio_2_x];
entrenamiento_1_y=[tercio_1_y; tercio_2_y];

X=[entrenamiento_1_x entrenamiento_1_y];

test_1_x=[tercio_3_x];
test_1_y=[tercio_3_y];

TAMANO=size(entrenamiento_1_x,1);

T=zeros(TAMANO,4);

for i=1:TAMANO
    T(i,entrenamiento_1_y(i))=1;
end

X_g=[entrenamiento_1_x(:,1),entrenamiento_1_x(:,2)];
X_g=[ones(TAMANO,1),X_g];

W_g=inv(X_g'*X_g)*X_g';

%Entrenamiento
W_g=W_g*T;

% evaluar un espacio
x1=linspace(-10,15,100);
x2=linspace(-20,10,100);

[esp1,esp2]=meshgrid(x1,x2);
espacio=[reshape(esp1,10000,1),reshape(esp2,10000,1)];
espacio=[ones(10000,1),espacio];
y=W_g'*espacio';

[a,b]=max(y);
clase=zeros(10000,1);

clear clase_x
clase_datos=W_g'*[test_1_x test_1_y]';
[val,pos]=max(clase_datos);

for i=1:10000
    clase(i)=b(i);
    if i<=size(pos,2)
        clase_x(i)=pos(i);
    end
end

error=abs(clase_x'-test_1_y);
error=error>1;
error=sum(error);
porcentaje_error_1=(((divisor-1)-error)/(divisor-1))*100;


figure(3), imagesc(x1,x2,reshape(clase,100,100));
title('Validacion cruzada 1')
hold on
plot(test_1_x(test_1_y==1,1),test_1_x(test_1_y==1,2),'r*')
plot(test_1_x(test_1_y==2,1),test_1_x(test_1_y==2,2),'b*')
plot(test_1_x(test_1_y==3,1),test_1_x(test_1_y==3,2),'g*')
plot(test_1_x(test_1_y==4,1),test_1_x(test_1_y==4,2),'c*')
hold off

%Segunda validacion

entrenamiento_1_x=[tercio_1_x tercio_3_x];
entrenamiento_1_y=[tercio_1_y tercio_3_y];

test_1_x=[tercio_2_x];
test_1_y=[tercio_2_y];

TAMANO=size(entrenamiento_1_x,1);

T=zeros(TAMANO,4);

for i=1:TAMANO
    T(i,entrenamiento_1_y(i))=1;
end

X_g=[entrenamiento_1_x(:,1),entrenamiento_1_x(:,2)];
X_g=[ones(TAMANO,1),X_g];

W_g=inv(X_g'*X_g)*X_g';

%Entrenamiento
W_g=W_g*T;

% evaluar un espacio
x1=linspace(-10,15,100);
x2=linspace(-20,10,100);

[esp1,esp2]=meshgrid(x1,x2);
espacio=[reshape(esp1,10000,1),reshape(esp2,10000,1)];
espacio=[ones(10000,1),espacio];
y=W_g'*espacio';

[a,b]=max(y);
clase=zeros(10000,1);

clear clase_x
clase_datos=W_g'*[test_1_x test_1_y]';
[val,pos]=max(clase_datos);

for i=1:10000
    clase(i)=b(i);
    if i<=size(pos,2)
        clase_x(i)=pos(i);
    end
end

error=abs(clase_x'-test_1_y);
error=error>1;
error=sum(error);
porcentaje_error_2=(((divisor-1)-error)/(divisor-1))*100;

figure(4), imagesc(x1,x2,reshape(clase,100,100));
title('Validacion cruzada 2')
hold on
plot(test_1_x(test_1_y==1,1),test_1_x(test_1_y==1,2),'r*')
plot(test_1_x(test_1_y==2,1),test_1_x(test_1_y==2,2),'b*')
plot(test_1_x(test_1_y==3,1),test_1_x(test_1_y==3,2),'g*')
plot(test_1_x(test_1_y==4,1),test_1_x(test_1_y==4,2),'c*')
hold off


%Validacion 3

entrenamiento_1_x=[tercio_2_x tercio_3_x];
entrenamiento_1_y=[tercio_2_y tercio_3_y];

test_1_x=[tercio_1_x];
test_1_y=[tercio_1_y];

TAMANO=size(entrenamiento_1_x,1);

T=zeros(TAMANO,4);

for i=1:TAMANO
    T(i,entrenamiento_1_y(i))=1;
end

X_g=[entrenamiento_1_x(:,1),entrenamiento_1_x(:,2)];
X_g=[ones(TAMANO,1),X_g];

W_g=inv(X_g'*X_g)*X_g';

%Entrenamiento
W_g=W_g*T;

% evaluar un espacio
x1=linspace(-10,15,100);
x2=linspace(-20,10,100);

[esp1,esp2]=meshgrid(x1,x2);
espacio=[reshape(esp1,10000,1),reshape(esp2,10000,1)];
espacio=[ones(10000,1),espacio];
y=W_g'*espacio';

[a,b]=max(y);
clase=zeros(10000,1);

clear clase_x
clase_datos=W_g'*[test_1_x test_1_y]';
[val,pos]=max(clase_datos);

for i=1:10000
    clase(i)=b(i);
    if i<=size(pos,2)
        clase_x(i)=pos(i);
    end
end

error=abs(clase_x'-test_1_y);
error=error>1;
error=sum(error);
porcentaje_error_3=(((divisor-1)-error)/(divisor-1))*100;

figure(5), imagesc(x1,x2,reshape(clase,100,100));
title('Validacion cruzada 3')
hold on
plot(test_1_x(test_1_y==1,1),test_1_x(test_1_y==1,2),'r*')
plot(test_1_x(test_1_y==2,1),test_1_x(test_1_y==2,2),'b*')
plot(test_1_x(test_1_y==3,1),test_1_x(test_1_y==3,2),'g*')
plot(test_1_x(test_1_y==4,1),test_1_x(test_1_y==4,2),'c*')
hold off

