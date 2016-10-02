clear all;  close all; clc
tic

% r_6*I_1 + r_1(I_1 - I_2) + r(2)(I_1 - I_3) = V1
% r_3*I_2 + r_4(I_2 - I_3) + r_1(I_2 - I_1) = V2
% r_5*I_3 + r_4(I_3 - I_2) + r_2(I_3 - I_1) = V3
% 
% r_1 = 10;
% r_2 = 20;
% r_3 = 5;
% r_4 = 15;
% r_5 = 30;
% r_6 = 25;

r = [10 20 5 15 30 25];


A = [(r(1)+r(2)+r(6)) -r(1) -r(2);
    -r(1) (r(1)+r(3)+r(4)) -r(4);
    -r(2) -r(4) (r(2)+r(4)+r(5));];
[L,U,P] = lu(A);
A1 = [A P L U];
save('A1.dat','A1','-ascii');
V1 = 50;
V2 = 0;

for k=1:100;
	V3 = k;
    b1 = [V1;V2;V3];
    y = L\P*b1;
    x1 = U\y;
    X1(:,k) = x1;
end
save('A2.dat','X1','-ascii');

for k=1:100;
	V3 = k;
    b2= [50;0;V3];
    x2 = inv(A)*b2;
    X2(:,k) = x2;
end

xsol = abs(X1-X2);
save('A3.dat','xsol','-ascii');

s = sqrt(2)/2;
A_2 = [-s 1 0 0 0 0 0 0 0 s 0 0 0;
-s 0 0 0 0 0 0 0 -1 -s 0 0 0;
0 -1 1 0 0 0 0 0 0 0 0 0 0;
0 0 0 0 0 0 0 0 0 0 -1 0 0;
0 0 -1 s 0 0 0 0 0 0 0 -s 0;
0 0 0 -s 0 0 0 0 0 0 0 -s -1;
0 0 0 -s -1 0 0 0 0 0 0 0 0;
0 0 0 0 1 -1 0 0 0 0 0 0 0;
0 0 0 0 0 0 0 0 0 0 0 0 1;
0 0 0 0 0 1 -1 0 0 -s 0 s 0;
0 0 0 0 0 0 0 0 0 s 1 s 0;
0 0 0 0 0 0 1 -1 0 0 0 0 0;
0 0 0 0 0 0 0 0 1 0 0 0 0;];

b2 = [0; 0; 0; 0; 0; 0; 0; 0; 5; 0; 5; 0; 5;];
[L,U,P] = lu(A_2);
y = L\P*b2;
x_lu = U\y;

save('A4.dat','y','-ascii');
save('A5.dat','x_lu','-ascii');

A6 = A_2\b2;
save('A6.dat','A6','-ascii');


loopcnt = 0;

for j=5:0.01:500;
    b2(11,1) = b2(11,1) + j;
    loopcnt = loopcnt + 1;
    x=A_2\b2;
    if norm(x,inf) > 30;
    break
    end
end
A7 = round(b2(11,1));
save('A7.dat','A7','-ascii');


A = zeros(50,50);
A(50,50) = 2;
for n = 0:48
    A(n+1,n+1) = 2;
    A(n+2,n+1) = -1;
    A(n+1,n+2) = -1;
end

clear j;
j = [1:50];
p_j = 2*(1-cos(23*pi/51))*sin(23*pi*j/51);

D = zeros(50,50);
D(50,50) = 2;
for n = 0:48
    D(n+1,n+1) = 2;
end

T = zeros(50,50);
for n = 0:48
    T(n+2,n+1) = -1;
    T(n+1,n+2) = -1;
end

M = -inv(D)*T;
c = inv(D)*p_j';

A8= [M c];
save('A8.dat','A8','-ascii')

%JACOBI ITERATION
%x_{k+1} = M * x_k + c

phi = ones(50,1); % initial guess
tol = 1.e-4;  % keep iterating until error converges to <=tol
iter = 1;
while((iter<5000))
    iter = iter + 1;
    phi(:,iter) = M*phi(:,iter-1) + c;
    if tol >= norm(phi(:,iter)-phi(:,iter-1),Inf); % Worst component (infinity) error norm
    break
    end
end
trueiter = iter - 1;
A9 = phi(1:50,end);
save('A9.dat','A9','-ascii')
save('A10.dat','trueiter','-ascii')

% Gauss-Seidel iteration
% A = S + T
% S = lower trianglar of A + the diag of A
% T is everything else
%x_{k+1} = -S*T * x_k + inv(S)*b
phi2 = ones(50,1);
S = tril(A);
T = triu(A) - diag(diag(A));
j = [1:50];
p_j = 2*(1-cos(23*pi/51))*sin(23*pi*j/51);

M = -inv(S)*T;
c = inv(S)*p_j';

A11= [M c];
save('A11.dat','A11','-ascii')

tol = 1.e-4;  % keep iterating until error converges to <=tol
iter2 = 1;
while((iter2<2500))
    iter2 = iter2 + 1;
    phi2(:,iter2) = M*phi2(:,iter2-1) + c;
    if tol >= norm(phi2(:,iter2)-phi2(:,iter2-1),Inf); % Worst component (infinity) error norm
    break
    end
end

trueiter2 = iter2 - 1;
A12 = phi2(1:50,end);
save('A12.dat','A12','-ascii')
save('A13.dat','trueiter2','-ascii')

toc


