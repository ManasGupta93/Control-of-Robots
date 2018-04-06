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

C = [1 0 0 0 0 0];
D=0; 
A_I = [A zeros(size(A,1),1);eye(1,size(A,2)) 0];
B_I = [B;zeros(size(B,2))];
B_2 = B_I;
B_2(end) = -1;
C_I = [C 0];
Q = C_I' * C_I;
Q(1,1) = 90000000;
Q(3,3) = 80000000000;
Q(5,5) = 70000000000;
Q(7,7) = 10000000;
 
R = 1;
[K,~,~] = lqr(A_I,B_I,Q,R);
 
states = {'x','x_dot','phi1',' phi1_dot',' phi2',' phi2_dot','x_int'};
inputs = {'F','disturb'};
outputs = {'x'};
sys_cl = ss(A_I - B_I * K, [B_2 B_I], C_I, D, 'statename',states,'inputname',inputs,'outputname',outputs);
r = 2;
Fd = 1000;
t = 0:0.01:50;
F = r * ones(size(t,2),1);
disturb = Fd*ones(size(t,2),1);
[Y,~,~] = lsim(sys_cl,[F disturb],t);
 
plot(t,Y(:,1),'r','linewidth',2);
xlabel('Time(sec)')
ylabel('Cart Position(m)')
hold on
plot(t,r*ones(size(t)),'g')
title('Response of the system to Step Reference of 2m with external disturbances')
