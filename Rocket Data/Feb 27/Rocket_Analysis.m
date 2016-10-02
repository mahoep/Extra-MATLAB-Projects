%% K so here we go boys
% Importing Data Into Matlab
tic


a_x = importdata('a_x.dat');
a_y = importdata('a_y.dat');
a_z = importdata('a_z.dat');
agl = importdata('agl.dat');
avionics = importdata('avionics.dat');
delta = importdata('delta.dat');
g_x = importdata('g_x.dat');
g_y = importdata('g_y.dat');
g_z = importdata('g_z.dat');
gps_fix = importdata('gps_fix.dat');
gps_time = importdata('gps_time.dat');
lat = importdata('lat.dat');
long = importdata('long.dat');
temp = importdata('temp.dat');
time = importdata('time.dat');

t_tot = sum(delta);  % total time elapsed
dt_avg = t_tot/numel(delta);  % average delta value
time_t = zeros(230149,1);    % pre allocation of new time matrix

time_t(1) = 0.04033;  %inital value for loop to work 
for i = 2:numel(delta);  % Summing each value of delta progressivelty to get linear time
    time_t(i) = delta(i)+time_t(i-1);
end

time_flight = time_t(128000:140000) - time_t(128000); % ommiting time values before the launch 
agl_actual = agl(128000:140000);    % ommiting values before launch

plot(time_flight,agl_actual,'b')
title('Altitude vs. Time')
xlabel('time (seconds)')
ylabel('Altitude (meters)')


[M,L] = max(agl); % Finding max altitude, M is actual value, L is entry #

descentagl = agl(L:135278); % agl data points from max alt to roughly 420m
descenttime = time_t(L:135278); % time data points from max alt to roughly 420m

figure
plot(descentagl,descenttime,'b')
title('Descent Path')
xlabel('time (seconds)')
ylabel('Altitude (meters)')

descent = polyfit(descenttime, descentagl, 1); % poly fit to the descent line
descentspeed = descent(1); % represents the slope of the descent line (m/s)

accel_z = a_x.*-9.8066; % acceleration converted to m/s^2
accel_zflight = accel_z(128000:140000);
figure
plot(time_flight,accel_zflight,'b');
toc
%%
% h = animatedline;
% axis([0 450 0 7000])
% 
% x = time_flight;
% y = agl_actual;
% for k = 1:length(x);
%     addpoints(h,x(k),y(k));
%     pause(dt_avg);
%     drawnow
% end
