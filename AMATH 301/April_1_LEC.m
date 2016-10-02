clear all; close all; clc

r=1.5; % growth rate
T=20; % end time
N0=0.01; % start population

% N(1)= N0;
% 
% for j = 1:T;
%     N = r*N*(1-N);
%     
% end
% 
% 
% N

N = zeros(1,T+1);
N(1)=N0;

% for j=1:T
%     N(j+1)=r*N(j)*(1-N(j));
% end
% 
% t = 0:1:T;
% 
% plot(t,N)
% title('Logistick Growth Model','Fontsize',15)
% xlabel('Time','Fontsize', 15)
% ylabel('Population Density','Fontside',15)

thresh = 0.3;
time = 0;
N = N0;

while N < thresh
    N = r*N*(1-N);
    time = time + 1;
end

for j=0:10000
    N = r*N*(1-N);
    time = time + 1;
    if N >= thresh
        break
    end
end
time