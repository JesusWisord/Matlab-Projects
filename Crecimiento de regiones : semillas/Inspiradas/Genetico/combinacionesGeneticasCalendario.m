sets = {[1 2 3 4], [1 2 3 4], [1 2 3 4]};
[a b c] = ndgrid(sets{:});
cartProd = [a(:) b(:) c(:)];

tamanoPoblacion=[50];
probabilidadMutacion=[0.05 0.2 0.5 0.75];
probabilidadCruza=[0.1 0.3 0.5 0.7];
numeroDeGeneraciones=[25 75 150 200];

Promedios_str=cell(64,3);
iteraciones=zeros(5,1);


for i=1:256
   vector= [cartProd(i,1), cartProd(i,2), cartProd(i,3)];
   for j=1:5
      mutacion=probabilidadMutacion(vector(1));
      cruza=probabilidadCruza(vector(2));
      generaciones=numeroDeGeneraciones(vector(3));
      [iteraciones(j)]=Calendario_func(50, mutacion, cruza, generaciones);
   end
   promedio=mean(iteraciones);
   comb=mat2str(vector);
   desv_estand=std(iteraciones);
   Promedios_str{i,1}=comb;
   Promedios_str{i,2}=promedio;
   Promedios_str{i,3}=desv_estand;
   Promedios(i,:)=promedio;
   Desvs(i,:)=desv_estand;
end

[m, a]=min(Promedios);
