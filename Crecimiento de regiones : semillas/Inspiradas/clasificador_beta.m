function [Clasificador, PS, M, Sigma] = clasificador(Clase, DIMENSIONES, K_VAR, espacio)

    Tamano=size(Clase,1);
    for i=1:K_VAR
        M(i,:)=Clase(randi(Tamano),1:2);
        Sigma(:,:,i)=eye(DIMENSIONES);
        Pi_var(i)=1/K_VAR;
    end
    
    for z=1
       
        for i=1:Tamano
            for j=1:K_VAR
                PS(i,j)=Pi_var(j)*(((1/(2*pi)))*(1/sqrt(det(Sigma(:,:,j))))*exp(-0.5*((Clase(i,:)-M(j,:))*((Sigma(:,:,j))^-1)*(Clase(i,:)-M(j,:))')));
            end
        end
        PS=PS./sum(PS,2);

%         for i=1:K_VAR
%             M(i,:)=sum(PS(:,i).*Clase(:,i))/sum(PS(:,i));
%             Sigma(:,:,i)=((PS.*(Clase-M(i,:)))'*(PS.*(Clase-M(i,:))))./sum(PS);
%             Pi_var(:)=mean(PS)';
%         end 
    end
%     
    condicional=zeros(size(espacio,1),1);
%     
%     for i=1:size(espacio)
%         for j=1:K_VAR
%         condicional(i)=condicional(i)+(Pi_var(j)*((1/(2*pi))*(1/sqrt(det(Sigma(:,:,j))))*exp(-0.5*((espacio(i,:)-M(j,:))*((Sigma(:,:,j))^-1)*(espacio(i,:)-M(j,:))'))));
%         end
%     end
    
    Clasificador=condicional;
    %Clasificador_alfa=Clasificador_alfa./sum(Clasificador_alfa)

end

