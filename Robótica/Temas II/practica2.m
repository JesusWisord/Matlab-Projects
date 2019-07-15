clc;
close all;
clear all;

[ signal, states, parameters, total_samples, file_samples ]= load_bcidat('LPSS001R02.dat','LPSS001R03.dat','LPSS001R04.dat');
%Separa las señales
s1=signal(1:48968,:)';
s2=signal(48969:107600,:)';
s3=signal(107601:156568,:)';
%Obtener vector con numeros de estimulo
estimulo1=states.StimulusCode(1:48968);
estimulo2=states.StimulusCode(48969:107600);
estimulo3=states.StimulusCode(107601:156568);
%Obtener frecuencia de muestreo
fs=parameters.SamplingRate.NumericValue; %256

%Primera palabra:CALOR
C1_37=find(estimulo1(1:9793)==3 | estimulo1(1:9793)==7); %Palabra 1, letra C, valores 3 y 7. Hay 30 estimulos (ventanas) para cada una de las letras (15 de cada numero)
C1_others=find(estimulo1(1:9793)~=3 & estimulo1(1:9793)~=7 & estimulo1(1:9793)~=0); %Se tienen 150 ventanas de los otros numeros (15 ventanas por numero)
A1_17=find(estimulo1(9794:19586)==1 | estimulo1(9794:19586)==7);
A1_others=find(estimulo1(9794:19586)~=1 & estimulo1(9794:19586)~=7 & estimulo1(9794:19586)~=0);
L1_68=find(estimulo1(19587:29380)==6 | estimulo1(19587:29380)==8);
L1_others=find(estimulo1(19587:29380)~=6 & estimulo1(19587:29380)~=8 & estimulo1(19587:29380)~=0);
O1_39=find(estimulo1(29381:39174)==3 | estimulo1(29381:39174)==9);
O1_others=find(estimulo1(29381:39174)~=3 & estimulo1(29381:39174)~=9 & estimulo1(29381:39174)~=0);
R1_96=find(estimulo1(39175:48968)==9 | estimulo1(39175:48968)==6);
R1_others=find(estimulo1(39175:48968)~=9 & estimulo1(39175:48968)~=6 & estimulo1(39175:48968)~=0);

tam_ven=153; %Tamaño de la ventana

ventanas_C1=zeros(30,154,10); %30 ventanas por cada letra de 154 muestras, por los 10 canales
ventanas_A1=zeros(30,154,10); 
ventanas_L1=zeros(30,154,10); 
ventanas_O1=zeros(30,154,10); 
ventanas_R1=zeros(30,154,10); 

%Obtener ventanas de las letras con sus numeros correspondientes
for j=1:10 %Numero de canal 
    aux=1; %numero de ventana
    for i=1:16:480 
        ventanas_C1(aux,:,j)=s1(j,C1_37(i):C1_37(i)+tam_ven); %ventana letra C, canal 1
        ventanas_A1(aux,:,j)=s1(j,A1_17(i):A1_17(i)+tam_ven);
        ventanas_L1(aux,:,j)=s1(j,L1_68(i):L1_68(i)+tam_ven);
        ventanas_O1(aux,:,j)=s1(j,O1_39(i):O1_39(i)+tam_ven);
        ventanas_R1(aux,:,j)=s1(j,R1_96(i):R1_96(i)+tam_ven);
        aux=aux+1;
    end
end

%Promediación de ventanas por canal
ventana_C1=zeros(1,154,10);
ventana_A1=zeros(1,154,10);
ventana_L1=zeros(1,154,10);
ventana_O1=zeros(1,154,10);
ventana_R1=zeros(1,154,10);

