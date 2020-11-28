function [CD,CY,CL,Cl,Cm,Cn] = aero_databank(X,U,flag_cond)

global aircraft 
global count

switch flag_cond
    case 1
        % A1 flight condition:
        CL_0 = 0.308;
        CL_alpha = 0.133*180/pi;
        CL_q = 16.7;
        CL_it = 0.0194*180/pi;
        CL_delta_e = 0.00895*180/pi;       
        CD_0 = 0.02207;
        CD_alpha = 0.00271*180/pi;
        CD_alpha2 = 6.03e-4*(180/pi)^2;
        CD_q2 = 35.904;
        CD_it = -4.2e-4*180/pi;
        CD_it2 = 1.34e-4*(180/pi)^2;
        CD_delta_e2 = 4.61e-5*(180/pi)^2;
        CD_beta2 = 1.6e-4*(180/pi)^2;
        CD_p2 = 0.5167;
        CD_r2 = 0.5738;
        CD_delta_a2 = 3e-5*(180/pi)^2;
        CD_delta_r2 = 1.81e-5*(180/pi)^2;        
        Cm_0 = 0.017;
        Cm_alpha = -0.0402*180/pi;
        Cm_q = -57;
        Cm_it = -0.0935*180/pi;
        Cm_delta_e = -0.0448*180/pi;       
        CY_beta = 0.0228*180/pi;
        CY_p = 0.084;
        CY_r = -1.21;
        CY_delta_a = 2.36e-4*180/pi;
        CY_delta_r = -5.75e-3*180/pi;        
        Cl_beta = -3.66e-3*180/pi;
        Cl_p = -0.661;
        Cl_r = 0.254;
        Cl_delta_a = -2.87e-3*180/pi;
        Cl_delta_r = 6.76e-4*180/pi;       
        Cn_beta = 5.06e-3*180/pi;
        Cn_p = -0.219;
        Cn_r = -0.634;
        Cn_delta_a = 1.5e-4*180/pi;
        Cn_delta_r = -3.26e-3*180/pi;
end

switch count
    case 0
        % NOMINAL
    case 1
        Cl_beta = 1.2*Cl_beta;
    case 2
        Cn_beta = 1.2*Cn_beta;
    case 3
        CY_beta = 1.2*CY_beta;
    case 4
        Cl_p = 1.2*Cl_p;
    case 5
        Cn_p = 1.2*Cn_p;
    case 6
        CY_p = 1.2*CY_p;
    case 7
        Cl_r = 1.2*Cl_r;
    case 8
        Cn_r = 1.2*Cn_r;
    case 9
        CY_r = 1.2*CY_r;
    case 10
        Cl_beta = 0.8*Cl_beta;
    case 11
        Cn_beta = 0.8*Cn_beta;
    case 12
        CY_beta = 0.8*CY_beta;
    case 13
        Cl_p = 0.8*Cl_p;
    case 14
        Cn_p = 0.8*Cn_p;
    case 15
        CY_p = 0.8*CY_p;
    case 16
        Cl_r = 0.8*Cl_r;
    case 17
        Cn_r = 0.8*Cn_r;
    case 18
        CY_r = 0.8*CY_r;
end

V = X(1);
alpha_deg = X(2);
q_deg_s = X(3);
beta_deg = X(7);
p_deg_s = X(9);
r_deg_s = X(10);

i_t_deg = U(3);
delta_e_deg = U(4);
delta_a_deg = U(5);
delta_r_deg = U(6);

alpha_rad = alpha_deg*pi/180;
beta_rad = beta_deg*pi/180;

p_rad_s = p_deg_s*pi/180;
q_rad_s = q_deg_s*pi/180;
r_rad_s = r_deg_s*pi/180;

i_t_rad = i_t_deg*pi/180;
delta_e_rad = delta_e_deg*pi/180;
delta_a_rad = delta_a_deg*pi/180;
delta_r_rad = delta_r_deg*pi/180;

c = aircraft.c;
b = aircraft.b;

CL = CL_0 + ...
    CL_alpha*alpha_rad + ...
    CL_q*(q_rad_s*c/(2*V))+ ...
    CL_it*i_t_rad+ ...
    CL_delta_e*delta_e_rad;

CD = CD_0 + ...
    CD_alpha*alpha_rad + ...
    CD_alpha2*alpha_rad^2 + ...
    CD_q2*(q_rad_s*c/(2*V))^2+ ...
    CD_it*i_t_rad+ ...
    CD_it2*i_t_rad^2+ ...
    CD_delta_e2*delta_e_rad^2+ ...
    CD_beta2*beta_rad^2+ ...
    CD_p2*(p_rad_s*b/(2*V))^2+ ...
    CD_r2*(r_rad_s*b/(2*V))^2+ ...
    CD_delta_a2*delta_a_rad^2+ ...
    CD_delta_r2*delta_r_rad^2;

Cm = Cm_0 + ...
    Cm_alpha*alpha_rad + ...
    Cm_q*(q_rad_s*c/(2*V))+ ...
    Cm_it*i_t_rad+ ...
    Cm_delta_e*delta_e_rad;

CY = CY_beta*beta_rad+ ...
    CY_p*(p_rad_s*b/(2*V))+ ...
    CY_r*(r_rad_s*b/(2*V))+ ...
    CY_delta_a*delta_a_rad+ ...
    CY_delta_r*delta_r_rad;

Cl = Cl_beta*beta_rad+ ...
    Cl_p*(p_rad_s*b/(2*V))+ ...
    Cl_r*(r_rad_s*b/(2*V))+ ...
    Cl_delta_a*delta_a_rad+ ...
    Cl_delta_r*delta_r_rad;

Cn = Cn_beta*beta_rad+ ...
    Cn_p*(p_rad_s*b/(2*V))+ ...
    Cn_r*(r_rad_s*b/(2*V))+ ...
    Cn_delta_a*delta_a_rad+ ...
    Cn_delta_r*delta_r_rad;
