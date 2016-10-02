% Amath 301 Section week 9

% Autumn 14 HW5 (PCA example)

% % Initialize D
% load pend_data.mat
% 
% 
% % First 10 rows of D are relative x data, next 10 y, final 10 z
% 
% % Compute covariance-like matrix
% C = D*(D.');
% 
% % Diagonals give variance of each row
% % Off diagonals give covariance between data streams
% 
% % Let's compute the SVD to figure out the important directions
% % C = USV*
% [U,S,V] = svd(D,'econ');
% 
% % Let's look at the first 10 (largest) singular values
% allSVs = diag(S);
% topSVs = allSVs(1:10);
% 
% % First one is way bigger! This means the first principal direction
% % contains the most info about D
% 
% % Project D onto principal direction
% % D = USV* ==> U*D = SV*
% % u1*D = sV1*
% 
% projection = U(:,1).' * D;
% 
% % Plot this row of data versus time, time goes from0 to 10 by 0.1
% t = 0:0.1:10;
% plot(t,projection,'b-')
% xlabel('time')
% ylabel('observed position')
% % hold on
% % plot(t,D(21,:),'r-')
% % legend('svd', 'D')
% 
% % We've isolated the z component of motion!



% Higher dimensional matrices and squeeze

% 3D
M = rand(10,5,5);

% Fixing first index gives 5x5 (stack of 10 5x5s)
size(M(4,:,:))

% Fixing second gives 10 x 5 (row vector length five, 10 high)
size(M(:,3,:))

% Matlab still interprets as a 3D object though
% M(4,:,:) + ones(5,5)

% Use squeeze to get Matlab to reduce dimension "eliminate singleton
% dimension"
squeeze(M(4,:,:)) + ones(5,5)


% Example: Forward Euler

% ODE:
% x' = y
% y' = -x

% function - come back to this once we figure out dimensions
f = @(t,y) [y(1,2,:),...   % x' = y
                -y(1,1,:)];   % y' = -x

dt = 0.01;
t0 = 0;
tfinal = 3;

% Use lots of initial conditions (2x10
y0 = [1:10;
        1:10];

% 300 steps + IC gives 301 time steps
% Stack of 301 2x10 matrices
y = zeros(301,2,10);
y(1,:,:) = y0;

for k=1:300
    y(k+1,:,:) = y(k,:,:) + dt * f(t0,y(k,:,:));
end
% Go back and write f

% plot results
plot(squeeze(y(:,1,:)),squeeze(y(:,2,:)))