for j=1:10 %CANALES 
    for i=1:30 %VENTANAS
        ventana_C1(1,:,j)=ventana_C1(1,:,j)+ventanas_C1(i,:,j);
        ventana_A1(1,:,j)=ventana_A1(1,:,j)+ventanas_A1(i,:,j);
        ventana_L1(1,:,j)=ventana_L1(1,:,j)+ventanas_L1(i,:,j);
        ventana_O1(1,:,j)=ventana_O1(1,:,j)+ventanas_O1(i,:,j);
        ventana_R1(1,:,j)=ventana_R1(1,:,j)+ventanas_R1(i,:,j);
    end
    ventana_C1(1,:,j)=ventana_C1(1,:,j)/30;
    ventana_A1(1,:,j)=ventana_A1(1,:,j)/30;
    ventana_L1(1,:,j)=ventana_L1(1,:,j)/30;
    ventana_O1(1,:,j)=ventana_O1(1,:,j)/30;
    ventana_R1(1,:,j)=ventana_R1(1,:,j)/30;
end
%%HASTA AQUÍ ESTAN LOS CANALES POR LETRA POR LA PALABRA CALOR

%%CHECANDO EL RUIDO
ventanas_C1_others=zeros(150,154,10); %150 ventanas por cada letra de 154 muestras, por los 10 canales
ventanas_A1_others=zeros(150,154,10); 
ventanas_L1_others=zeros(150,154,10); 
ventanas_O1_others=zeros(150,154,10); 
ventanas_R1_others=zeros(150,154,10);

%Obtener ventanas de ruido
for j=1:10 %Numero de canal 
    aux=1; %numero de ventana
    for i=1:16:2400 
        ventanas_C1_others(aux,:,j)=s1(j,C1_others(i):C1_others(i)+tam_ven); %ventana letra C, canal 1
        ventanas_A1_others(aux,:,j)=s1(j,A1_others(i):A1_others(i)+tam_ven);
        ventanas_L1_others(aux,:,j)=s1(j,L1_others(i):L1_others(i)+tam_ven);
        ventanas_O1_others(aux,:,j)=s1(j,O1_others(i):O1_others(i)+tam_ven);
        ventanas_R1_others(aux,:,j)=s1(j,R1_others(i):R1_others(i)+tam_ven);
        aux=aux+1;
    end
end


%Promediación de ventanas por canal para el RUIDO
ventana_C1_others=zeros(1,154,10);
ventana_A1_others=zeros(1,154,10);
ventana_L1_others=zeros(1,154,10);
ventana_O1_others=zeros(1,154,10);
ventana_R1_others=zeros(1,154,10);

for j=1:10 %CANALES 
    for i=1:150 %VENTANAS
        ventana_C1_others(1,:,j)=ventana_C1_others(1,:,j)+ventanas_C1_others(i,:,j);
        ventana_A1_others(1,:,j)=ventana_A1_others(1,:,j)+ventanas_A1_others(i,:,j);
        ventana_L1_others(1,:,j)=ventana_L1_others(1,:,j)+ventanas_L1_others(i,:,j);
        ventana_O1_others(1,:,j)=ventana_O1_others(1,:,j)+ventanas_O1_others(i,:,j);
        ventana_R1_others(1,:,j)=ventana_R1_others(1,:,j)+ventanas_R1_others(i,:,j);
    end
    ventana_C1_others(1,:,j)=ventana_C1_others(1,:,j)/150;
    ventana_A1_others(1,:,j)=ventana_A1_others(1,:,j)/150;
    ventana_L1_others(1,:,j)=ventana_L1_others(1,:,j)/150;
    ventana_O1_others(1,:,j)=ventana_O1_others(1,:,j)/150;
    ventana_R1_others(1,:,j)=ventana_R1_others(1,:,j)/150;
end

    
 %% Sushi 
