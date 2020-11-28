close all; clear all; clc;

x_CA_wb=0.235;
St_S=0.25;
eta=0.95;
VH_bar=0.42;
epsilonA=0.35;
CLA_wb=0.095*180/pi; % [rad^-1]
CLA_t=0.075*180/pi; % [rad^-1]

CLA=CLA_wb+eta*St_S*CLA_t*(1-epsilonA);
xn=x_CA_wb+eta*VH_bar*(1-epsilonA)*CLA_t/CLA;