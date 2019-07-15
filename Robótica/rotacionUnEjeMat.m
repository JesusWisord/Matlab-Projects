function [ mat ] = rotacionUnEje( eje, ang )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
coseno=sym(cos(ang));
seno=sym(sin(ang));


if (eje == 'z' || eje == 'Z')
r_Z = [coseno, -seno, 0; seno coseno 0; 0 0 1];
rot=r_Z;
end

if (eje == 'x' || eje == 'X')
r_X = [1,0,0; 0 cos(ang) -sin(ang); 0, sin(ang), cos(ang)];
rot=r_X;
end

if (eje == 'y' || eje == 'Y')
r_Y = [cos(ang), 0, sin(ang); 0 1 0; -sin(ang) 0 cos(ang)];
rot=r_Y;
end

mat=rot;

end

