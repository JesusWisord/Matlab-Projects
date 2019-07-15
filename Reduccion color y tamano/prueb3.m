I=imread('tarea1.jpg');
[ml,nl]=size(I); %Obtenemos el tamano en dos variables
I2=double(I);
[ml,nl]=size(I);
m1=zeros(ml,nl, 'uint8');
m2=m1;
m3=m1;
m4=m1;
m5=m1;
m6=m1;

for j=1:nl;
    for i=1:ml;
    
        if I(i,j)>=128 & I(i,j)<255;
            
            if mod(I2(i,j),2)==0
               m1(i,j)=I2(i,j)+1;
            else
               m1(i,j)=I2(i,j);
            end
            
            x=0;
            for k=3:-1:0;
                if mod(I(i,j),2.^2)==x;
                   m2(i,j)=I(i,j)+(k);
                   break;
                end
                x=x+1;
            end
            if x==2
                   m2(i,j)=m1(i,j);
            end
        end
        
        if I(i,j)==255
            m1(i,j)=I2(i,j);
            m2(i,j)=I2(i,j);
        end
       
        if I(i,j)<=127 & I(i,j)>0;
            
           if mod(I2(i,j),2)~=0
            m1(i,j)=I2(i,j)-1; 
           else
             m1(i,j)=I2(i,j);
           end
           
           if mod(m1(i,j),2.^2)~=0
               m2(i,j)=m1(i,j)-2;
           else
               m2(i,j)=m1(i,j);
           end
           
        end
       
    end
end

figure (1), imshow(m2);
figure (2), imshow(I);
figure (3), imhist(m2);
figure (4), imhist(m1);
figure (5), imhist(I);

