m1=100;
m2=100;
M=1000;
l1=20;
l2=10;
g=9.81;
A=[0 1 0 0 0 0;
    0 0 -(m1*g)/M 0 -(m2*g)/M 0;
    0 0 0 1 0 0;
    0 0 -(M+m1)*g/(M*l1) 0 -(m2*g)/(M*l1) 0;
    0 0 0 0 0 1;
    0 0 -(m1*g)/(M*l2) 0 -(M+m2)*g/(M*l2) 0];
disp(A);
B=[0;
    1/M;
    0;
    1/(M*l1);
    0;
    1/(M*l2)];
disp(B);
C=[1 0 0 0 0 0];
    %0 0 1 0 0 0
    %0 0 0 0 1 0];
D=0;
Q=C'*C;
Q(1,1)=50000000;
Q(3,3)=9000000000;
Q(5,5)=9000000000;
disp(Q);
R = 1;
K = lqr(A,B,Q,R);
Ac = [(A-B*K)];
Bc = [B];
Cc = [C];
Dc = [D];

sys_ss = ss(A,B,C,0);
ob=obsv(sys_ss);
disp(ob);
observ=rank(ob)
poles=eig(Ac)



