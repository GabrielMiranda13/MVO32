function tau_R = roll_aileron_step(delta_a_deg,T,trim_par,flag_cond)

global aircraft

Cl_p = -0.661;
Cl_delta_a = -2.87e-3*180/pi;
V = trim_par(flag_cond).V;
h = trim_par(flag_cond).h;
rho = ISA(h);
Ixx = aircraft.Ixx;
b = aircraft.b;
S = aircraft.S;
delta_a_rad = delta_a_deg*pi/180;

delta_p_rad_s = -2*V*delta_a_rad*Cl_delta_a/b/Cl_p*(1-exp((1/4/Ixx*rho*V*S*b^2*Cl_p).*T));
delta_phi_rad = -2*V*delta_a_rad*Cl_delta_a/b/Cl_p.*T - ...
        8*Ixx*delta_a_rad*Cl_delta_a/rho/S/b^3/Cl_p^2*(1-exp((1/4/Ixx*rho*V*S*b^2*Cl_p).*T));

delta_p_deg_s = delta_p_rad_s*180/pi;
delta_phi_deg = delta_phi_rad*180/pi;

figure(6)
subplot(211)
plot(T,delta_phi_deg)
hold all
xlabel('t [s]')
ylabel('\Delta\phi [deg]')

subplot(212)
plot(T,delta_p_deg_s)
hold all
xlabel('t [s]')
ylabel('\Deltap [deg/s]')

tau_R = -4*Ixx/(rho*V*S*b^2*Cl_p);

end