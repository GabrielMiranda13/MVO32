close all; clear all; clc;

rho_0=1.225; % [kg/m^3]
S=16.21; % [m^2]
g=9.81; % [m/s^2]

VE=[40.7 48.7 56.3 69.3 39.8 46.9 55 67.5 38.9 46 54.5 68]'; % [m/s]
M=[1656 1650 1649 1646 1466 1463 1461 1458 1293 1290 1288 1286]'; % [kg]
it=[-1.5 0 1 2 -4.5 -2 -0.3 1 -7.2 -3.5 -1.5 0]'; % [deg]
x_CG=[238.5 238.5 238.5 238.5 220.5 220.5 220.5 220.5 204.3 204.3 204.3 204.3]'; % [cm]

CL=2*M*g./(VE.^2*rho_0*S);

hold on
plot(CL(1:4),it(1:4),'.-','DisplayName','x_{CG}=238.5 cm')
plot(CL(5:8),it(5:8),'.-','DisplayName','x_{CG}=220.5 cm')
plot(CL(9:12),it(9:12),'.-','DisplayName','x_{CG}=204.3 cm')
legend('Location','SouthWest')
grid on
xlabel('C_L (deg)')
ylabel('i_t')

dit_dCL(1)=polyfit(CL(1:4),it(1:4),1)*[1 0]';
dit_dCL(2)=polyfit(CL(5:8),it(5:8),1)*[1 0]';
dit_dCL(3)=polyfit(CL(9:12),it(9:12),1)*[1 0]';

figure
plot([238.5 220.5 204.3], dit_dCL,'.-')
ylabel('$\frac{\partial i_t}{\partial C_L}$','Interpreter','latex')
xlabel('x_{CG}')
grid on

x_PN=polyfit(dit_dCL,[238.5 220.5 204.3],1)*[0 1]'; % posição do ponto neutro
