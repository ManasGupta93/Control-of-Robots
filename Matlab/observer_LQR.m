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
    %0 0 1 0 0 0;
    %0 0 0 0 1 0];
D=0;


P = [-0.2 -0.3 -0.4 -0.5 -0.6 -0.7];

outputs = {'x'};


X0 = [0.2;0;10*pi/180;0;15*pi/180;0];

Xhat = [0;0;10*pi/180;0;15*pi/180;0];

L = place(A',C',P)'

states = {'x','x_dot','theta1','theta1_dot','theta2','theta2_dot'};
inputs = {'F'};

sys_ol = ss(A, B, C, D, 'statename',states,'inputname',inputs,'outputname',outputs);


t = 0:0.01:5;
u = ones(size(t));
[Y,~,X] = lsim(sys_ol,u,t,X0);

X_est = Xhat';
k = 2;
for n = 0.01:0.01:5
    dXhat = A * Xhat + B .* u(k) + L * (Y(k,:)' - C*Xhat);
    Xhat = Xhat + 0.01.*dXhat;
    X_est = [X_est;Xhat'];
    k = k + 1;
end
  subplot(3,1,1),plot(t,X(:,1)),hold on,plot(t,X_est(:,1),'r')
xlabel('Time(sec)'),ylabel('Cart Position(m)'),legend('X','X_est')
 subplot(3,1,2),plot(t,X(:,3)),hold on,plot(t,X_est(:,3),'r')
xlabel('Time(sec)'),ylabel('Pendulum Angle(theta1))'),legend('theta1','theta1Est')
subplot(3,1,3), plot(t,X(:,5)),hold on,plot(t,X_est(:,5),'r')
xlabel('Time(sec)'),ylabel('Pendulum Angle(theta2))'),legend('theta2','theta2Est')