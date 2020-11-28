close all; clear all; clc;

S=20; %  [m^2]
c=2; % [m]
AR_t=4.85;
AR_w=7.3;
x_CG=0.1; % [m]
l_t=4.5; % = x_CA_t - x_CG [m]
eta=1;
CL0_wb=0.26;
CLA_wb=0.07*180/pi; % [rad^-1]
CL0_t=0;
CLA_t=0.073*180/pi; % [rad^-1]
Cm_CA_t=0;


% TRABALHANDO COM AS EQUAÇÕES DA ASA-FUSELAGEM
syms Cm_CA_wb l_wb; % l_wb = x_CA_wb - x_CG (análogo ao l_t)
EQ1=Cm_CA_wb+CL0_wb*(-l_wb)+0.05; % Cm0_CG_wb==-0.05
EQ2=CLA_wb*(-l_wb)+0.0035*180/pi; % CmA_CG_wb==-0.0035*180/pi
sol=solve([EQ1;EQ2]==0);
Cm_CA_wb=double(sol.Cm_CA_wb);
l_wb=double(sol.l_wb);


% TRABALHANDO COM AS EQUAÇÕES DA AERONAVE COMPLETA
syms S_t i_t c_t; % c_t poderia não ser computado, pois sua dependência irá se anular por Cm_CA_t=0
VH=S_t/S*l_t/c;
epsilonA=2*CLA_wb/pi/AR_w;
epsilon0=2*CL0_wb/pi/AR_w;
EQ3=Cm_CA_wb+CL0_wb*(-l_wb)+eta*(S_t/S)*(c_t/c)*Cm_CA_t-eta*VH*(CL0_t-CLA_t*epsilon0)-eta*VH*CLA_t*i_t-0.15; % Cm0_CG+CmIt_CG*i_t==0.15
EQ4=CLA_wb*(-l_wb)-eta*VH*(CLA_t*(1-epsilonA))+0.025*180/pi; % CmA_CG==-0.025
sol=solve([EQ3;EQ4]==0);
S_t=double(sol.S_t); % obtenção de S_t (letra a)
i_t=double(sol.i_t); % obtenção de i_t (letra b)

