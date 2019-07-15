clearvars

dataRaw=importdata('datos_yinyang.dat');
data=dataRaw(:,1:2);
Clase_d=dataRaw(:,3);
T=zeros(size(data,1),2);
neu=25;

for i=1:size(T,1)
    if Clase_d(i)==-1
        T(i,1)=1;
    else
        T(i,2)=1;
    end
end

% x1=linspace(-1,1,100);
% x2=linspace(-1,1,100);
% 
% [esp1,esp2]=meshgrid(x1,x2);
% espacio=[reshape(esp1,10000,1),reshape(esp2,10000,1)];

% red=mlp(2,15,2,'logistic');
% [net, options]=netopt(red, foptions, data, T, 'scg');
% Y=mlpfwd(net, espacio);
% [value,Clase]=max(Y,[],2);

% 
% imagesc(x1,x2,reshape(Clase,100,100))
% hold on
% plot(data(dataRaw(:,3)==1,1),data(dataRaw(:,3)==1,2),'b*')
% plot(data(dataRaw(:,3)==-1,1),data(dataRaw(:,3)==-1,2),'g*')

nvias=3;
particiones=floor(size(data,1)/nvias);

via(:,:,1)=dataRaw(1:particiones,:);
via(:,:,2)=dataRaw(particiones+1:particiones*2,:);
via(:,:,3)=dataRaw((particiones*2)+1:particiones*3,:);



for i=1:nvias
    
    Test=via(:,1:2,i);
    Clase_Test=via(:,3,i);
    clear Clase T
    switch i
        case 1
            
           via_2=via(:,1:2,2);
           clase_via_2=via(:,3,2);
           T_2=zeros(size(via_2,1),2);
           for k=1:size(via_2,1)
                if Clase_d(k)==-1
                    T_2(k,1)=1;
                else
                    T_2(k,2)=1;
                end
           end
           
           via_3=via(:,1:2,3);
           clase_via_3=via(:,3,3);
           T_3=zeros(size(via_3,1),2);
           for k=1:size(via_3,1)
                if Clase_d(k)==-1
                    T_3(k,1)=1;
                else
                    T_3(k,2)=1;
                end
           end
           
           entrenamiento=[via_2; via_3];
           T=[T_2; T_3];
           red=mlp(2,neu,2,'logistic');
           [net, options]=netopt(red, foptions, entrenamiento, T, 'scg');
           Y=mlpfwd(net, Test);
           [value,Clase]=max(Y,[],2);
           
           Clase(Clase==2)=-1;
           %Clase(Clase==1)=1;
           
        case 2
            
           via_1=via(:,1:2,1);
           clase_via_1=via(:,3,1);
           T_1=zeros(size(via_1,1),1);
           for k=1:size(via_1,1)
                if Clase_d(k)==-1
                    T_1(k,1)=1;
                else
                    T_1(k,2)=1;
                end
           end
           
           via_3=via(:,1:2,3);
           clase_via_3=via(:,3,3);
           T_3=zeros(size(via_3,1),2);
           for k=1:size(via_3,1)
                if Clase_d(k)==-1
                    T_3(k,1)=1;
                else
                    T_3(k,2)=1;
                end
           end
           entrenamiento=[via_1; via_3];
           T=[T_1; T_3];
           red=mlp(2,neu,2,'logistic');
           [net, options]=netopt(red, foptions, entrenamiento, T, 'scg');
           Y=mlpfwd(net, Test);
           [value,Clase]=max(Y,[],2);
           
           Clase(Clase==2)=-1;
           Clase(Clase==1)=1;
            
        case 3
           via_1=via(:,1:2,1);
           clase_via_1=via(:,3,1);
           T_1=zeros(size(via_1,1),1);
           for k=1:size(via_1,1)
                if Clase_d(k)==-1
                    T_1(k,1)=1;
                else
                    T_1(k,2)=1;
                end
           end
           
           via_2=via(:,1:2,2);
           clase_via_2=via(:,3,2);
           T_2=zeros(size(via_2,1),2);
           for k=1:size(via_2,1)
                if Clase_d(k)==-1
                    T_2(k,1)=1;
                else
                    T_2(k,2)=1;
                end
           end
           entrenamiento=[via_1; via_2];
           T=[T_1; T_2];
           red=mlp(2,neu,2,'logistic');
           [net, options]=netopt(red, foptions, entrenamiento, T, 'scg');
           Y=mlpfwd(net, Test);
           [value,Clase]=max(Y,[],2);
           
           Clase(Clase==2)=-1;
           Clase(Clase==1)=1;
    end
    
    Porcentaje=sum(Clase_Test==Clase*-1);
    Porcentaje=((Porcentaje/66)*100)
    
end
