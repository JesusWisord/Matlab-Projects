clear all
close all
N=30;
x=linspace(3,-3,N);
y=linspace(3,-3,N);
s1=8;
s2=15;
s3=25;
med1=280;
med2=100;
med3=5;

%% Creacion de la imagen 
im=rand(N,N);
for k=1: size(im,1)
    for i=1:size(im,2)
        if (sqrt(x(k)^2+y(i)^2)<2)
            if (sqrt(x(k)^2+y(i)^2)>1)
                im(k,i)=med1+s1*rand(1);
            else
                im(k,i)=med2+s2*rand(1);
            end
        else
            im(k,i)=med3+s3*rand(1);
        end
    end
end
figure(1) 
imagesc(x,y,im)
colormap gray
title('Imagen a clasificar con ruido gaussiano')
xlabel('Distancia [cm]')
ylabel('Distancia [cm]')
%% Hiperparametros 
total=0;
% To=300;
Tf=0.001;
alfa=0.99;
cont2=0;
L=300;
cont=1;
%% Solucion inicial 
variables=3;
sol_in=randi(variables,N,N);
%% Fitness de la solucion inicial
c1=1;
c2=0;
for i=1:variables
    mascara=im(sol_in==i)';
    vec_ntd(i)=size(mascara,2);
    m1=sol_in==i;
    for d=1:N
        for g=1:N
            if m1(d,g)==1
                xim(c1)=d;
                yim(c1)=g;   
                c1=c1+1;
            end
        end 
    end

c1=1;
    if i==1
        mascaraf=mascara;
        xima=xim;
        yima=yim;
    end
    if i>1
      mascaraf=[mascaraf,mascara];
      xima=[xima,xim];
      yima=[yima,yim];
    end
end

vec_valor=mascaraf;
in=0;
 fin=0;
 movii=1;
 movif=0;
for i=1:variables
%     movif=fin+vecx(i);
    fin=fin+vec_ntd(i);
    prom_to(i)=mean(vec_valor(in+1:fin));
    var_to(i)=var(vec_valor(in+1:fin));
  
    for j=in+1:1:fin
        distancia(j)=sqrt(([xima(j),yima(j)]-[round(N/2),round(N/2)])*([xima(j),yima(j)]-[round(N/2),round(N/2)])');
    end
      in=in+vec_ntd(i);
%     movii=vecx(i);
end
in=0;
fin=0;
for i=1:variables 
    fin=fin+vec_ntd(i);
    prom_td(i)=mean(distancia(in+1:fin));
end 
fitness=sum(var_to)/var(prom_to)+var(prom_td);

cont=2;
vec_fit(1)=fitness;
To=fitness*7;
% To=10000000000
while To>Tf
for z=1:L
    %% Obtener a vecino 
aleatoriox=randi(N);
aleatorioy=randi(N);
sol_vec=sol_in;
sol_vec(aleatoriox,aleatorioy)=randi(variables);
%% Fitness vecino 

c1=1;
c2=0;
for i=1:variables
    mascara=im(sol_vec==i)';
    vec_ntd(i)=size(mascara,2);
    m1=sol_vec==i;
    for d=1:N
        for g=1:N
            if m1(d,g)==1
                xim(c1)=d;
                yim(c1)=g;   
                c1=c1+1;
            end
        end 
    end

c1=1;
    if i==1
        mascaraf=mascara;
        xima=xim;
        yima=yim;
    end
    if i>1
      mascaraf=[mascaraf,mascara];
      xima=[xima,xim];
      yima=[yima,yim];
    end
end

vec_valor=mascaraf;
in=0;
 fin=0;
 movii=1;
 movif=0;
for i=1:variables
%     movif=fin+vecx(i);
    fin=fin+vec_ntd(i);
    prom_to(i)=mean(vec_valor(in+1:fin));
    var_to(i)=var(vec_valor(in+1:fin));
  
    for j=in+1:1:fin
        distancia(j)=sqrt(([xima(j),yima(j)]-[round(N/2),round(N/2)])*([xima(j),yima(j)]-[round(N/2),round(N/2)])');
    end
      in=in+vec_ntd(i);
%     movii=vecx(i);
end
in=0;
fin=0;
for i=1:variables 
    fin=fin+vec_ntd(i);
    prom_td(i)=mean(distancia(in+1:fin));
end 
fitnessvec=sum(var_to)/var(prom_to)+var(prom_td);
if fitnessvec<fitness
    sol_in=sol_vec;
    fitness=fitnessvec;
else
    if exp((fitness-fitnessvec)/To)> rand(1)
        sol_in=sol_vec;
        fitness=fitnessvec;
    end
end
 vec_fit(cont)=fitness;
 cont=cont+1;
end
To=To*alfa;
% figure(2)
% imagesc(sol_in)
% pause(0.001)
figure (2), imagesc(sol_in);
colormap gray 
end
figure(3)
imagesc(x,y,sol_in)
colormap gray
title('Imagen a clasificada')
xlabel('Distancia [cm]')
ylabel('Distancia [cm]')
figure(4)
plot(vec_fit,'.')
title('Fitness a través del tiempo')
xlabel('Iteraciones')
ylabel('Valor del Fitness')