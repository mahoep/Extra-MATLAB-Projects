tic
close all; close all; clc

% %%% 
% xdot = sigma(y-x)
% ydot = x(p-z) - y
% zdot = x*y - beta*z
% %%%

clear all

% Lorenz's parameters (chaotic)
sigma = 10;
beta = 8/3;
rho = 28;

% Initial condition
y_0=[-8; 8; 27];

% Compute trajectory 
d_t =0.01;
tspan=[0:d_t:4]; 

Y_1(:,1)=y_0;
y_in = y_0;
for i=1:tspan(2)/d_t
    time = i*d_t;
    y_out = rk4singlestep(@(t,y)lorenz(t,y,sigma,beta,rho),d_t,time,y_in);
    Y_1 = [Y_1 y_out];
    y_in = y_out;
end
plot3(Y_1(1,:),Y_1(2,:),Y_1(3,:),'b')
hold on
[t,y] = ode45(@(t,y)lorenz(t,y,sigma,beta,rho),tspan,y_0);
plot3(y(:,1),y(:,2),y(:,3),'r')



toc