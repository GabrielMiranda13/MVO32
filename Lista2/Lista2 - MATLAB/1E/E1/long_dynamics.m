function [Xdot,Y] = long_dynamics(t,X,U,flag_cond)

global g
global aircraft

V=X(1);
alpha_deg=X(2);
q_deg_s=X(3);
theta_deg=X(4);
h=X(5);
% x=X(6);

throttle=U(1);
% i_t_deg=U(2);
% delta_e_deg=U(3);

m=aircraft.m;
Iyy=aircraft.Iyy;
iota_p_deg=aircraft.i_p_deg;
tau_p_deg=aircraft.t_p_deg;
x_p=aircraft.x_p;
z_p=aircraft.z_p;

[CD,CL,Cm]=aero_databank(X,U,flag_cond);
[rho,~,~,a]=ISA(h);
Mach=V/a;
gamma_deg=theta_deg-alpha_deg;
q_rad_s=q_deg_s*pi/180;

% aerodynamic loads
[L,D,Ma]=aero_loads(X,U,flag_cond);

% propulsive load
Tmax=aircraft.Tmax;
n_rho=aircraft.n_rho;
T=throttle*Tmax*(rho/1.225)^(n_rho);

% equations

% V_dot=1/m*(-D+T*cosd(iota_p_deg+alpha_deg)-m*g*sind(theta_deg-alpha_deg));
% alpha_dot_rad_s=q_rad_s+1/m/V*(-L-T*sind(iota_p_deg+alpha_deg)+m*g*cosd(theta_deg-alpha_deg));
% q_dot_rad_s2=1/Iyy*(Ma+z_p*T*cosd(iota_p_deg)+x_p*T*sind(iota_p_deg));

AA=[cosd(alpha_deg) sind(alpha_deg); -sind(alpha_deg)/V cosd(alpha_deg)/V];
BB=[-D*cosd(alpha_deg)+L*sind(alpha_deg)+2*T*cosd(tau_p_deg)*cosd(iota_p_deg)-m*g*sind(theta_deg);
    -D*sind(alpha_deg)-L*cosd(alpha_deg)-2*T*sind(iota_p_deg)+m*g*cosd(theta_deg)];
CC=[sind(alpha_deg); -cosd(alpha_deg)];
DD=AA*(1/m*BB-q_rad_s*V*CC);

V_dot=DD(1);
alpha_dot_rad_s=DD(2);
q_dot_rad_s2=1/Iyy*(Ma+z_p*2*T*cosd(tau_p_deg)*cosd(iota_p_deg)+x_p*2*T*sind(iota_p_deg));
theta_dot_deg_s=q_deg_s;
h_dot=V*sind(theta_deg-alpha_deg);
x_dot=V*cosd(theta_deg-alpha_deg);

q_dot_deg_s2=q_dot_rad_s2*180/pi;
alpha_dot_deg_s=alpha_dot_rad_s*180/pi;

Xdot=[
        V_dot
        alpha_dot_deg_s
        q_dot_deg_s2
        theta_dot_deg_s
        h_dot
        x_dot
        ];


Y=[
    gamma_deg
    T
    Mach
    CD
    CL
    Cm
    ];


end
