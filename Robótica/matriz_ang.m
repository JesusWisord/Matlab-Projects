function [Mat] = matriz_ang(opc)
%UNTITLED2 Summary of this function goes here
%   Este programa devuelve la matriz de rotación euler zyz o RPY con zyx

    %Matriz de Euler con ángulos phi, theta y psi
%     phi = a
%     theta = b
%     psi = c
% La matriz será por un giro zyz
    syms a b c real
    Rot1=notacionMatriz('r','z',a);
    Rot2=notacionMatriz('r','y',b);
    Rot3=notacionMatriz('r','z',c);
    
    Mat_Eu=Rot1*Rot2*Rot3;
    
%     La matriz Roll-Pitch-Yaw con angulos alfa beta y gamma siendo los
%     siguientes:
%     a=alfa
%     b=beta
%     c=gamma
%   La matriz es con un giro zyx

    Rot1=notacionMatriz('r','z',a);
    Rot2=notacionMatriz('r','y',b);
    Rot3=notacionMatriz('r','x',c); 
    
    Mat_RPY=Rot1*Rot2*Rot3;
    
    if (opc == 'e')
        Mat=Mat_Eu;
    else
        Mat=Mat_RPY;
    end
    
    
end

