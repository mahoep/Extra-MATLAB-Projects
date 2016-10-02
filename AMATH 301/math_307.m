clear all; close all; clc
% tic
% A = [1 0 1 0;
%     2 1 0 1;
%     2 2 4 0;
%     0 2 0 4;];
% b = [0;0;0;1];
% [L,U,P] = lu(A);
% y = L\P*b; 
% x = U\y;
% toc

clear all
x=-10:.1:10;
[X,Y] = meshgrid(x);
a=1; b=1; c=1; d=0;
Z=(d- a * X - b * Y)/c;
surf(X,Y,Z)
shading flat
xlabel('x'); ylabel('y'); zlabel('z')