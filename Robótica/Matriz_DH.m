function [ Mat ] = Matriz_DH(theta, d, a, alfa)
%Matriz_DH
%   Recibe como parámetros theta d a y alfa de la tabla de DH para crear
%   una de las matrices. Esta función debe llamarse una por cada matriz

    sym_theta=isa(theta, 'sym');
    sym_alfa=isa(alfa, 'sym');
    
    if ~sym_theta 
        cosenotheta=cosd(theta);
        senotheta=sind(theta);
    else
        cosenotheta=cos(theta);
        senotheta=sin(theta);
    end
    
    if ~sym_alfa 
        cosenoalfa=cosd(alfa);
        senoalfa=sind(alfa);
    else
        cosenoalfa=cos(alfa);
        senoalfa=sin(alfa);
    end
    
    
    
    Mat=[ cosenotheta -cosenoalfa*senotheta senoalfa*senotheta a*cosenotheta;
        senotheta cosenoalfa*cosenotheta -senoalfa*cosenotheta a*senotheta;
        0 senoalfa cosenoalfa d;
        0 0 0 1];
    
    Mat=simp_Mat(Mat,theta, d, a, alfa);
    
end

