clear all; close all;

pH_data = y;
Va = d5;
Vb_vols = 0:0.5:30;
c_int = [1,1];
[fc, fEr] = fminsearch(@(c) rms(pH_data,c,Vb_vols,@strong_AB_titra,Va), c_int)