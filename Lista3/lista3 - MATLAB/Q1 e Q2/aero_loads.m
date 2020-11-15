function [F_aero_b,M_aero_C_b] = aero_loads(X,U,flag_cond)

global aircraft

V = X(1);
alpha_deg = X(2);
h = X(5);
beta_deg = X(7);

[CD,CY,CL,Cl,Cm,Cn] = aero_databank(X,U,flag_cond);

rho = ISA(h);

q_bar = 0.5*rho*V^2; 

S = aircraft.S;
c = aircraft.c;
b = aircraft.b;

L = q_bar*S*CL;
D = q_bar*S*CD;
Y = q_bar*S*CY;

La = q_bar*S*b*Cl; 
Ma = q_bar*S*c*Cm;
Na = q_bar*S*b*Cn;

alpha_rad = alpha_deg*pi/180;
beta_rad = beta_deg*pi/180;

C_mbeta = DCM(3,-beta_rad);
C_alpha = DCM(2,alpha_rad);
C_ba = C_alpha*C_mbeta;

F_aero_a = [-D; -Y; -L];
F_aero_b = C_ba*F_aero_a;

M_aero_C_b = [La; Ma; Na];
 
end