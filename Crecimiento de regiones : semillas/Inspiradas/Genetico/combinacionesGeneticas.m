sets = {[1 2 3 4], [1 2 3 4], [1 2 3 4], [1 2 3 4]};
[a b c d] = ndgrid(sets{:});
cartProd = [a(:) b(:) c(:) d(:)];

tamanoPoblacion=[5 10 15 20];
probabilidadMutacion=[0.05 0.1 0.25 0.4];
probabilidadCruza=[0.1 0.3 0.4 0.5];
numeroDeGeneraciones=[25 50 75 100];

Promedios_str=cell(256,3);
iteraciones=zeros(5,1);


for i=1:256
   vector= [cartProd(i,1), cartProd(i,2), cartProd(i,3), cartProd(i,4)];
   for j=1:5
      poblacion=tamanoPoblacion(vector(1));
      mutacion=probabilidadMutacion(vector(2));
      cruza=probabilidadCruza(vector(3));
      generaciones=numeroDeGeneraciones(vector(4));
      [iteraciones(j,1),iteraciones(j,2)]=algoritmoGenetico_2(poblacion, mutacion, cruza, generaciones);
   end
   promedio=mean(iteraciones);
   comb=mat2str(vector);
   desv_estand=std(iteraciones);
%    Promedios_str{i,1}=comb;
%    Promedios_str{i,2}=promedio(i,1);
%    Promedios_str{i,3}=desv_estand;
   Promedios(i,:)=promedio;
   Desvs(i,:)=desv_estand;
end

[m, a]=max(Promedios);
