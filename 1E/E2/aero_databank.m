function [CD,CL,Cm] = aero_databank(X,U,flag_cond)

global aircraft

switch flag_cond
    case 1
        % A1 flight condition:
        CL_0 = 0.308;
        CL_alpha = 0.133;
        CL_q = 16.7;
        CL_it = 0.0194;
        CL_delta_e = 0.00895; 
        CD_0 = 0.02207;
        CD_alpha = 0.00271;
        CD_alpha2 = 6.03e-4;
        CD_q2 = 35.904;
        CD_it = -4.2e-4;
        CD_it2 = 1.34e-4;
        CD_delta_e2 = 4.61e-5;
        Cm_0 = 0.017;
        Cm_alpha = -0.0402;
        Cm_q = -57;
        Cm_it = -0.0935;
        Cm_delta_e = -0.0448;
    case 2
        % A2 flight condition:
    case 3
        % A3 flight condition:
end

DX_CG = aircraft.DX_CG;

% CG displacement corrections
Cm_0 = Cm_0+CL_0*DX_CG;
Cm_alpha = Cm_alpha+CL_alpha*DX_CG;
CL_q = CL_q-DX_CG*(CL_alpha*180/pi);
Cm_q = Cm_q-DX_CG*(-CL_q+Cm_alpha*180/pi)-(DX_CG^2)*CL_alpha*180/pi;
Cm_it = Cm_it+DX_CG*CL_it;
Cm_delta_e = Cm_delta_e+DX_CG*CL_delta_e;

V = X(1);
alpha_deg = X(2);
q_deg_s = X(3);

i_t_deg = U(2);
delta_e_deg = U(3);

q_rad_s = q_deg_s*pi/180;

c = aircraft.c;

CL = CL_0 + ...
    CL_alpha*alpha_deg + ...
    CL_q*(q_rad_s*c/(2*V))+ ...
    CL_it*i_t_deg+ ...
    CL_delta_e*delta_e_deg;

CD = CD_0 + ...
    CD_alpha*alpha_deg + ...
    CD_alpha2*alpha_deg^2 + ...
    CD_q2*(q_rad_s*c/(2*V))^2 + ...
    CD_it*i_t_deg+ ...
    CD_it2*i_t_deg^2+ ...
    CD_delta_e2*delta_e_deg^2;

Cm = Cm_0 + ...
    Cm_alpha*alpha_deg + ...
    Cm_q*(q_rad_s*c/(2*V))+ ...
    Cm_it*i_t_deg+ ...
    Cm_delta_e*delta_e_deg;

