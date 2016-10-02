clear all
graphicsON = 1;
tstart = tic;
A = 0.1; 
eps = 0.25;
omega = 2*pi/10;

%% Exercise 1
%% Part (a) - Initialize grid of particles
dx = .01;
xvec = 0:dx:2;
yvec = 0:dx:1;
[x0,y0] = meshgrid(xvec,yvec);
yIC(1,:,:) = x0';
yIC(2,:,:) = y0';

save -ASCII A1.dat x0;
save -ASCII A2.dat y0;

% plot everything
if(graphicsON)
    subplot(2,1,1)
    dy = doublegyreVEC(0,yIC,A,eps,omega);
    % plot the vector field using 'quiver'
    quiver(yIC(1,1:4:end,1:4:end),yIC(2,1:4:end,1:4:end),dy(1,1:4:end,1:4:end),dy(2,1:4:end,1:4:end));
    axis([0 2 0 1])
    drawnow
    subplot(2,1,2)
    % plot initial conditions
    plot(yIC(1,:),yIC(2,:),'r.','LineWidth',2,'MarkerSize',4)
    axis([0 2 0 1])
    drawnow
end
%% Part (b) - Compute trajectory 
dt =0.01;
T = 15;  % duration of integration

yin = yIC;
for i=1:T/dt
    time = i*dt;
    if(graphicsON)
        subplot(2,1,1)
        dy = doublegyreVEC(time,yIC,A,eps,omega);
        quiver(yIC(1,1:4:end,1:4:end),yIC(2,1:4:end,1:4:end),dy(1,1:4:end,1:4:end),dy(2,1:4:end,1:4:end));
        axis([0 2 0 1])
        drawnow
    end
    
    yout = rk4singlestep(@(t,y)doublegyreVEC(t,y,A,eps,omega),dt,time,yin);
    yin = yout;
    
    if(graphicsON)        
        subplot(2,1,2)
        plot(yout(1,:),yout(2,:),'r.','LineWidth',2,'MarkerSize',4)
        axis([0 2 0 1])
        drawnow
    end        
end

% reshape 3-dim array into 2-dim array
xT = reshape(yout(1,:,:),length(xvec),length(yvec));
yT = reshape(yout(2,:,:),length(xvec),length(yvec));
save -ASCII A3.dat xT
save -ASCII A4.dat yT

%% Part (c) -  Compute the finite-time Lyapunov exponent (sigma)
% Finite difference to compute the gradient
[dxTdx0,dxTdy0] = gradient(xT,dx,dx);
[dyTdx0,dyTdy0] = gradient(yT,dx,dx);

% compute sigma: large sigma indicates large mixing!
for i=1:length(xvec)
    for j=1:length(yvec)
        D(1,1) = dxTdx0(i,j);
        D(1,2) = dxTdy0(i,j);
        D(2,1) = dyTdx0(i,j);
        D(2,2) = dyTdy0(i,j);
        sigma(i,j) = (1/T)*sqrt(max(eig(D'*D)));
    end
end
save -ASCII A5.dat sigma
if(graphicsON)
    figure
    surf(x0',y0',sigma)
    figure
    contourf(x0',y0',sigma)
end

%% Exercise 2
%% Part (a) - Run particles through velocity field
% notice that they don't stretch too much
if(graphicsON) 
    figure; 
end
clear xvec yvec yIC yin yout %  x0 y0
xvec = .78:.01:.88;
yvec = .68:.01:.78;
[x0g,y0g] = meshgrid(xvec,yvec);
yIC(1,:,:) = x0g';
yIC(2,:,:) = y0g';
yin = yIC;
for i=1:T/dt
    time = i*dt;   
    yout = rk4singlestep(@(t,y)doublegyreVEC(t,y,A,eps,omega),dt,time,yin);
    yin = yout;    
    if(graphicsON)  
        plot(yout(1,:),yout(2,:),'r.','LineWidth',2,'MarkerSize',4)        
        axis([0 2 0 1])
        drawnow
    end        
end
xT = reshape(yout(1,:,:),length(xvec),length(yvec));
yT = reshape(yout(2,:,:),length(xvec),length(yvec));
save -ASCII A6.dat xT
save -ASCII A7.dat yT

%% Part (c) - Run particles through velocity field
% notice that they stretch a lot!
if(graphicsON) 
    figure 
end;
clear xvec yvec x0 y0 yIC yin yout
xvec = 1.2:.01:1.3;
yvec = .7:.01:.8;
[x0b,y0b] = meshgrid(xvec,yvec);
yIC(1,:,:) = x0b';
yIC(2,:,:) = y0b';
yin = yIC;
for i=1:T/dt
    time = i*dt;   
    yout = rk4singlestep(@(t,y)doublegyreVEC(t,y,A,eps,omega),dt,time,yin);
    yin = yout;    
    if(graphicsON)        
        plot(yout(1,:),yout(2,:),'r.','LineWidth',2,'MarkerSize',4)
        axis([0 2 0 1])
        drawnow
    end        
end
xT = reshape(yout(1,:,:),length(xvec),length(yvec));
yT = reshape(yout(2,:,:),length(xvec),length(yvec));
save -ASCII A8.dat xT
save -ASCII A9.dat yT
telapsed = toc(tstart)