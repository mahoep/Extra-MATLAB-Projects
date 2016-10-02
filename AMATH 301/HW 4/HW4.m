clear all; close all; clc
tic

t = [-90:10:110];
x = [1810:10:2010];
n = length(x);
N = [7.24; 9.64; 12.87; 17.07; 23.19; 31.44; 38.56; 50.19; 62.98;
76.21; 92.23; 106.02; 123.20; 132.16; 151.33; 179.32; 203.30;
226.54; 248.71; 281.42; 307.75];

dndt = zeros(size(t));

dndt(1) = (-3*N(1) + 4*N(2) - N(3))/20;

for j=2:n-1;
    dndt(j) = (N(j+1) - N(j-1))/20;
end

dndt(n) = (3*N(n) - 4*N(n-1) + N(n-2))/20;
A1 = dndt';
save('A1.dat','A1','-ascii')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% PART 2 %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

r = [0.308 0.325 0.342 0.359 0.376 0.393 0.410 0.427 0.444 0.461 0.478]';
T = [640 794 885 943 1034 1064 1114 1152 1204 1222 1239]';
thetap = 0.7051;


num = (0.017/3) * (sum(T(1:2:end-2).*r(1:2:end-2)) + sum(4*T(2:2:end-1).*r(2:2:end-1)) + sum(T(3:2:end).*r(3:2:end)))*thetap;
dem = (0.017/3) * (sum(r(1:2:end-2)) + sum(4*r(2:2:end-1)) + sum(r(3:2:end)))*thetap;
A2 = num/dem;
save('A2.dat','A2','-ascii')

vec1 = trapz(r,T.*r.*thetap);
vec2 = trapz(r,(r*thetap));
A3 = vec1/vec2;
save('A3.dat','A3','-ascii')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% PART 3 %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

k1 = 2;
k2 = 0.25; 
k3 = 1.5;
X = zeros(11,1);
dt = 0.1;
t = 0:0.1:1;
X(1) = 1;
funcX = @(t,X) -k1*((X./(k2 + X)))*X + k3*sin(pi*t);

for k = 1:10
    X(k+1) = X(k) + dt*(-k1*((X(k)./(k2 + X(k))))*X(k) + k3*sin(pi*t(k)));
end
save('A4.dat','X','-ascii')

X2 = zeros(11,1);
X2(1) = 1;
h = 0.1;

for k = 1:10
    f1 = h* funcX(t(k),X2(k));
    f2 = h* funcX(t(k) + h/2, X2(k) + f1/2);
    f3 = h* funcX(t(k) + h/2, X2(k) + f2/2);
    f4 = h* funcX(t(k) + h, X2(k) + f3);
    X2(k+1) = X2(k) + (f1 + 2*f2 + 2*f3 +f4)/6;
end
save('A5.dat','X2','-ascii')

h =0.01;
X3 = zeros(100,1);
X3(1) = 1;
t2 = 0:.01:1;
for k = 1:100
    X3(k+1) = X3(k) + h*(-k1*((X3(k)./(k2 + X3(k))))*X3(k) + k3*sin(pi*t2(k)));
end


X4 = zeros(100,1);
X4(1) = 1;
for k = 1:100
    f1 = h* funcX(t2(k),X4(k));
    f2 = h* funcX(t2(k) + h/2, X4(k) + f1/2);
    f3 = h* funcX(t2(k) + h/2, X4(k) +f2/2);
    f4 = h* funcX(t2(k) + h, X4(k) + f3);
    X4(k+1) = X4(k) + (f1 + 2*f2 + 2*f3 +f4)/6;
end
A6 = [X3,X4];
save('A6.dat','A6','-ascii')

[EIN, EOUT] = ode45(funcX,[0;1],1);
A7 = [EIN,EOUT];
save('A7.dat','A7','-ascii')

%

A = [0 1; -10/8 -3];
save('A8.dat','A','-ascii')
difft = 0.01;
M = eye(2) + difft*A;

while norm(eig(M),inf) <1
    difft = difft+ 0.01;
    M = eye(2) + difft.*A;
end
save('A9.dat','difft','-ascii')

X = zeros(50,1);
V = zeros(50,1);
X(1) = 1;
y = zeros(2,50);
y(:,1) = [1,0];
t = 0:(difft*0.8):50;

y(:,2) = (eye(2) + 0.8*difft.*A)*[X(1),V(1)].';
for k = 1:(length(t))
    y(:,k+1) = (eye(2) + 0.8*difft.*A)*y(:,k);
    
end
A10 = y(1,1:79);
save('A10.dat','A10','-ascii')


X = zeros(50,1);
V = zeros(50,1);
X(1) = 1;
y2 = zeros(2,50);
y2(:,1) = [1,0];
t = 0:(difft*1.05):50;

y2(:,2) = (eye(2) + 1.05*difft.*A)*[X(1),V(1)].';
for k = 1:50/(1.05*0.8)
    y2(:,k+1) = (eye(2) + 1.05* difft.*A)*y2(:,k);
    
end
A11 = y2(1,:);
save('A11.dat','A11','-ascii')

X = zeros(2,1);
V = zeros(2,1);
X(1) = 1;

funcXdot = @(t,x) A*x;

[Xout,Vout] = ode45(funcXdot,[0 50],[1,0]);
A12 = Vout(:,1);
A13 = Vout(:,2);

save('A12.dat','A12','-ascii')
save('A13.dat','A13','-ascii')

toc


