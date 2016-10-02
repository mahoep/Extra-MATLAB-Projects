%% Part 1
clear all; close all; clc
tic
xval = 0.1:0.05:0.5;
yval = 1.8:0.05:2.2;
zval = 11.8:0.05:12.2;
[xvec,yvec,zvec] = meshgrid(xval,yval,zval);

A = [xvec(:)';yvec(:)';zvec(:)';];
DC(1,:) = xvec(:)';
DC(2,:) = yvec(:)';
DC(3,:) = zvec(:)';
save('A1.dat','A','-ascii')
% plot3(x0(:,:),y0(:,:),z0(:,:),'r.')
c = [16 5 10 6 18 0.05];

funcx1 = @(x) -c(1).*x(1,1,:) + c(6).*x(1,2,:).*x(1,3,:);
funcx2 = @(x) c(3).*x(1,2,:) - c(4).*x(1,1,:).*x(1,3,:);
funcx3 = @(x) -c(2).*x(1,3,:) + c(5).*x(1,2,:).*x(1,2,:);
dt = 0.01;
t = 0:dt:7;
W = zeros((length(t)),3,9^3);
W(1,:,:) = DC;

for k = 1:700
    xdot1_1 = funcx1(W(k,:,:)); 
    xdot1_2 = funcx2(W(k,:,:)); 
    xdot1_3 = funcx3(W(k,:,:)); 
    
    xdot1 = [xdot1_1 xdot1_2 xdot1_3];
    xdotreal = W(k,:,:) + (dt/2)*xdot1;
    
    ydot1_1 = funcx1(xdotreal); 
    ydot1_2 = funcx2(xdotreal); 
    ydot1_3 = funcx3(xdotreal); 
    
    ydot1 = [ydot1_1 ydot1_2 ydot1_3];
    ydotreal = W(k,:,:) + (dt/2)*ydot1;
    
    zdot1_1 = funcx1(ydotreal); 
    zdot1_2 = funcx2(ydotreal);
    zdot1_3 = funcx3(ydotreal);
    
    zdot1 = [zdot1_1 zdot1_2  zdot1_3];
    zdotreal = W(k,:,:) + (dt)*zdot1; 
    
    xdotfinal = funcx1(zdot1);
    ydotfinal = funcx2(zdot1);
    zdotfinal = funcx3(zdot1);
    
    finaliter = [xdotfinal ydotfinal zdotfinal];
    
    W(k+1,:,:) = squeeze(W(k,:,:) + (dt/6)*(xdot1 + 2*ydot1+ 2*zdot1 + finaliter));
end


A2 = squeeze(W(:,1,:));
A3 = squeeze(W(:,2,:));
A4 = squeeze(W(:,3,:));
for i=1:length(t)
    plot3(A2(i,:),A3(i,:),A4(i,:),'.');
    axis([-.5,.5,-10,10,0,50])
    drawnow
    pause(dt)
end

save('A2.dat','A2','-ascii')
save('A3.dat','A3','-ascii')
save('A4.dat','A4','-ascii')
toc
%% Part 2
clear all; close all; 
tic
r = [2.5 3.2 3.52 4];
x0 = [.7 .7 .7 .7];
C = zeros(31,4);
C(1,:) = x0;

for k = 1:30
    C(k+1,:) = r.*C(k,:).*(1-C(k,:));
%     plot(C)
%     pause(.15)
end
save('A5.dat','C','-ascii')
 A6 = [0;2;5];
 save('A6.dat','A6','-ascii')
 
F = zeros(501,1501);
F(1,:) = 0.7;
 r = 2.5:0.001:4;
 j=0;
for k = 1:500
    F(k+1,:) = r(k).*F(k,:).*(1-F(k,:));
    j = j+1;
%     wdtile j > 400;
%         plot(F,'k.','Markersize',1)
%         pause(.1)
%         break
%     end
end
 
A7 = F(1:100,:);
save('A7.dat','A7','-ascii')
toc
%% Part 4
clear all; close all;
tic
load imag_data.mat  %1-20 Sylvester Stallone  21-40 Taylor Swift
% imsdtow(uint8(resdtape(A14,200,175)))

for k = 1:35000
    avg(:,k) = mean(B(k,:));
end
A14 = avg.';
save('A14.dat','A14','-ascii')
for k =1:40
    A(:,k) = B(:,k)-avg.';
end
[U,S,V] = svd(A,'econ');
SVs = diag(S);
A15 = SVs(1:10);
D = U*S*conj(V); 

u1 = U(:,1);
u2 = U(:,2);
u3 = U(:,3);
x = u1'*A;
y = u2'*A;
z = u3'*A;
save('A15.dat','A15','-ascii')
save('A16.dat','x','-ascii')
% plot3(x(1:20),y(1:20),z(1:20),'bo',x(21:40),y(21:40),z(21:40),'ro')

unew = u-avg.';
proj2 = U(:,1:3).' * unew;
save('A17.dat','proj2','-ascii')
% imshow(uint8(reshape(u,200,175)))
toc


%% Part 5
clear all; close all;
tic
[V,fr] = wavread('noisy_message.wav');
Vfft = fft(V);
A18 = abs(Vfft(1:1000));
L = abs(Vfft);
Vfft = Vfft .* (L >50);
Vnew2 = ifft(Vfft);
% sound(V,fr)
sound(Vnew2,fr)
A19 = abs(Vfft(1:1000));
A20 = Vnew2(1:1000);
save('A18.dat','A18','-ascii')
save('A19.dat','A19','-ascii')
save('A20.dat','A20','-ascii')


clear all
[V,fr] = wavread('noisy_message.wav');
[rows, colo] =size(V);
dt = rows/8;

Vplus(:,1) = V(1:dt).';
for k = 2:8
    Vplus(:,k) = fft(V((k-1)*dt:(dt*(k)-1)));
end
for k = 1:8
   Vfft_1(:,k) = fft(Vplus(:,k));
    L(:,k) = abs(Vfft_1(:,k));
    Vfft2(:,k) = Vfft_1(:,k) .* (L(:,k) < 50);
    Vnew2(:,k) = abs(ifft(Vfft2(:,k)));
end

T = [Vnew2(:,1);Vnew2(:,2);Vnew2(:,3);Vnew2(:,4);Vnew2(:,5);Vnew2(:,6);Vnew2(:,7);Vnew2(:,8);];
% sound(T,fr)
A21 = T(1:1000);
save('A21.dat','A21','-ascii')
toc