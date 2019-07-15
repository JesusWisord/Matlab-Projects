clear all;
close all;
clc;
S1=[0 6 0 5 1 0 0 3 0;9 0 0 8 0 0 0 0 7;0 0 0 6 0 0 0 0 0;1 5 9 7 0 0 0 0 0;
    8 0 0 0 2 0 0 0 5;0 0 0 0 0 4 1 9 8;0 0 0 0 0 5 0 0 0;7 0 0 0 0 6 0 0 9;0 4 0 0 9 3 0 5 0];
T=150; a=0.95; L=30; tfin=0.001; tam=9; sub=3; v19=(1:9);
x=1; ini=[1,4,7]; w=1;
%Llenado de mi matriz, solucion primera solución
for n=1:sub
    j=1;
    for m=1:sub
         k=1; 
        for x2=x:x+2
            for j2=j:j+2
                v(k)=S1(x2,j2);
                k=k+1;
            end
        end
       d1 = setdiff(v19,v);
       p1=ceil(rand*size(d1,2));
       int=1; 
       while int==1
           p2=ceil(rand*size(d1,2));
           if(p1==p2)
               int=1;
           else 
               int=0;
           end
       end
       d2=d1;
       d2(p1)=d1(p2);
       d2(p2)=d1(p1);
       k2=1; 
       for x2=x:x+2
           for j2=j:j+2
               if(S1(x2,j2)==0) 
                   S2(x2,j2)=d2(k2);
                   k2=k2+1;
               else
                   S2(x2,j2)=S1(x2,j2);
               end
           end
       end
       j=j+3;
    end
    x=x+3;
end 

sum=0;
for x3=1:tam
    for j3=1:tam
        vr=S2(x3,:);
        vc=S2(:,x3);
        nr=find(vr==j3);
        nc=find(vc==j3);
        rr=length(nr);
        rc=length(nc);
        if (rr>1 | rc>1)
            sum=sum+1;
        end
    end
end 

while T>=tfin
    for q=1:L
        R=0; C=0;
        a1=ceil(rand*sub);
        a2=ceil(rand*sub);
        R=ini(a1); C=ini(a2);
        int=1; 
        while int==1
            a1=0+(2-0)*rand(1,1); a1=round(a1);
            a2=0+(2-0)*rand(1,1); a2=round(a2);
            if S1(R+a1,C+a2)==0
                R2=R+a1; C2=C+a2;
                while int==1
                    a3=0+(2-0)*rand(1,1); a3=round(a3);
                    a4=0+(2-0)*rand(1,1); a4=round(a4);
                    if (a3==a1 & a4==a2)
                        int=1;
                    elseif S1(R+a3,C+a4)==0
                        int=0;
                        R3=R+a3; C3=C+a4;
                    else  
                        int=1;
                    end
                end
            else 
                int=1;
            end
        end
        S3=S2;
        S3(R2,C2)=S2(R3,C3);
        S3(R3,C3)=S2(R2,C2);
        sum2=0;
        for x3=1:tam
            for j3=1:tam
                vr=S3(x3,:);
                vc=S3(:,x3);
                nr=find(vr==j3);
                nc=find(vc==j3);
                rr=length(nr);
                rc=length(nc);
                if (rr>1 | rc>1)
                    sum2=sum2+1;
                end
            end
        end 
         if sum2<=sum
             sum=sum2;
             S2=S3;
         else 
             REC=exp((sum-sum2)/T);
             if (REC>rand)
                 sum=sum2;
                 S2=S3;
             end
         end
    end
    T=T*a;
    total(w)=sum;
    w=w+1;
end
plot (total)
title ('Sudoku')