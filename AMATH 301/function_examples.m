%% Section week 10: function examples

close all
clear all

%% Solving Ax = b

A = rand(10,10);
b = rand(10,1);

%% tril, triu, diag (use with Jacobi & Gauss-Seidel)
tril(A);      % Lower triangular part (with diagonal)
triu(A);      % Upper triangular part (with diagonal)

strict_lower_diag = A - triu(A);

% Two ways to use diag

% with matrix -- returns a vector
disp(diag(A))

% with vector -- returns a matrix
disp(diag(b))

% Can specify off-diagonals using diag
B = diag(-2*ones(10,1)) + diag(ones(9,1),-1) + diag(ones(9,1),1);
disp(B)

% LU decomposition (and \)
% PA = LU

[L,U,P] = lu(A);

% Solve linear systems faster: O(n^2) instead of O(n^3)
% Ax = b --> PAx = Pb
% PAx = LUx = Pb --> Ly = Pb (if Ux = y)

y = L \ P*b;
x = U \ y;
disp(['norm of x - A\b' num2str(norm(x-A\b))]);

% Can also use \ to find product inv(A)*B;
disp(['norm of inv(A)*B - A \ B' num2str(norm(inv(A)*B - A \ B))]);

% If matrix is not invertible, has large condition number
C = A - triu(A);
disp(['condition number of C: ' num2str(cond(C))]);


%% Interpolation

% Noisy sin data
x = 0:.05:3;
y = sin(x) + randn(size(x)) / 30;

plot(x,y,'k.');
title('Sin with noise (interpolation example)')
hold on

% polycoeff = polyfit(x,f(x),degree)
polycoeffs2 = polyfit(x,y,2);
polycoeffs10 = polyfit(x,y,10);

% y_vals = polyval(polycoeffs,x_vals)
y_vals2 = polyval(polycoeffs2,x);
y_vals10 = polyval(polycoeffs10,x);

plot(x,y_vals2,'b-',x,y_vals10,'r-')
% Notice the polynomial wiggle on the far right for the degree 10
% interpolant
legend('original data','degree 2 poly', 'degree 10 poly')

% y_interp = interp1(x_vals,y_vals,xpts,method)
% method could be 'linear', 'nearest', 'spline', 'cubic', etc.
y_interp = interp1(x,y,0:.01:3,'spline');

figure()
plot(x,y,'k.',0:0.01:3,y_interp,'b-')
title('interp1 example')
legend('original data','interpolation')

% Can also use spline (same as spline method above but with more options)


%% Optimization

% [x_star, fval] = fminsearch(f,x0)
% minimizes f with initial guess x0
% Only takes functions that take one input (f = f(x))

f = @(x,y,z) x^2 + sin(y) + exp(z);

% fix z = 2;

[x_star, fval] = fminsearch(@(w) f(w(1),w(2),2),[0 0]);
disp(['fval - f(x_star) = ' num2str(fval - f(x_star(1),x_star(2),2))]);

% [x, fval, flag] = linprog(f, A, b, ...)
% minimizes f.'*x with A*x <= b
% flag = 1 ==> converged 

f = [-5; -4; -6]; % minimize -5x_1 - 4x_2 - 6x_3
A = [1 -1 1
     3 2 4
     3 2 0];
b = [20; 42; 30];

% I don't have the optimization toolbox on this computer... uncomment if you
% have it
% [x, fval, flag] = linprog(f,A,b);



% *** In both use -f if you want to maximize function instead ***

%% Numerical integration

% int = trapz(x,f(x))
% or, if you've got regular spacing dx
% int = trapz(f(x)) * dx

% Reuse sin example without noise
y = sin(x);
dx = 0.05;

int1 = trapz(x,y);
int2 = trapz(y)*dx;
disp(['int1 - int2 = ' num2str(int1-int2)])


% int = quad(fun,a,b);
% integrate fun from a to b (actually need the function for this one)

% multiple ways to do the same thing:
disp('quad output:')
disp(quad('sin',0,3))
disp(quad(@(x) sin(x),0,3))
f = @(x) sin(x);
disp(quad(f,0,3))


%% Differential equations

% Really just have ode45, ode23...
% Solve y' = f(t,y), y(t0) = y0
% [t, y] = ode45(f,tspan,y0)

A = [0 1; -1 0.1];
f = @(t,y) A*y;
tspan = [0 2*pi];
y0 = [1;0];

% tvals column vector, yvals a length(tvals)x2 matrix
[tvals, yvals] = ode45(f,tspan,y0);

figure()
plot(yvals(:,1),yvals(:,2))
title('ode45 example')
xlabel('x')
ylabel('y')


%% SVD

% A = US(V^*) or AV = US
A = rand(10,10);
[U,S,V] = svd(A);
disp(['norm of US(V^*) - A' num2str(norm(U*S*(V') - A))])


%% FFT 
x = 0:0.001:3;

% Add some noise to a signal
Vclean = 12*sin(30*x) - 3*cos(100*x);
V = Vclean + randn(size(x));
figure()
plot(x,V)
hold on

% Take fft
Vhat = fft(V);

% Find magnitude of frequencies
Vmag = abs(Vhat);

% Use plot to determine a good threshold (300 looks good)
% plot(Vmag)

% Filter out weaker frequencies (these correspond to noise)
Vhat = Vhat .* (Vmag > 300);

% compute inverse fft and plot
Vfiltered = ifft(Vhat);
title('FFT example')
plot(x,Vfiltered,'r-')
plot(x,Vclean,'g-')
legend('noisy signal','filtered','clean signal')

