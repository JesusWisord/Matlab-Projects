c1 = importdata('c1_1.mat');
c2 = importdata('c2_1.mat');

X=[c1;c2]

plot(c1(:,1),c1(:,2),'r*')
hold on
plot(c2(:,1),c2(:,2),'b*')

c1=[ones(100,1),c1];
c2=[ones(100,1),c2];

X_g=[c1;c2];

W_g=inv(X_g'*X_g)*X_g';
T=[ones(100,1);-1*ones(100,1)];

%Entrenamiento
W_g=W_g*[ones(100,1);-1*ones(100,1)];

% evaluar un espacio
x1=linspace(-8,10,100);
x2=linspace(-8,10,100);

[esp1,esp2]=meshgrid(x1,x2);
espacio=[reshape(esp1,10000,1),reshape(esp2,10000,1)];
espacio=[ones(10000,1),espacio];
y=espacio*W_g

clase=zeros(10000,1);
clase(y>0)=1;
clase(y<0)=-1;

figure(2),imagesc(x1,x2,reshape(clase,100,100));
hold on
plot(c1(:,1),c1(:,2),'r*');
hold on
plot(c2(:,1),c2(:,2),'b*');