function [ pos ] = rotacionUnEje( eje, ang, pos )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
coseno=sym(cosd(ang));
seno=sym(sind(ang));


if (eje == 'z' || eje == 'Z')
r_Z = [coseno, -seno, 0; seno coseno 0; 0 0 1];
pos = r_Z * pos';
end

if (eje == 'x' || eje == 'X')
r_X = [1,0,0; 0 cosd(ang) -sind(ang); 0, sind(ang), cosd(ang)];
pos = r_X * pos';
end

if (eje == 'y' || eje == 'Y')
r_Y = [cosd(ang), 0, sind(ang); 0 1 0; -sind(ang) 0 cosd(ang)];
pos = r_Y * pos';
end

pretty(pos)

end

