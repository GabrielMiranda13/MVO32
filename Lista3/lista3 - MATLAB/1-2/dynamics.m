function [Xdot,Y] = dynamics(t,X,U,flag_cond)

global g
global aircraft

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
p_rad_s = p_deg_s*pi/180;
q_rad_s = q_deg_s*pi/180;
r_rad_s = r_deg_s*pi/180;

omega_b = [p_rad_s; q_rad_s; r_rad_s];

C_mbeta = DCM(3,-beta_rad);
C_alpha = DCM(2,alpha_rad);
C_psi = DCM(3,psi_rad);
C_theta = DCM(2,theta_rad);
C_phi = DCM(1,phi_rad);

C_ba = C_alpha*C_mbeta;
C_bv = C_phi*C_theta*C_psi;
C_ab = C_ba.';
C_vb = C_bv.';

V_a = [V; 0 ; 0];
V_b = C_ba*V_a;

g_v = [0; 0; g];
g_b = C_bv*g_v;

[F_aero_b,M_aero_C_b] = aero_loads(X,U,flag_cond);
[F_prop_b,M_prop_C_b,T_l,T_r] = prop_loads(X,U);

m = aircraft.m;

V_b_dot = 1/m*(F_aero_b + F_prop_b) + g_b - skew(omega_b)*V_b;

Ixx = aircraft.Ixx;
Iyy = aircraft.Iyy;
Izz = aircraft.Izz;
Ixz = aircraft.Ixz;

J_C_b = [
        Ixx 0 -Ixz
        0 Iyy 0
        -Ixz 0 Izz
        ];

omega_b_dot = J_C_b\(M_aero_C_b + M_prop_C_b - skew(omega_b)*J_C_b*omega_b);

u = V_b(1);
v = V_b(2);
w = V_b(3);

udot = V_b_dot(1);
vdot = V_b_dot(2);
wdot = V_b_dot(3);

pdot_rad_s2 = omega_b_dot(1);
qdot_rad_s2 = omega_b_dot(2);
rdot_rad_s2 = omega_b_dot(3);

pdot_deg_s2 = pdot_rad_s2*180/pi;
qdot_deg_s2 = qdot_rad_s2*180/pi;
rdot_deg_s2 = rdot_rad_s2*180/pi;

Vdot = (u*udot + v*vdot + w*wdot)/V;
alphadot_rad_s = (u*wdot - w*udot)/(u^2 + w^2);
betadot_rad_s = (V*vdot - v*Vdot)/(V*sqrt(u^2 + w^2));

alphadot_deg_s = alphadot_rad_s*180/pi;
betadot_deg_s = betadot_rad_s*180/pi;

I_3 = eye(3);
e_31 = I_3(:,1);
K_phi = [e_31 C_phi(:,2) C_bv(:,3)];

Phidot_rad_s = K_phi\omega_b;
 
phidot_rad_s = Phidot_rad_s(1);
thetadot_rad_s = Phidot_rad_s(2);
psidot_rad_s = Phidot_rad_s(3);
phidot_deg_s = phidot_rad_s*180/pi;
thetadot_deg_s = thetadot_rad_s*180/pi;
psidot_deg_s = psidot_rad_s*180/pi;

RC_dot = C_vb*V_b;
xdot = RC_dot(1);
ydot = RC_dot(2);
zdot = RC_dot(3);
hdot = -zdot;

Xdot = [
    Vdot
    alphadot_deg_s
    qdot_deg_s2
    thetadot_deg_s
    hdot
    xdot
    betadot_deg_s
    phidot_deg_s
    pdot_deg_s2
    rdot_deg_s2
    psidot_deg_s
    ydot
    ];

[CD,CY,CL,Cl,Cm,Cn] = aero_databank(X,U,flag_cond);

[~,~,~,a] = ISA(h);
Mach = V/a;

C_tv = C_ab*C_bv;
gamma_deg = -asind(C_tv(1,3));

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
