function [H] = notacionMatriz(opc, eje, valor)
%
%   Este programa devuelve una matriz de transformación para una rotación o
%   una traslación

if opc == 'r' || opc == 'R'
    R = rotacionUnEjeMat(eje, valor);
    d = zeros(3,1);
end

if opc == 't' || opc == 'T'
    R = diag([1,1,1]);
    switch (eje)
        case 'x'
            d = [valor; 0; 0];
        case 'X'
            d = [valor; 0; 0];
        case 'y'
            d = [0; valor; 0];
        case 'Y'
            d = [0; valor; 0];
        case 'z'
            d = [0; 0; valor];
        case 'Z'
            d = [0; 0; valor];
    end
end

t= zeros(1,3);
e=1;

H=[R d; t e]

end

