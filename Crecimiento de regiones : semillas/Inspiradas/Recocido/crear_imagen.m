clear all
close all
clc

N=30;
x=linspace(-2.5,2.5,N);
y=linspace(-2.5,2.5,N);
m1=60;
s1=8;
m2=140;
s2=6;
m3=10;
s3=5;

%creacion de la imagen
im=zeros(N,N);
for k=1:size(im,1)
    for j=1:size(im,2)
        if(sqrt(x(k)^2+y(j)^2)<2)
            if(sqrt(x(k)^2+y(j)^2)>1)
                im(k,j)=m1+s1*randn(1);
            else
                 im(k,j)=m2+s2*randn(1);
            end
        else
            im(k,j)=m3+s3*randn(1);
        end
    end
end
figure(1),imagesc(x,y,im),colormap gray

 %es mi solucion inicial 
sol_in=randi(3,N);
figure, imagesc(sol_in);
colormap gray 