clear all; close all;
%Exercise 1: Basic Matrix Operations
%Defining All Variables First
A=[-4 2; 2 1];
B=[2 -1; 1 -2];
C=[1 -3 2; 1 -9 -4];
D=[1 2; 1 -3; -2 3];
x=[1; 0];
y=[0; 1];
z=[2; -4; 1];

%Working Out the first 10 solutions

A1=A-B;
save('A1.dat','A1','-ascii')

A2=4.*x - 2.*y;
save('A2.dat','A2','-ascii')

A3=A*y;
save('A3.dat','A3','-ascii')

A4=A*(y+x);
save('A4.dat','A4','-ascii')

A5=D*x;
save('A5.dat','A5','-ascii')

A6=D*y + z ;
save('A6.dat','A6','-ascii')

A7=A*B;
save('A7.dat','A7','-ascii')

A8=B*A;
save('A8.dat','A8','-ascii')

A9=A*C;
save('A9.dat','A9','-ascii')

A10=C*D;
save('A10.dat','A10','-ascii')

%Extracting information from matricies

A11=C(:,2);
save('A11.dat','A11','-ascii')

A12=D(2:3,1:2);
save('A12.dat','A12','-ascii')

A13=C(2,1:end-1);
save('A13.dat','A13','-ascii')

%Exercise 2: Truncation Errors

% for j = 1:0.1:10000;
%     x1 = abs(1000-j);
% end
% 
% for j = 1:0.125:8000;
%     x2 = abs(1000-j);
% end
% 
% for j = 1:0.2:5000;
%     
% end
% x3 = abs(1000-j);
% 
% for j = 1:0.25:4000;
%     x4 = abs(1000-j);
% end

sum1=1000;
for j = 1:10000;
    sum1 = (sum1 -.1);
end

sum2=1000;
for j = 1:8000;
    sum2 = (sum2 -.125);
end

sum3=1000;
for j = 1:5000;
    sum3 = (sum3 -.2);
end

sum4=1000;
for j = 1:4000;
    sum4 = (sum4 -.25);
end


x_vecs = [sum1; sum2; sum3; sum4]; 
save('A14.dat','x_vecs','-ascii')



