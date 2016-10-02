clear all; close all; clc

x0 = 10;
[xf] = fminsearch(@fcn1,x0);