S3_110=find(estimulo3(1:9793)==1 | estimulo3(1:9793)==10); %Palabra 1, letra C, valores 3 y 7. Hay 30 estimulos (ventanas) para cada una de las letras (15 de cada numero)
S3_others=find(estimulo3(1:9793)~=0 & estimulo3(1:9793)~=1 & estimulo3(1:9793)~=10); %Se tienen 150 ventanas de los otros numeros (15 ventanas por numero)
U3_310=find(estimulo3(9794:19586)==3 | estimulo3(9794:19586)==10);
U3_others=find(estimulo3(9794:19586)~=0 & estimulo3(9794:19586)~=3 & estimulo3(9794:19586)~=10);
SS3_110=find(estimulo3(19587:29380)==1 | estimulo3(19587:29380)==10);
SS3_others=find(estimulo3(19587:29380)~=0 & estimulo3(19587:29380)~=1 & estimulo3(19587:29380)~=10);
H3_28=find(estimulo3(29381:39174)==2 | estimulo3(29381:39174)==8);
H3_others=find(estimulo3(29381:39174)~=0 & estimulo3(29381:39174)~=2 & estimulo3(29381:39174)~=8);
I3_38=find(estimulo3(39175:48968)==3 | estimulo3(39175:48968)==8);
I3_others=find(estimulo3(39175:48968)~=0 & estimulo3(39175:48968)~=2 & estimulo3(39175:48968)~=8);


ventanas_S3=zeros(30,154,10); %30 ventanas por cada letra de 154 muestras, por los 10 canales
ventanas_U3=zeros(30,154,10); 
ventanas_SS3=zeros(30,154,10); 
ventanas_H3=zeros(30,154,10); 
ventanas_I3=zeros(30,154,10); 

%Obtener ventanas de las letras con sus numeros correspondientes
for j=1:10 %Numero de canal 
    aux=1; %numero de ventana
    for i=1:16:480 
        ventanas_S3(aux,:,j)=s3(j,S3_110(i):S3_110(i)+tam_ven); %ventana letra C, canal 1
        ventanas_U3(aux,:,j)=s3(j,U3_310(i):U3_310(i)+tam_ven);
        ventanas_SS3(aux,:,j)=s3(j,SS3_110(i):SS3_110(i)+tam_ven);
        ventanas_H3(aux,:,j)=s3(j,H3_28(i):H3_28(i)+tam_ven);
        ventanas_U3(aux,:,j)=s3(j,I3_38(i):I3_38(i)+tam_ven);
        aux=aux+1;
    end
end

%Promediación de ventanas por canal
ventana_S3=zeros(1,154,10); %30 ventanas por cada letra de 154 muestras, por los 10 canales
ventana_U3=zeros(1,154,10); 
ventana_SS3=zeros(1,154,10); 
ventana_H3=zeros(1,154,10); 
ventana_I3=zeros(1,154,10); 

for j=1:10 %CANALES 
    for i=1:30 %VENTANAS
        ventana_S3(1,:,j)=ventana_S3(1,:,j)+ventanas_S3(i,:,j);
        ventana_U3(1,:,j)=ventana_U3(1,:,j)+ventanas_U3(i,:,j);
        ventana_SS3(1,:,j)=ventana_SS3(1,:,j)+ventanas_SS3(i,:,j);
        ventana_H3(1,:,j)=ventana_H3(1,:,j)+ventanas_H3(i,:,j);
        ventana_I3(1,:,j)=ventana_I3(1,:,j)+ventanas_I3(i,:,j);
    end
    ventana_S3(1,:,j)=ventana_S3(1,:,j)/30;
    ventana_U3(1,:,j)=ventana_U3(1,:,j)/30;
    ventana_SS3(1,:,j)=ventana_SS3(1,:,j)/30;
    ventana_H3(1,:,j)=ventana_H3(1,:,j)/30;
    ventana_I3(1,:,j)=ventana_I3(1,:,j)/30;
end

%%CHECANDO EL RUIDO SUSHI
ventanas_S3_others=zeros(150,154,10); %30 ventanas por cada letra de 154 muestras, por los 10 canales
ventanas_U3_others=zeros(150,154,10); 
ventanas_SS3_others=zeros(150,154,10); 
ventanas_H3_others=zeros(150,154,10); 
ventanas_I3_others=zeros(150,154,10);
%%HASTA AQUÍ ESTAN LOS CANALES POR LETRA POR LA PALABRA SUSHI

