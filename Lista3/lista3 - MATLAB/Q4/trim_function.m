function [f,X,U,Y] = trim_function(x,trim_par,flag_cond)

% x = [V; alpha_deg; q_deg_s; theta_deg;...
%      phi_deg; p_deg_s; r_deg_s; psi_deg;...  
%      throttle_l; throttle_r; i_t_deg; delta_a_deg; delta_r_deg];

beta_deg_eq = 0;
delta_e_deg_eq = 0;

X = [x(1:4); trim_par(flag_cond).h; 0; beta_deg_eq; x(5:8); 0];
U = [x(9:11); delta_e_deg_eq; x(12:13)];

[Xdot,Y] = dynamics(0,X,U,flag_cond);

C_gamma = DCM(2,trim_par(flag_cond).gamma_deg*pi/180);
C_tv = C_gamma; % C_mu indiferente para decomposição da velocidade
C_vt = C_tv.';

V_t = [trim_par(flag_cond).V; 0; 0];
V_i = C_vt*V_t;

xdot_eq = V_i(1);
ydot_eq = V_i(2);
zdot_eq = V_i(3);
hdot_eq = -zdot_eq;

f = [
    Xdot(1:3)
    Xdot(4)-trim_par(flag_cond).thetadot_deg_s
    Xdot(5)-hdot_eq
    Xdot(6)-xdot_eq
    Xdot(7:10)
    Xdot(11)-trim_par(flag_cond).psidot_deg_s
    Xdot(12)-ydot_eq
    x(9)-x(10) % throttle_l_eq = throttle_r_eq
    ];


end
