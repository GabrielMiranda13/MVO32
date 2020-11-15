function [F_prop_b,M_prop_C_b,T_l,T_r] = prop_loads(X,U)

global aircraft

i_l_rad = aircraft.i_l_deg*pi/180;
tau_l_rad = aircraft.tau_l_deg*pi/180;
i_r_rad = aircraft.i_r_deg*pi/180;
tau_r_rad = aircraft.tau_r_deg*pi/180;
n_rho = aircraft.n_rho;
Tmax = aircraft.Tmax;
x_l = aircraft.x_l;
y_l = aircraft.y_l;
z_l = aircraft.z_l;
x_r = aircraft.x_r;
y_r = aircraft.y_r;
z_r = aircraft.z_r;

h = X(5);
rho = ISA(h);

throttle_l = U(1);
throttle_r = U(2);

T_l = throttle_l*Tmax*(rho/1.225)^n_rho;
T_r = throttle_r*Tmax*(rho/1.225)^n_rho;

C_tau_l = DCM(3,tau_l_rad);
C_tau_r = DCM(3,tau_r_rad);
C_i_l = DCM(2,i_l_rad);
C_i_r = DCM(2,i_r_rad);

C_lb = C_i_l*C_tau_l;
C_rb = C_i_r*C_tau_r;

F_prop_l_b = C_lb.'*[T_l; 0; 0];
F_prop_r_b = C_rb.'*[T_r; 0; 0];

F_prop_b = F_prop_l_b+F_prop_r_b;

M_prop_C_b = skew([x_l; y_l; z_l])*F_prop_l_b+ ...
             skew([x_r; y_r; z_r])*F_prop_r_b;
