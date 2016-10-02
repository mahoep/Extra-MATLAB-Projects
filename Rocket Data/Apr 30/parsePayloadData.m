clear;clc;close all;
addpath 'osu_rocketry_data-master/payload_data/launch_20160430';

% csvData = csvread('avionics_data.log.csv',1,0);
csvData = csvread('payload_flight_launch2.log.csv',1,0);
C = num2cell(csvData,1);      % convert every column to a cell
[delta, avionics, g_x, g_y, g_z, a_x, a_y, a_z, lat, long, agl, temp, time, gps_fix, gps_time, start_cut, arm_cut, m_z, m_y, m_x, state] = deal(C{:}); % assign to variables
clear csvData C;

time = (time - time(1))/1000;


% drogueSpeed = (agl(2000) - agl(7000)) / (time(2000) - time(7000));
% mainSpeed = (agl(7300) - agl(9300)) / (time(7300) - time(9300));

% a = (a_x - 1) * 9.81;
% v = cumtrapz(time,a);
% plotyy(time,agl,time,v);

a = (a_y.^2 + a_z.^2).^.5;
a = a(1:2000);