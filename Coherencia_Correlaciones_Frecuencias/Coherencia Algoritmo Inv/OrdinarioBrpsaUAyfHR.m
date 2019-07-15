%%%% BPRSA de la frecuencia cardiaca fetal 
%% Paso 1
load ('FHR.dat');
load ('UA.dat');
tdatos=size(UA,1);
cont=1;
muestras=1:450;
for i=1:tdatos
    if i>1
        if UA(i)>UA(i-1)
            pa(cont)=i;%% posiciones de los puntos de anclaje 
        cont=cont+1;
        end
    end 
end 
cont=1;
for i=1:tdatos
    if i==pa(cont)
        vecpa(i)=UA(i);
        vecpafv(i)=1;
        if cont<size(pa,2)
        cont=cont+1;
        end
    else
        vecpa(i)=0;
        vecpafv(i)=0;
    end
end
figure (1)
plot(muestras,UA)
hold on
plot(muestras,vecpa,'*')
xlabel('Muestras','FontName','Arial','FontSize', 14);
ylabel('Magnitud ','FontName','Arial','FontSize', 14);
title('Actividad Uterina','FontName','Arial','FontSize', 20);
grid on
%% Traspolada a la Frecuencia Cardiaca Fetal
mini=min(FHR);
for i=1:tdatos
    if vecpafv(i)==1
        vecpat(i)=FHR(i);
    else 
        vecpat(i)=mini;
    end
end
figure(2)
plot(muestras,FHR)
hold on
plot(muestras,vecpat,'*')
xlabel('Muestras','FontName','Arial','FontSize', 14);
ylabel('Amplitud µv (micro volts)','FontName','Arial','FontSize', 14);
title('Frecuencia Cardiaca Fetal','FontName','Arial','FontSize', 20);
grid on
%% Paso 2 Ventanas
M=size(pa,2);
L=50;%%% +- el tamaño de las ventanas a crear
v=0;
for i=1:tdatos
    if vecpafv(i)==1
        if i<=L
           dat=L+1-i;
           met=zeros(1,dat);
 
           matvp=(FHR(i-(L-dat):(i+(L-1))))';
           matvp=[met,matvp];
        else
            if i+L>tdatos
                dat=(i+L)-tdatos;
              met=zeros(1,dat);
             matvp=(FHR(i-L:i+L-dat-1))';
             matvp=[matvp,met];
            else
                matvp=(FHR(i-L:i+L-1))';
            end
        end
         v=v+1;
        if v<=M
            if v==1
                matv=matvp;
               
            else
                matv=[matv;matvp];
            end
        end
    end
end
%% IMPRESION DE TODAS LAS VENTANAS
figure(3)
x=-L:L-1;
for i=1:M
    hold on
     plot (x,matv(i,:))
     grid on
     hold on
end
xlabel('Ventana -50 a 50 muestras','FontName','Arial','FontSize', 14);
ylabel('Amplitud µv (micro volts)','FontName','Arial','FontSize', 14);
title('Frecuencia Cardiaca Fetal Ventanas','FontName','Arial','FontSize', 20);
grid on
%% Paso tres 
for i=1:size(matv,2)%%% Se obtiene el promedio de las ventanas
    BPRSAfcf(i)=mean(matv(:,i));%%% BPRSA de la frecuencia cardiaca fetal
end
figure(4)

x=-L:L-1;
y=min(BPRSAfcf):max(BPRSAfcf);
x1=zeros(1,size(y,2));
plot(x,BPRSAfcf);
hold on
plot(x1,y,'--r')
xlabel('Ventana -50 a 50 muestras','FontName','Arial','FontSize', 14);
title('Promedio BPRSA de la Frecuencia Cardiaca Fetal','FontName','Arial','FontSize', 20);
grid on
%% BPRSA de la actividad uterina 
%% Paso 1
clear pa 
clear vecpa vecpafv matv matvp vecpat x x1 y 
tdatos=size(FHR,1);
cont=1;
muestras=1:450;
for i=1:tdatos
    if i>1
        if FHR(i)>FHR(i-1)
            pa(cont)=i;%% posiciones de los puntos de anclaje 
        cont=cont+1;
        end
    end 