%Obtener ventanas de ruido
for j=1:10 %Numero de canal 
    aux=1; %numero de ventana
    for i=1:16:2400 
        ventanas_S3_others(aux,:,j)=s3(j,S3_others(i):S3_others(i)+tam_ven); %ventana letra C, canal 1
        ventanas_U3_others(aux,:,j)=s3(j,U3_others(i):U3_others(i)+tam_ven);
        ventanas_SS3_others(aux,:,j)=s3(j,SS3_others(i):SS3_others(i)+tam_ven);
        ventanas_H3_others(aux,:,j)=s3(j,H3_others(i):H3_others(i)+tam_ven);
        ventanas_I3_others(aux,:,j)=s3(j,I3_others(i):I3_others(i)+tam_ven);
        aux=aux+1;
    end
end

%Promediación de ventanas por canal para el RUIDO
ventana_S3_others=zeros(1,154,10);
ventana_U3_others=zeros(1,154,10);
ventana_SS3_others=zeros(1,154,10);
ventana_H3_others=zeros(1,154,10);
ventana_I3_others=zeros(1,154,10);

for j=1:10 %CANALES 
    for i=1:150 %VENTANAS
        ventana_S3_others(1,:,j)=ventana_S3_others(1,:,j)+ventanas_S3_others(i,:,j);
        ventana_U3_others(1,:,j)=ventana_U3_others(1,:,j)+ventanas_U3_others(i,:,j);
        ventana_SS3_others(1,:,j)=ventana_SS3_others(1,:,j)+ventanas_SS3_others(i,:,j);
        ventana_H3_others(1,:,j)=ventana_H3_others(1,:,j)+ventanas_H3_others(i,:,j);
        ventana_I3_others(1,:,j)=ventana_I3_others(1,:,j)+ventanas_I3_others(i,:,j);
    end
    ventana_S3_others(1,:,j)=ventana_S3_others(1,:,j)/150;
    ventana_U3_others(1,:,j)=ventana_U3_others(1,:,j)/150;
    ventana_SS3_others(1,:,j)=ventana_SS3_others(1,:,j)/150;
    ventana_H3_others(1,:,j)=ventana_H3_others(1,:,j)/150;
    ventana_I3_others(1,:,j)=ventana_I3_others(1,:,j)/150;
end

%%PAlabra CARINO

%Primera palabra:CARINO
C2_37=find(estimulo2(1:9772)==3 | estimulo2(1:9772)==7); %Palabra 1, letra C, valores 3 y 7. Hay 30 estimulos (ventanas) para cada una de las letras (15 de cada numero)
C2_others=find(estimulo2(1:9772)~=0 & estimulo2(1:9772)~=3 & estimulo2(1:9772)~=7); %Se tienen 150 ventanas de los otros numeros (15 ventanas por numero)
A2_17=find(estimulo2(9773:19544)==1 | estimulo2(9773:19544)==7);
A2_others=find(estimulo2(9773:19544)~=0 & estimulo2(9773:19544)~=1 & estimulo2(9773:19544)~=7);
R2_96=find(estimulo2(19545:29316)==9 | estimulo2(19545:29316)==6);
R2_others=find(estimulo2(19545:29316)~=0 & estimulo2(19545:29316)~=9 & estimulo2(19545:29316)~=6);
I2_38=find(estimulo2(29317:39088)==3 | estimulo2(29317:39088)==8);
I2_others=find(estimulo2(29317:39088)~=0 & estimulo2(29317:39088)~=3 & estimulo2(29317:39088)~=8);
N2_29=find(estimulo2(39089:48860)==2 | estimulo2(39089:48860)==9);
N2_others=find(estimulo2(39089:48860)~=0 & estimulo2(39089:48860)~=2 & estimulo2(39089:48860)~=9);
O2_39=find(estimulo2(48861:58632)==3 | estimulo2(48861:58632)==9);
O2_others=find(estimulo2(48861:58632)~=0 & estimulo2(48861:58632)~=3 & estimulo2(48861:58632)~=9);


ventanas_C2=zeros(30,154,10); %30 ventanas por cada letra de 154 muestras, por los 10 canales
ventanas_A2=zeros(30,154,10); 
ventanas_R2=zeros(30,154,10); 
ventanas_I2=zeros(30,154,10); 
ventanas_N2=zeros(30,154,10); 
ventanas_O2=zeros(30,154,10); 

