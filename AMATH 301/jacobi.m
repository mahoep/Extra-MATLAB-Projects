%Jacobi Iteration
% Solves the system of equations Ax = b with inital guess

function [x, error] = jacobi(A,b, x0, tol)
%decompose A
D = diag(diag(A));
T = A - D;
M = D \ (-T);
c = D \ b;


x = x0;
xprev = x0;
error = 2*tol;

while(error>tol)
    x = M*x +c;
    error = norm(x-xprev,inf);
    xprev = x;
end
end