end 
cont=1;
for i=1:tdatos
    if i==pa(cont)
        vecpa(i)=FHR(i);
        vecpafv(i)=1;
        if cont<size(pa,2)
        cont=cont+1;
        end
    else
        vecpa(i)=0;
        vecpafv(i)=0;
    end
end
figure (5)
plot(muestras,FHR)
hold on
plot(muestras,vecpa,'*')
xlabel('Muestras','FontName','Arial','FontSize', 14);
ylabel('Magnitud ','FontName','Arial','FontSize', 14);
title('Frecuencia Cardiaca Fetal','FontName','Arial','FontSize', 20);
grid on
%% Traspolada a la Frecuencia Cardiaca Fetal
mini=min(UA);
for i=1:tdatos
    if vecpafv(i)==1
        vecpat(i)=UA(i);
    else 
        vecpat(i)=mini;
    end
end
figure(6)
plot(muestras,UA)
hold on
plot(muestras,vecpat,'*')
xlabel('Muestras','FontName','Arial','FontSize', 14);
ylabel('Amplitud µv (micro volts)','FontName','Arial','FontSize', 14);
title('Actividad Uterina','FontName','Arial','FontSize', 20);
grid on
%% Paso 2 Ventanas
M=size(pa,2);
L=50;%%% +- el tamaño de las ventanas a crear
v=0;
for i=1:tdatos
    if vecpafv(i)==1
        if i<=L
           dat=L+1-i;
           met=zeros(1,dat);
 
           matvp=(UA(i-(L-dat):(i+(L-1))))';
           matvp=[met,matvp];
        else
            if i+L>tdatos
                dat=(i+L)-tdatos;
              met=zeros(1,dat);
             matvp=(UA(i-L:i+L-dat-1))';
             matvp=[matvp,met];
            else
                matvp=(UA(i-L:i+L-1))';
            end
        end
         v=v+1;
        if v<=M
            if v==1
                matv=matvp;
               
            else
                matv=[matv;matvp];
            end
        end
    end
end
%% IMPRESION DE TODAS LAS VENTANAS
figure(7)
x=-L:L-1;
for i=1:M
    hold on
     plot (x,matv(i,:))
     grid on
     hold on
end
xlabel('Ventana -50 a 50 muestras','FontName','Arial','FontSize', 14);
ylabel('Amplitud µv (micro volts)','FontName','Arial','FontSize', 14);
title('Actividad Uterina Ventanas','FontName','Arial','FontSize', 20);
grid on
%% Paso tres 
for i=1:size(matv,2)%%% Se obtiene el promedio de las ventanas
    BPRSAua(i)=mean(matv(:,i));%%% BPRSA de la frecuencia cardiaca fetal
end
figure(8)
x=-L:L-1;
y=min(BPRSAua):max(BPRSAua);
x1=zeros(1,size(y,2));
plot(x,BPRSAua);
hold on
plot(x1,y,'--r')
xlabel('Ventana -50 a 50 muestras','FontName','Arial','FontSize', 14);
title('Promedio BPRSA de la Actividad Uterina ','FontName','Arial','FontSize', 20);
grid on
%% Coherencia de ambas BPRSA
fs=0.5;
[Cxy,f] = mscohere(BPRSAfcf,BPRSAua,hamming(100),[],[],fs);
figure(9)%%% Una forma de impresion 
plot(f,Cxy)
xlabel('Frecuencia Hz (Hertz)','FontName','Arial','FontSize', 14);
ylabel('Magnitud ','FontName','Arial','FontSize', 14);
title('Magnitude-Squared  Coherence BPRSA','FontName','Arial','FontSize', 20);