function [Mat] = simp_Mat(Mat,theta,d, a, alfa)
%UNTITLED4 Summary of this function goes here
%   Esta función devuelve una matriz simplificada

    sym_theta=isa(theta, 'sym');
    sym_alfa=isa(alfa, 'sym');
    
    
    if sym_theta
        theta_r=theta-symvar(theta);
        theta=theta-theta_r;
        if theta_r ~= 0
            Mat(1,1)=cos(theta)*cosd(theta_r)+(-1)*(sind(theta_r))*sin(theta);
            Mat(2,1)=(sin(theta)*cosd(theta_r)+cos(theta)*sind(theta_r))
            Mat(1,3)=(Mat(2,1))*sind(alfa);
            Mat(2,3)=Mat(1,1)*(sind(alfa));
            Mat(1,4)=a*Mat(1,1);
            Mat(2,4)=a*Mat(2,1);
            Mat(1,2)=(-1)*cosd(alfa)*Mat(2,1);
            Mat(2,2)=cosd(alfa)*Mat(1,1);
        end
    end

end

