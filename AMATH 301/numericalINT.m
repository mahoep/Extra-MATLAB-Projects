clear all; close all

a = 0;
b = 10;
dxf = 0.01;
xf = a:dxf:b;
yf = sin(xf);
plot(xf,yf,'k')

dxc = .0001;
xc = a:dxc:b;
yc = sin(xc);
hold on
stairs(xc,yc,'r')

n = length(xc);

% Left-rectangle rule
area1 = 0;
for i=1:n-1
    area1 = area1 + yc(i)*dxc;
end
area1

% Right-rectangle rule
area2 = 0;
for i=1:n-1
    area2 = area2 +yc(i+1)*dxc
end
area2

% trapezoid rule
area3 = 0;
for i=1:n-1
    area3 = area3 + (dxc/2)*(yc(i) + yc(i+1))
end
area3

area3matlab = trapz(xc,yc)

% same stuff but without for loops
area1f = sum(yf(1:end-1))*dxf;
area2f = sum(yf(2:end))*dxf;
area3 = trapz(xf,yf)
area4 = quad(@(x)sin(x),a,b)
