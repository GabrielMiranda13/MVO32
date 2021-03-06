function [Xdot,Y] = dynamics(t,X,U,flag_cond)

global g
global aircraft
global trim_output
global lin_output

V = X(1);
alpha_deg = X(2);
q_deg_s = X(3);
theta_deg = X(4);
h = X(5);
% x = X(6);

beta_deg = X(7);
phi_deg = X(8);
p_deg_s = X(9);
r_deg_s = X(10);
psi_deg = X(11);
% y = X(12);

% throttle_l = U(1);
% throttle_r = U(2);
% i_t_deg = U(3);
% delta_e_deg = U(4);
% delta_a_deg = U(5);
% delta_r_deg = U(6);

alpha_rad = alpha_deg*pi/180;
beta_rad = beta_deg*pi/180;
psi_rad = psi_deg*pi/180;
theta_rad = theta_deg*pi/180;
phi_rad = phi_deg*pi/180;


C_mbeta = DCM(3,-beta_rad);
C_alpha = DCM(2,alpha_rad);
C_psi = DCM(3,psi_rad);
C_theta = DCM(2,theta_rad);
C_phi = DCM(1,phi_rad);

C_ba = C_alpha*C_mbeta;
C_bv = C_phi*C_theta*C_psi;
C_ab = C_ba.';

[~,~,T_l,T_r] = prop_loads(X,U);

[CD,CY,CL,Cl,Cm,Cn] = aero_databank(X,U,flag_cond);

[~,~,~,a] = ISA(h);
Mach = V/a;

C_tv = C_ab*C_bv;
gamma_deg = -asind(C_tv(1,3));

X_eq = trim_output(flag_cond).X_eq;
U_eq = trim_output(flag_cond).U_eq;
Xdot_eq = trim_output(flag_cond).Xdot_eq;
A = lin_output(flag_cond).A;
B = lin_output(flag_cond).B;

Xdot = Xdot_eq+A*(X-X_eq)+B*(U-U_eq);

Y = [
    gamma_deg
    T_l
    T_r
    Mach
    CD
    CL
    Cm
    CY
    Cl
    Cn
    ];
