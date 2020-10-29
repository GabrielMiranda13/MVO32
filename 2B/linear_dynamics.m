function [Xdot,Y] = linear_dynamics(t,X,U,flag_cond)

global g
global aircraft
global trim_output
global lin_output

V=X(1);
alpha_deg=X(2);
% q_deg_s=X(3);
theta_deg=X(4);
h=X(5);
% x=X(6);

throttle=U(1);
% i_t_deg=U(2);
% delta_e_deg=U(3);

[CD,CL,Cm]=aero_databank(X,U,flag_cond);
[rho,~,~,a]=ISA(h);
Mach=V/a;
gamma_deg=theta_deg-alpha_deg;

% aerodynamic loads
[L,D,Ma]=aero_loads(X,U,flag_cond);

% propulsive load
Tmax=aircraft.Tmax;
n_rho=aircraft.n_rho;
T=throttle*Tmax*(rho/1.225)^(n_rho);

X_eq=trim_output(flag_cond).X_eq;
U_eq=trim_output(flag_cond).U_eq;
A=lin_output(flag_cond).A;
B=lin_output(flag_cond).B;

Xdot_eq=long_dynamics(0,X_eq,U_eq,flag_cond);

Xdot= Xdot_eq+A*(X-X_eq)+B*(U-U_eq);

Y=[
    gamma_deg
    T
    Mach
    CD
    CL
    Cm
    ];

end