%Obtener ventanas de las letras con sus numeros correspondientes
for j=1:10 %Numero de canal 
    aux=1; %numero de ventana
    for i=1:16:480 
        ventanas_C2(aux,:,j)=s2(j,C2_37(i):C2_37(i)+tam_ven); %ventana letra C, canal 1
        ventanas_A2(aux,:,j)=s2(j,A2_17(i):A2_17(i)+tam_ven);
        ventanas_R2(aux,:,j)=s2(j,R2_96(i):R2_96(i)+tam_ven);
        ventanas_I2(aux,:,j)=s2(j,I2_38(i):I2_38(i)+tam_ven);
        ventanas_N2(aux,:,j)=s2(j,N2_29(i):N2_29(i)+tam_ven);
        ventanas_O2(aux,:,j)=s2(j,O2_39(i):O2_39(i)+tam_ven);

        aux=aux+1;
    end
end

%Promediación de ventanas por canal
ventana_C2=zeros(1,154,10); %30 ventanas por cada letra de 154 muestras, por los 10 canales
ventana_A2=zeros(1,154,10); 
ventana_R2=zeros(1,154,10); 
ventana_I2=zeros(1,154,10); 
ventana_N2=zeros(1,154,10);
ventana_O2=zeros(1,154,10);

for j=1:10 %CANALES 
    for i=1:30 %VENTANAS
        ventana_C2(1,:,j)=ventana_C2(1,:,j)+ventanas_C2(i,:,j);
        ventana_A2(1,:,j)=ventana_A2(1,:,j)+ventanas_A2(i,:,j);
        ventana_R2(1,:,j)=ventana_R2(1,:,j)+ventanas_R2(i,:,j);
        ventana_I2(1,:,j)=ventana_I2(1,:,j)+ventanas_I2(i,:,j);
        ventana_N2(1,:,j)=ventana_N2(1,:,j)+ventanas_N2(i,:,j);
        ventana_O2(1,:,j)=ventana_O2(1,:,j)+ventanas_O2(i,:,j);

    end
    ventana_C2(1,:,j)=ventana_C2(1,:,j)/30;
    ventana_A2(1,:,j)=ventana_A2(1,:,j)/30;
    ventana_R2(1,:,j)=ventana_R2(1,:,j)/30;
    ventana_I2(1,:,j)=ventana_I2(1,:,j)/30;
    ventana_N2(1,:,j)=ventana_N2(1,:,j)/30;
    ventana_O2(1,:,j)=ventana_O2(1,:,j)/30;

end
%promedio de lasventana por canal
%%HASTA AQUÍ ESTAN LOS CANALES POR LETRA POR LA PALABRA CARINO

%%CHECANDO EL RUIDO CARINO
ventanas_C2_others=zeros(150,154,10); %30 ventanas por cada letra de 154 muestras, por los 10 canales
ventanas_A2_others=zeros(150,154,10); 
ventanas_R2_others=zeros(150,154,10); 
ventanas_I2_others=zeros(150,154,10); 
ventanas_N2_others=zeros(150,154,10);
ventanas_O2_others=zeros(150,154,10);

%Obtener ventanas de ruido
for j=1:10 %Numero de canal 
    aux=1; %numero de ventana
    for i=1:16:2400 
        ventanas_C2_others(aux,:,j)=s2(j,C2_others(i):C2_others(i)+tam_ven); %ventana letra C, canal 1
        ventanas_A2_others(aux,:,j)=s2(j,A2_others(i):A2_others(i)+tam_ven);
        ventanas_R2_others(aux,:,j)=s2(j,R2_others(i):R2_others(i)+tam_ven);
        ventanas_I2_others(aux,:,j)=s2(j,I2_others(i):I2_others(i)+tam_ven);
        ventanas_N2_others(aux,:,j)=s2(j,N2_others(i):N2_others(i)+tam_ven);
        ventanas_O2_others(aux,:,j)=s2(j,O2_others(i):O2_others(i)+tam_ven);

        aux=aux+1;
    end
