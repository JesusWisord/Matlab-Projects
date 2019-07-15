clc
clearvars

IMAGEN=imread('pajaro_grises.jpg');

K=8;

for i=1:K
    centroides(i)=randi(255);
end

for i=1:255
    for j=1:K;
        distancia(i,j) = round(sum((centroides(j)-i).^2).^0.5);
    end
end

[values, pos_muestras]=min(distancia,[],2);

r=zeros(255,K)

for i=1:255
    r(i,pos_muestras(i))=1;
end

for i=1:size(IMAGEN,1)
    for j=1:size(IMAGEN,2)
        IMAGEN_2(i,j)=centroides(pos_muestras(IMAGEN(i,j)));
    end
end

gray=r.*([1:255]');

promedio_gray=sum(gray)./sum(gray~=0);

%centroides=[promedio_gray']

figure(1), imshow(IMAGEN)

figure(2), imshow(uint8(IMAGEN_2))