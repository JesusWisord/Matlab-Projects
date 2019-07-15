clc
clearvars

MUESTRAS=load('raray.txt');

ESPACIO = [-10 15; -20 10];

BITS=2;
K=10;

MUESTRAS_BR=0;
RESOLUCION=400;

x1=linspace(-10,15,RESOLUCION);
x2=linspace(-20,10,RESOLUCION);

[esp1,esp2]=meshgrid(x1,x2);

%centroides=[esp1(randi(100,1,2)),esp2(randi(100,1,2));
%    esp1(randi(100,1,2)),esp2(randi(100,1,2));
%    esp1(randi(100,1,2)),esp2(randi(100,1,2));
%    esp1(randi(100,1,2)),esp2(randi(100,1,2));]

for i=1:K
    centroides(i,:)=[MUESTRAS(randi(400),1:2);]
end

plot(MUESTRAS(:,1),MUESTRAS(:,2),'*r')
hold on
plot(centroides(:,1),centroides(:,2),'*b')

condicion=1;
iteraciones=1;
while condicion
    for i=1:size(MUESTRAS,1)
        for j=1:K;
            distancia(i,j) = sum((centroides(j,:)-MUESTRAS(i,1:2)).^2).^0.5;
        end
    end

    for k=1:K
        for i=1:RESOLUCION
            for j=1:RESOLUCION
                distancia_espacio(i,j,k)= sum((centroides(k,:)-[esp1(i,j),esp2(i,j)]).^2).^0.5;
            end
        end
    end

    [values, pos_muestras]=min(distancia,[],2);
    [values, pos_espacio]=min(distancia_espacio,[],3);

    r=zeros(size(MUESTRAS,1),K)

    for i=1:size(MUESTRAS,1)
        r(i,pos_muestras(i))=1;
    end

    x=r.*(MUESTRAS(:,1));
    y=r.*(MUESTRAS(:,2));

    promedio_x=sum(x)./sum(x~=0);
    promedio_y=sum(y)./sum(y~=0);

    centroides_nuevos=[promedio_x',promedio_y']

    cambio=centroides_nuevos-centroides;
    cambio=cambio>.5;
    condicion=max(max(cambio));
    centroides=centroides_nuevos;
    iteraciones=iteraciones+1;
end
iteraciones
figure(2), imagesc(x1,x2,reshape(pos_espacio,RESOLUCION,RESOLUCION));
hold on
plot(MUESTRAS(:,1),MUESTRAS(:,2),'*g')
plot(centroides(:,1),centroides(:,2),'*r')




