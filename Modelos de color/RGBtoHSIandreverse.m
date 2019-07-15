I=imread('flowers1.ppm');
figure(10);
imshow(I)
I=im2double(I);
IR=I(:,:,1);
IG=I(:,:,2);
IB=I(:,:,3);
[m,n]=size(IR);
Theta=zeros(m,n);

for i=1:m
    for j=1:n
        acu=((IR(i,j)-IG(i,j))^2 +(IR(i,j)-IB(i,j))*(IG(i,j)-IB(i,j)))^(0.5)+0.00000001;%El 0.00000001 es por los casos en que quedaria una division entre 0 lo cual no esta definido y por ende se opto que quedara como una division entre un numero muy peque?o en estos casos
       Theta(i,j)=acosd(((0.5)*((IR(i,j)-IG(i,j))+(IR(i,j)-IB(i,j))))/acu);
       if(IB(i,j)<=IG(i,j))
           H(i,j)=Theta(i,j);
       else
            H(i,j)=360-Theta(i,j);
       end
          In(i,j)=(1/3)*(IR(i,j)+IG(i,j)+IB(i,j));
    end
end
H=H/360;
S=1-(3./(IR+IG+IB+0.00000001)).*min(min(IR,IG),IB);%+0.00000001 el agregar esto en la H y en la S evita que aparezcan puntos negros en la imagen final
HSI=cat(3,H,S,In);

figure(1)
imshow(IR)
figure(2)
imshow(IG)
figure(3)
imshow(IB)
figure(4)
imshow(H)
figure(5)
imshow(S)
figure(7)
imshow(In)
%HSI=uint8(HSI);
figure(8), imshow(HSI),title('HSI Image');
%HSI-->RGB
In=histeq(In);
H=H*360;%Normaliza nuestra H para que quede nuevamente en valores que van desde 0 hasta 360 y no de 0 a 1
H2=H;
for i=1:m
    for j=1:n
        if(0<H2(i,j)&&H2(i,j)<=120)
            B(i,j)=In(i,j)*(1-S(i,j));
            R(i,j)=In(i,j)*(1+((S(i,j)*cosd(H2(i,j)))/cosd(60-H2(i,j))));
            G(i,j)=3*In(i,j)-(R(i,j)+B(i,j));
        end
        if(120<H2(i,j)&&H2(i,j)<=240);
            H2(i,j)=H2(i,j)-120;
            R(i,j)=In(i,j)*(1-S(i,j));
            G(i,j)=In(i,j)*(1+((S(i,j)*cosd(H2(i,j)))/cosd(60-H2(i,j))));
            B(i,j)=3*In(i,j)-(R(i,j)+G(i,j));
        end
        if(240<H2(i,j)&&H2(i,j)<=360);
            H2(i,j)=H2(i,j)-240;
            G(i,j)=In(i,j)*(1-S(i,j));
            B(i,j)=In(i,j)*(1+((S(i,j)*cosd(H2(i,j)))/cosd(60-H2(i,j))));
            R(i,j)=3*In(i,j)-(G(i,j)+B(i,j));
        end
    end
end
RGB=cat(3,R,G,B);
RGB=max(min(RGB,1),0);
figure(9), imshow(RGB),title('RGBDenuevo');
