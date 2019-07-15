N=3;
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
figure(4) 
imagesc(x,y,im)
colormap gray
title('Imagen ideal')
xlabel('Distancia')
ylabel('Distancia')
%% Hiperparametros 
total=0;
To=200;
Tf=0.001;
alfa=0.99;
cont2=0;
L=300;
cont=1;
%% Solucion inicial 
variables=3;
sol_in=randi(variables,N,N);
figure(5)
imagesc(x,y,sol_in)
colormap gray
title('Imagen de solucion inicial')
xlabel('Distancia')
ylabel('Distancia')
%% Fitness de la solucion inicial 
for i=1:variables
    mascara=im(sol_in==i)';
    mmas=sol_in==i
    vec_ntd(i)=size(mascara,2);
    if i==1
        mascaraf=mascara;
    end
    if i>1
      mascaraf=[mascaraf,mascara];
    end
end
vec_valor=mascaraf;
in=0;
 fin=0;
for i=1:variables
    fin=fin+vec_ntd(i);
    prom_to(i)=mean(vec_valor(in+1:fin));
    var_to(i)=var(vec_valor(in+1:fin));
    in=in+vec_ntd(i);
end
for i=1:N
   for  j=1:N
      if i>1 && i<N && j>1 && j<N  
       if sol_in(i,j)~=sol_in(i+1,j)||sol_in(i,j)~=sol_in(i+1,j+1)||sol_in(i,j)~=sol_in(i-1,j)|| sol_in(i,j)~=sol_in(i-1,j-1) 
            cont2=cont2+1;
       end
      end 
      if i==1 && j<N 
          if sol_in(i,j)~=sol_in(i+1,j) || sol_in(i,j)~=sol_in(i+1,j+1)
              cont2=cont2+1;
          end  
      end
      if i==N && j>1 && i>1
          if sol_in(i,j)~=sol_in(i-1,j)|| sol_in(i,j)~=sol_in(i-1,j-1)
              cont2=cont2+1;
          end 
      end
    end
end
% fitness=sum(var_to)/var(prom_to)+sum(var_to)/cont2;
fitness=sum(var_to)/var(prom_to);
cont2=0;
cont=2; 
vec_fit(1)=fitness;
To=To*10;
sol_ini=sol_in;
while To>Tf
for z=1:L
    %% Obtener a vecino 
aleatoriox=randi(N);
aleatorioy=randi(N);
sol_vec=sol_in;
sol_vec(aleatorioy,aleatoriox)=randi(variables);

%% Fitness vecino 

 for i=1:variables
    mascara=im(sol_vec==i)';
    vec_ntd(i)=size(mascara,2);
    if i==1
        mascaraf=mascara;
    end
    if i>1
      mascaraf=[mascaraf,mascara];
    end
end
vec_valor=mascaraf;
in=0;
 fin=0;
for i=1:variables
    fin=fin+vec_ntd(i);
    prom_to(i)=mean(vec_valor(in+1:fin));
    var_to(i)=var(vec_valor(in+1:fin));
    in=in+vec_ntd(i);    
end
fitnessvec=sum(var_to)/var(prom_to);
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
for i=1:N
   for  j=1:N
      if i>1 && i<N && j>1 && j<N  
       if sol_vec(i,j)~=sol_vec(i+1,j)||sol_vec(i,j)~=sol_vec(i+1,j+1)||sol_vec(i,j)~=sol_vec(i-1,j)|| sol_vec(i,j)~=sol_vec(i-1,j-1) 
            cont2=cont2+1;
       end
      end 
      if i==1 && j<N 
          if sol_vec(i,j)~=sol_vec(i+1,j) || sol_vec(i,j)~=sol_vec(i+1,j+1)
              cont2=cont2+1;
          end  
      end
      if i==N && j>1 && i>1
          if sol_vec(i,j)~=sol_vec(i-1,j)|| sol_vec(i,j)~=sol_vec(i-1,j-1)
              cont2=cont2+1;
          end 
      end
    end
end
if cont2>2*fitness
fitness=fitness+sum(var_to)/cont2;
end
end


figure(6)
imagesc(x,y,sol_ini)
colormap gray
title('Imagen clasificada')
xlabel('Distancia')
ylabel('Distancia')
figure(7)
plot(fitness,'.')
title('Comportamiento de Fitness')
xlabel('Fitness')
ylabel('Temperatura')