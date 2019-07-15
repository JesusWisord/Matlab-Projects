function [q1, q2, q3] = TrigonoInv(x, y, z)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    l1=25.5; l2=3;
    q2=z-l1;
    hipo2=((x)^2+(y)^2);
    
    if x==0
        q1=0
    else
        q1=atand(y/x);
    end
    
    q3=sqrt(hipo2/(l2)^2);
    
    
    
    fprintf('q1 = %.0f \nq2 = %.0f\nq3 = %.0f\n', q1, q2, q3)
    
    s= evalin('base','s');
    output=[q1;q2;q3;0;0;1];
    fprintf(s,'%s',mat2str(output))

end