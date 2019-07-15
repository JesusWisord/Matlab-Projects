function [x, y, z] = Trigono(q1, q2, q3)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    l1=25.5; l2=3;
    z=l1-q2;
    hipo=sqrt((l2)^2+(q3)^2);
    ang=atand(q3/l2);
    ang_1=ang+q1;
    x=hipo*cosd(ang_1);
    y=(hipo*sind(ang_1))+l2;
    
    x1=l2*cosd(q1+90);
    y1=l2*sind(q1+90);
    
    x2=q3*cosd(q1);
    y2=q3*sind(q1);
    
    x=x1+x2;
    y=y1+y2;
    
    s= evalin('base','s');
    output=[q1;q2;q3;0;0;1];
    fprintf(s,'%s',mat2str(output))
    
    %fprintf('x = %.0f \ny = %.0f\nz = %.0f\n', x, y, z)

end

