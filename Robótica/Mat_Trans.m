function [MT] = Mat_Trans(Mat)
%UNTITLED Summary of this function goes here
%   Esta función devuelve una matriz transpuesta de transformación
    

    %Declaración de símbolos
    %syms q1 q2 q3 q4 q5 l1 l2 l3 l4 l5 l6 real
    
    %Se obtienen las dos matrices para transponer nuestra matriz
    R=Mat(1:3,1:3);
    d=Mat(1:3,4);
    
    RT=R';
    dT=RT*d*(-1);
    
    MT=[RT dT; 0 0 0 1];
    
    

    
end

