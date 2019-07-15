clear

raray = load('raray.txt');

X=raray;

plot(raray(raray(:,3)==1,1),raray(raray(:,3)==1,2),'r*')
hold on
plot(raray(raray(:,3)==2,1),raray(raray(:,3)==2,2),'g*')
plot(raray(raray(:,3)==3,1),raray(raray(:,3)==3,2),'b*')
plot(raray(raray(:,3)==4,1),raray(raray(:,3)==4,2),'c*')

T=zeros(400,4);

for i=1:400
    T(i,raray(i,3))=1;
end

X_g=[raray(:,1),raray(:,2)];
X_g=[ones(400,1),X_g];

W_g=inv(X_g'*X_g)*X_g';

%Entrenamiento
W_g=W_g*T;

% evaluar un espacio
x1=linspace(-10,15,100);
x2=linspace(-20,10,100);

[esp1,esp2]=meshgrid(x1,x2);
espacio=[reshape(esp1,10000,1),reshape(esp2,10000,1)];
espacio=[ones(10000,1),espacio];
y=W_g'*espacio';

[a,b]=max(y);
clase=zeros(10000,1);

for i=1:10000
    clase(i)=b(i);
end

figure(2),imagesc(x1,x2,reshape(clase,100,100));
hold on
plot(raray(raray(:,3)==1,1),raray(raray(:,3)==1,2),'r*')
plot(raray(raray(:,3)==2,1),raray(raray(:,3)==2,2),'g*')
plot(raray(raray(:,3)==3,1),raray(raray(:,3)==3,2),'b*')
plot(raray(raray(:,3)==4,1),raray(raray(:,3)==4,2),'c*')