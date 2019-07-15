%Combinaciones posibles

sets = {[1 2 3 4], [1 2 3 4], [1 2 3 4], [1 2 3 4]};
[a b c d] = ndgrid(sets{:});
cartProd = [a(:) b(:) c(:) d(:)];

TemperaturaInicial= [1000, 500, 50, 5];
TemperaturaFinal= [1, 0.1, 0.01, 0.0001];
L= [20, 15, 10, 5];
Alpha= [.99, .98, .80, .75];
Promedios_str=cell(256,3);
iteraciones=zeros(5,1);


for i=1:256
   vector= [cartProd(i,1), cartProd(i,2), cartProd(i,3), cartProd(i,4)];
   for j=1:5
      t_inicial=TemperaturaInicial(vector(1));
      t_final=TemperaturaFinal(vector(2));
      l=L(vector(3));
      alfa=Alpha(vector(4));
      iteraciones(j)=recocidoSimulado(t_inicial, t_final, l, alfa);
   end
   promedio=mean(iteraciones);
   comb=mat2str(vector);
   desv_estand=std(iteraciones);
   Promedios_str{i,1}=comb;
   Promedios_str{i,2}=promedio;
   Promedios_str{i,3}=desv_estand;
   Promedios(i)=promedio;
   Desvs(i)=desv_estand;
end

[m, a]=min(Promedios);
Promedios(13)
Promedios_str(13,1)
