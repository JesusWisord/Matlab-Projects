function [Jacob, J1, J2, J3, J4, J5] = Propag()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    syms q1 l1 l2 q2 l3 q3 q4 l4 q5 l5 l6 real
    A01=Matriz_DH(90+q1,l1,l2,0);
    A12=Matriz_DH(0,q2,-l2-l3,90);
    A23=Matriz_DH(90,q3,0,-90);
    A34=Matriz_DH(q4,l4,0,90);
    A45=Matriz_DH(90+q5,l5,l6,0);
    
    A00=diag([1 1 1 1])
    A02=A01*A12;
    A03=A02*A23;
    A04=A03*A34;
    A05=A04*A45;
    
    z00=[0;0;1];
    z01=A01(1:3,3);
    z02=A02(1:3,3);
    z03=A03(1:3,3);
    z04=A04(1:3,3);
    z05=A05(1:3,3);
    
    P05=A05(1:3,4)-A00(1:3,4);
    P15=A05(1:3,4)-A01(1:3,4);
    P25=A05(1:3,4)-A02(1:3,4);
    P35=A05(1:3,4)-A03(1:3,4);
    P45=A05(1:3,4)-A04(1:3,4);
    
    prod=cross(z00,P05)
    J1=[prod;z00];
    J2=[z01;0;0;0];
    J3=[z02;0;0;0];
    prod=cross(z03,P35)
    J4=[prod;z03];
    prod=cross(z04,P45)
    J5=[prod;z04];
    
    Jacob=[J1 J2 J3 J4 J5]
    
end

