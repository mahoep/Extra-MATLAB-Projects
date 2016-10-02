tic
clear all; close all; clc

load 'salmon_data.csv';
t = (1:length(salmon_data)).';

sdata = salmon_data;


r1_1 = zeros(77,1);
q2 = sum(t);
q3 = sum(t);
q4 = 77;

for k = 1:77;
    q1 = sum(t.^2);
    r1(k+1) = t(k) .* sdata(k);
   
end
r1real = sum(r1);
r2 = sum(sdata);

Q = [q1 q2; q3 q4];
R = [r1real; r2];
P = Q\R;

save('A1.dat','Q','-ascii');
save('A2.dat','R','-ascii');
save('A3.dat','P','-ascii');

T = polyfit(t, sdata, 1);


A4 = polyfit(t,sdata,2);
A5 = polyfit(t,sdata,5);
A6 = polyfit(t,sdata,8);
save('A4.dat','A4','-ascii');
save('A5.dat','A5','-ascii');
save('A6.dat','A6','-ascii');


y1 = polyval(A4,78);
y2 = polyval(A5,78);
y3 = polyval(A6,78);
 

A7 = [y1;y2;y3];
save('A7.dat','A7','-ascii');

tcourse = 1:4:77;
A8 = sdata(1:4:77);
save('A8.dat','A8','-ascii');

A9 = interp1(tcourse,A8,1:77,'nearest')';
A10 = interp1(tcourse,A8,1:77,'linear')';
A11 = interp1(tcourse,A8,1:77,'cubic')';
A12 = interp1(tcourse,A8,1:77,'spline')';
plot(A12,'b')

save('A9.dat','A9','-ascii');
save('A10.dat','A10','-ascii');
save('A11.dat','A11','-ascii');
save('A12.dat','A12','-ascii');

% rms1_1 = zeros(1,78);
% rms2_1 = zeros(1,78);
% rms3_1 = zeros(1,78);
% rms4_1 = zeros(1,78);
for k = 1:77
    rms1_1(k+1) = ((sdata(k) - A9(k))^2);
    rms2_1(k+1) = ((sdata(k) - A10(k))^2);
    rms3_1(k+1) = ((sdata(k) - A11(k))^2);
    rms4_1(k+1) = ((sdata(k) - A12(k))^2);
end

rms1_2 = sum(rms1_1(2:78));
rms1 = sqrt(1/77.*rms1_2);

rms2_2 = sum(rms2_1(2:78));
rms2 = sqrt(1/77.*rms2_2);

rms3_2 = sum(rms3_1(2:78));
rms3 = sqrt(1/77.*rms3_2);

rms4_2 = sum(rms4_1(2:78));
rms4 = sqrt(1/77.*rms4_2);

A13 = [rms1;rms2;rms3;rms4];
save('A13.dat','A13','-ascii');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% PART 2 %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[theta,r] = meshgrid(0:.05*pi:2*pi, 0:.5:20);
f = @(theta,r) [abs(sqrt(2)/(81*sqrt(pi)) .* (6.*r - r.^2).* exp(-r/3) .*cos(theta))].^2;
F=f(theta,r);
[X,Y]= pol2cart(theta,r);
%surf(X,Y,F)

save('A14.dat','X','-ascii');
save('A15.dat','Y','-ascii');
save('A16.dat','F','-ascii');

[theta2,r2] = meshgrid(0:.05*pi:2*pi, 0:.5:20);
f2 = @(theta2,r2) -[abs(sqrt(2)/(81*sqrt(pi)) .* (6.*r2 - r2.^2).* exp(-r2/3) .*cos(theta2))].^2;
F2=f2(theta2,r2);
[X2,Y2]= pol2cart(theta2,r2);
%surf(X2,Y2,F2)

X = [0,1];
[xval] = fminsearch(@minfunc,X);
A17 = [xval];
save('A17.dat','A17','-ascii');

X = [0,10];
[xval] = fminsearch(@minfunc,X);
A18 = [xval];
save('A18.dat','A18','-ascii');

X = [pi,1];
[xval] = fminsearch(@minfunc,X);
A19 = [xval];
save('A19.dat','A19','-ascii');

X = [pi,10];
[xval] = fminsearch(@minfunc,X);
A20 = [xval];
save('A20.dat','A20','-ascii');


%%%%%%%%%%%%%%%% PART 3 %%%%%%%%%%%
% 5 >= 0.1 .*S + 0.23 .*M + 0.31 .*L;
% 7 >= 0.22 .*S + 0.25 .*M + 0.38 .*L;
% 9 >= 0.25 .*S + 0.17 .*M + 0.27 .*L;
% 4 <= 0.10 .*S + 0.23 .*M + 0.31 .*L;
% 15 >= (0.22/2 + 0.15/2).*S + (0.25/3 + 0.17/3).*M + (0.38 + 0.27).*L;
% 2 >= 0.27 .*L
% 2 <= L;
% 3 <= M;
% 1 <= S;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f = [22.4; 26.29; 39.88;];
A = [0.1 0.23 0.31; 
    0.22 0.25 0.38; 
    0.15 0.17 0.27; 
    -0.10 -0.23 -0.31; 
    0.370 0.420 0.6500; 
    0 0 0.27; 
    -1 0 0; 
    0 -1 0; 
    0 0 -1;];
b = [5; 7; 9; -4; 15; 2; -2; -3; -1];
save('A21.dat','f','-ascii');
save('A22.dat','A','-ascii');
save('A23.dat','b','-ascii');

x = linprog(-f,A,b);
x1 = round(x);
save('A24.dat','x1','-ascii');
















toc
