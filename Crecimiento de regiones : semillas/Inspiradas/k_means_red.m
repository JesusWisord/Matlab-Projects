clc
clearvars

DIR=('rm/');
IMAGEN=uint8(dicomread('rm/000036.dcm'));

BITS=3;

K=2^BITS;
centroides=[];

while size(centroides,2)<K
    for i=1:K
        centroides(i)=randi(256);
    end
    centroides=unique(centroides);
end



for i=1:256
    for j=1:K;
        distancia(i,j) = round(sum((centroides(j)-i).^2).^0.5);
    end
end

[values, pos_muestras]=min(distancia,[],2);

r=zeros(256,K)

for i=1:256
    r(i,pos_muestras(i))=1;
end

for i=1:size(IMAGEN,1)
    for j=1:size(IMAGEN,2)
            IMAGEN_2(i,j)=centroides(pos_muestras(IMAGEN(i,j)+1));
    end
end

%gray=r.*([1:255]');

%promedio_gray=sum(gray)./sum(gray~=0);

%centroides=[promedio_gray']

figure(1), imshow(IMAGEN)

figure(2), imshow(uint8(IMAGEN_2))

IMAGEN_3=reshape(double(uint8(dicomread('rm/000037.dcm'))),512*512,1);



%39 37
AUX=reshape(IMAGEN_2,512*512,1);
for i=1:size(AUX,1)
       T(i,:)=IMAGEN_2(i)==centroides;
end

T=double(T);
entrenamiento=double(reshape(IMAGEN,512*512,1));

red=mlp(1,5,K,'softmax');
[net, options]=netopt(red, foptions, entrenamiento, T, 'scg');
Y=mlpfwd(net, IMAGEN_3);
[value,Clase]=max(abs(Y),[],2);

unique(Clase)

for i=1:size(AUX,1)
       img(i)=centroides(Clase(i));
end

figure (3), imshow(uint8(reshape(img,512,512)))
