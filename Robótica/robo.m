%Matrices de DH

syms q1 l1 l2 q2 l3 q3 q4 l4 q5 l5 l6 real
A01=Matriz_DH(90+q1,l1,l2,0);
A12=Matriz_DH(0,q2,-l2-l3,90);
A23=Matriz_DH(90,q3,0,-90);
A34=Matriz_DH(q4,l4,0,90);
A45=Matriz_DH(90+q5,l5,l6,0);

A10=Mat_Trans(A01);
A21=Mat_Trans(A12);
A32=Mat_Trans(A23);
A43=Mat_Trans(A34);
A54=Mat_Trans(A45);

Euler=matriz_ang('e');
RPY=matriz_ang('r');