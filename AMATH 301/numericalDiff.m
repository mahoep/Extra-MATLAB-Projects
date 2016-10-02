clear all

% numerically differentiate a discrete grid
% compare with exact derivative cos(x)
% but, we are assuming that we only have data


x = 0.1:.1:3;
f = sin(x);
plot(x,f,'k')
hold on
plot(x,f,'rx','Linewidth',2)

% just data from here on in
dx =x(2) - x(1);
n = length(f);

dfdx = zeros(n,1);

dfdx(1) = (f(2) - f(1))/(x(2) - x(1)); % forward difference at x(10
for i=2:n-1
    dfdx(i) = (f(i+1)-f(i-1))/(x(i+1)-x(i-1));
end
dfdx(n) = (f(n) - f(n-1))/(x(n)-x(n-1));

figure
plot(x,cos(x),'k')
hold on
plot(x,dfdx,'r')
legend('True','Approximation')