end
%Promediación de ventanas por canal para el RUIDO
ventana_C2_others=zeros(1,154,10);
ventana_A2_others=zeros(1,154,10);
ventana_R2_others=zeros(1,154,10);
ventana_I2_others=zeros(1,154,10);
ventana_N2_others=zeros(1,154,10);
ventana_O2_others=zeros(1,154,10);

for j=1:10 %CANALES 
    for i=1:150 %VENTANAS
        ventana_C2_others(1,:,j)=ventana_C2_others(1,:,j)+ventanas_C2_others(i,:,j);
        ventana_A2_others(1,:,j)=ventana_A2_others(1,:,j)+ventanas_A2_others(i,:,j);
        ventana_R2_others(1,:,j)=ventana_R2_others(1,:,j)+ventanas_R2_others(i,:,j);
        ventana_I2_others(1,:,j)=ventana_I2_others(1,:,j)+ventanas_I2_others(i,:,j);
        ventana_N2_others(1,:,j)=ventana_N2_others(1,:,j)+ventanas_N2_others(i,:,j);
        ventana_O2_others(1,:,j)=ventana_O2_others(1,:,j)+ventanas_O2_others(i,:,j);

    end
    ventana_C2_others(1,:,j)=ventana_C2_others(1,:,j)/150;
    ventana_A2_others(1,:,j)=ventana_A2_others(1,:,j)/150;
    ventana_R2_others(1,:,j)=ventana_R2_others(1,:,j)/150;
    ventana_I2_others(1,:,j)=ventana_I2_others(1,:,j)/150;
    ventana_N2_others(1,:,j)=ventana_N2_others(1,:,j)/150;
    ventana_O2_others(1,:,j)=ventana_O2_others(1,:,j)/150;

end


%%PLOTEO DE TODAS LAS SEÑALES POR CANAL
figure (1) %%PARA CALOR
plot(ventana_C2(1,:,1))
hold on
plot(ventana_C2(1,:,2))
hold on
plot(ventana_C2(1,:,3))
hold on
plot(ventana_C2(1,:,4))
hold on
plot(ventana_C2(1,:,5))
hold on
plot(ventana_C2(1,:,6))
hold on
plot(ventana_C2(1,:,7))
hold on
plot(ventana_C2(1,:,8))
hold on
plot(ventana_C2(1,:,9))
hold on
plot(ventana_C2(1,:,10))
hold on


figure (2)
plot(ventana_C2_others(1,:,1))
hold on
plot(ventana_C2_others(1,:,2))
hold on
plot(ventana_C2_others(1,:,3))
hold on
plot(ventana_C2_others(1,:,4))
hold on
plot(ventana_C2_others(1,:,5))
hold on
plot(ventana_C2_others(1,:,6))
hold on
plot(ventana_C2_others(1,:,7))
hold on
plot(ventana_C2_others(1,:,8))
hold on
plot(ventana_C2_others(1,:,9))
hold on
plot(ventana_C2_others(1,:,10))
hold on



%%PALABRA SUSHI


%%PALABRA CARINO
figure (1) %%PARA CALOR
plot(ventana_C2(1,:,1))
hold on
plot(ventana_C2(1,:,2))
hold on
plot(ventana_C2(1,:,3))
hold on
plot(ventana_C2(1,:,4))
hold on
plot(ventana_C2(1,:,5))
hold on
plot(ventana_C2(1,:,6))
hold on
plot(ventana_C2(1,:,7))
hold on
plot(ventana_C2(1,:,8))
hold on
plot(ventana_C2(1,:,9))
hold on
plot(ventana_C2(1,:,10))
hold on


figure (2)
plot(ventana_C2_others(1,:,1))
hold on
plot(ventana_C2_others(1,:,2))
hold on
plot(ventana_C2_others(1,:,3))
hold on
plot(ventana_C2_others(1,:,4))
hold on
plot(ventana_C2_others(1,:,5))
hold on
plot(ventana_C2_others(1,:,6))
hold on
plot(ventana_C2_others(1,:,7))
hold on
plot(ventana_C2_others(1,:,8))
hold on
plot(ventana_C2_others(1,:,9))
hold on
plot(ventana_C2_others(1,:,10))
hold on



