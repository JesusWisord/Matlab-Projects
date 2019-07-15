function [x,y,z] = MGDDH(q1,q2,q3,q4,q5)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    l1=23.5; 
    l2=1.5;
    l3=4.5;
    l4=8;
    l5=5;
    l6=16;
    
    A01=Matriz_DH(90+q1,l1,l2,0);
    A12=Matriz_DH(0,-q2,l3,90);
    A23=Matriz_DH(90,q3,0,90);
    A34=Matriz_DH(q4,l4,0,90);
    A45=Matriz_DH(70+q5,l5,l6,0);
    
    A05=A01*A12*A23*A34*A45;
    x=A05(1,4);
    y=A05(2,4);
    z=A05(3,4);
    
    s= evalin('base','s');
    output=[q1;q2;q3;q4;q5;0];
    fprintf(s,'%s',mat2str(output))
    %Arduino(output)
    
end

