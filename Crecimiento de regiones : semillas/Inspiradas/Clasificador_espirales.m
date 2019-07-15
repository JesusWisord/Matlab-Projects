clear

VIAS=3;

load('dos_espirales.mat');
datos_x=x;
datos_y=y;

X=[x;y]

plot(datos_x(1,datos_y==1),datos_x(2,datos_y==1),'r*')
hold on
plot(datos_x(1,datos_y==0),datos_x(2,datos_y==0),'b*')
hold off

TAMANO=size(x,2);

T=zeros(TAMANO,2);

for i=1:TAMANO
    T(i,datos_y(i)+1)=1;
end

X_g=[x(1,:)',x(2,:)'];
X_g=[ones(TAMANO,1),X_g];

W_g=inv(X_g'*X_g)*X_g';

%Entrenamiento
W_g=W_g*T;

%evaluar un espacio
x1=linspace(-1,1,100);
x2=linspace(-1,1,100);

[esp1,esp2]=meshgrid(x1,x2);
espacio=[reshape(esp1,10000,1),reshape(esp2,10000,1)];
espacio=[ones(10000,1),espacio];
y=W_g'*espacio';

clase_datos=W_g'*X;
[val,pos]=max(clase_datos);

[a,b]=max(y);
clase=zeros(10000,1);

for i=1:10000
    clase(i)=b(i);
    if i<=2000
        clase_x(i)=pos(i);
    end
end





figure (10)
title('Entrenamiento de clase')
plot(datos_x(1,clase_x==1),datos_x(2,clase_x==1),'r*')
hold on
plot(datos_x(1,clase_x==2),datos_x(2,clase_x==2),'b*')


hold off

figure(2), imagesc(x1,x2,reshape(clase,100,100));
hold on
plot(datos_x(1,datos_y==1),datos_x(2,datos_y==1),'r*')
plot(datos_x(1,datos_y==0),datos_x(2,datos_y==0),'b*')
hold off

divisor=floor(round(TAMANO/3));
suma=TAMANO;

n_vias(1:3)=divisor-1;

intervalos=cumsum(n_vias);

tercio_1_x=datos_x(:,1:intervalos(1));
tercio_1_y=datos_y(:,1:intervalos(1));

tercio_2_x=datos_x(:,intervalos(1)+1:intervalos(2));
tercio_2_y=datos_y(:,intervalos(1)+1:intervalos(2));

tercio_3_x=datos_x(:,intervalos(2)+1:intervalos(3));
tercio_3_y=datos_y(:,intervalos(2)+1:intervalos(3));

%Primera validación

entrenamiento_1_x=[tercio_1_x tercio_2_x];
entrenamiento_1_y=[tercio_1_y tercio_2_y];

test_1_x=[tercio_3_x];
test_1_y=[tercio_3_y];

TAMANO=size(entrenamiento_1_x,2);

T=zeros(TAMANO,2);

for i=1:TAMANO
    T(i,entrenamiento_1_y(i)+1)=1;
end

X_g=[entrenamiento_1_x(1,:)',entrenamiento_1_x(2,:)'];
X_g=[ones(TAMANO,1),X_g];

W_g=inv(X_g'*X_g)*X_g';

%Entrenamiento
W_g=W_g*T;

%evaluar un espacio
x1=linspace(-1,1,100);
x2=linspace(-1,1,100);

[esp1,esp2]=meshgrid(x1,x2);
espacio=[reshape(esp1,10000,1),reshape(esp2,10000,1)];
espacio=[ones(10000,1),espacio];
y=W_g'*espacio';

[a,b]=max(y);
clase=zeros(10000,1);

for i=1:10000
    clase(i)=b(i);
end

figure(2), imagesc(x1,x2,reshape(clase,100,100));
title('Validacion cruzada 1')
hold on
plot(test_1_x(1,test_1_y==1),test_1_x(2,test_1_y==1),'r*')
plot(test_1_x(1,test_1_y==0),test_1_x(2,test_1_y==0),'b*')
hold off

error=0;
c=reshape(clase,100,100);

for cont=1:divisor-1
   vec_1=x1>test_1_x(1,cont);
   vec_2=x2>test_1_x(2,cont);
   
   pos_1=find(vec_1==1);
   pos_2=find(vec_2==1);
   
   pos_1=pos_1(1,1);
   pos_2=pos_2(1,1);
   
   if c(pos_1,pos_2)~=test_1_y(1,cont)+1
       error=error+1;
   end
end

porcentaje_error_1=(((divisor-1)-error)/(divisor-1))*100;

%Segunda validación

entrenamiento_2_x=[tercio_1_x tercio_3_x];
entrenamiento_2_y=[tercio_1_y tercio_3_y];

test_2_x=[tercio_2_x];
test_2_y=[tercio_2_y];

TAMANO=size(entrenamiento_2_x,2);

T=zeros(TAMANO,2);

for i=1:TAMANO
    T(i,entrenamiento_2_y(i)+1)=1;
end

X_g=[entrenamiento_2_x(1,:)',entrenamiento_2_x(2,:)'];
X_g=[ones(TAMANO,1),X_g];

W_g=inv(X_g'*X_g)*X_g';

%Entrenamiento
W_g=W_g*T;

%evaluar un espacio
x1=linspace(-1,1,100);
x2=linspace(-1,1,100);

[esp1,esp2]=meshgrid(x1,x2);
espacio=[reshape(esp1,10000,1),reshape(esp2,10000,1)];
espacio=[ones(10000,1),espacio];
y=W_g'*espacio';

[a,b]=max(y);
clase=zeros(10000,1);

for i=1:10000
    clase(i)=b(i);
end

figure(3), imagesc(x1,x2,reshape(clase,100,100));
title('Validacion cruzada 2')
hold on
plot(test_2_x(1,test_2_y==1),test_2_x(2,test_2_y==1),'r*')
plot(test_2_x(1,test_2_y==0),test_2_x(2,test_2_y==0),'b*')
hold off

error=0;
c=reshape(clase,100,100);

for cont=1:divisor-1
   vec_1=x1>test_2_x(1,cont);
   vec_2=x2>test_2_x(2,cont);
   
   pos_1=find(vec_1==1);
   pos_2=find(vec_2==1);
   
   pos_1=pos_1(1,1);
   pos_2=pos_2(1,1);
   
   if c(pos_1,pos_2)~=test_2_y(1,cont)+1
       error=error+1;
   end
end

porcentaje_error_2=(((divisor-1)-error)/(divisor-1))*100;

%Tercera validación

entrenamiento_3_x=[tercio_2_x tercio_3_x];
entrenamiento_3_y=[tercio_2_y tercio_3_y];

test_3_x=[tercio_1_x];
test_3_y=[tercio_1_y];

TAMANO=size(entrenamiento_3_x,2);

T=zeros(TAMANO,2);

for i=1:TAMANO
    T(i,entrenamiento_3_y(i)+1)=1;
end

X_g=[entrenamiento_3_x(1,:)',entrenamiento_3_x(2,:)'];
X_g=[ones(TAMANO,1),X_g];

W_g=inv(X_g'*X_g)*X_g';

%Entrenamiento
W_g=W_g*T;

%evaluar un espacio
x1=linspace(-1,1,100);
x2=linspace(-1,1,100);

[esp1,esp2]=meshgrid(x1,x2);
espacio=[reshape(esp1,10000,1),reshape(esp2,10000,1)];
espacio=[ones(10000,1),espacio];
y=W_g'*espacio';

[a,b]=max(y);
clase=zeros(10000,1);

for i=1:10000
    clase(i)=b(i);
end

figure(4), imagesc(x1,x2,reshape(clase,100,100));
title('Validacion cruzada 3')
hold on
plot(test_3_x(1,test_3_y==1),test_3_x(2,test_3_y==1),'r*')
plot(test_3_x(1,test_3_y==0),test_3_x(2,test_3_y==0),'b*')
hold off

error=0;
c=reshape(clase,100,100);

for cont=1:divisor-1
   vec_1=x1>test_3_x(1,cont);
   vec_2=x2>test_3_x(2,cont);
   
   pos_1=find(vec_1==1);
   pos_2=find(vec_2==1);
   
   pos_1=pos_1(1,1);
   pos_2=pos_2(1,1);
   
   if c(pos_1,pos_2)~=test_3_y(1,cont)+1
       error=error+1;
   end
end

porcentaje_error_3=(((divisor-1)-error)/(divisor-1))*100;

