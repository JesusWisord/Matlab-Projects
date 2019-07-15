%Calcula los cruces por cero. 

load Peso1.txt
load Peso2.txt
load Peso3.txt
load Peso4.txt
load pesoMAx.txt

Biceps1=Peso1(:,1);
Triceps1=Peso1(:,2);

Biceps2=Peso2(:,1);
Triceps2=Peso2(:,2);

Biceps3=Peso3(:,1);
Triceps3=Peso3(:,2);

Biceps4=Peso4(:,1);
Triceps4=Peso4(:,2);

Biceps5=pesoMAx(:,1);
Triceps5=pesoMAx(:,2);

meanfreq([Biceps1],Fs);
meanfreq(Triceps1,Fs);

medfreq([Biceps1],Fs);
medfreq([Triceps1],Fs);

cruces=0;

for i=1:size(Biceps1,1)-1
   aux=Biceps1(i)*Biceps1(i+1);
   if aux<0
       cruces=cruces+1;
   end
end

cruces2=0;

for i=1:size(Triceps1,1)-1
   aux=Triceps1(i)*Triceps1(i+1);
   if aux<0
       cruces2=cruces2+1;
   end
end

crucesPorCeroBiceps(1)=cruces;
crucesPorCeroTriceps(1)=cruces2;

cruces=0;

for i=1:size(Biceps2,1)-1
   aux=Biceps2(i)*Biceps2(i+1);
   if aux<0
       cruces=cruces+1;
   end
end

cruces2=0;

for i=1:size(Triceps2,1)-1
   aux=Triceps2(i)*Triceps2(i+1);
   if aux<0
       cruces2=cruces2+1;
   end
end

crucesPorCeroBiceps(2)=cruces;
crucesPorCeroTriceps(2)=cruces2;

cruces=0;

for i=1:size(Biceps3,1)-1
   aux=Biceps3(i)*Biceps3(i+1);
   if aux<0
       cruces=cruces+1;
   end
end

cruces2=0;

for i=1:size(Triceps3,1)-1
   aux=Triceps3(i)*Triceps3(i+1);
   if aux<0
       cruces2=cruces2+1;
   end
end

crucesPorCeroBiceps(3)=cruces;
crucesPorCeroTriceps(3)=cruces2;

cruces=0;

for i=1:size(Biceps4,1)-1
   aux=Biceps4(i)*Biceps4(i+1);
   if aux<0
       cruces=cruces+1;
   end
end

cruces2=0;

for i=1:size(Triceps4,1)-1
   aux=Triceps4(i)*Triceps4(i+1);
   if aux<0
       cruces2=cruces2+1;
   end
end

crucesPorCeroBiceps(4)=cruces;
crucesPorCeroTriceps(4)=cruces2;

cruces=0;

for i=1:size(Biceps5,1)-1
   aux=Biceps5(i)*Biceps5(i+1);
   if aux<0
       cruces=cruces+1;
   end
end

cruces2=0;

for i=1:size(Triceps5,1)-1
   aux=Triceps5(i)*Triceps5(i+1);
   if aux<0
       cruces2=cruces2+1;
   end
end

crucesPorCeroBiceps(5)=cruces;
crucesPorCeroTriceps(5)=cruces2;
