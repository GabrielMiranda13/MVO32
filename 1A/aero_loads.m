function [L,D,Ma]=aero_loads(X,U,flag_cond)

global aircraft

V=X(1);
h=X(5);
S=aircraft.S;
c=aircraft.c;

[CD,CL,Cm]=aero_databank(X,U,flag_cond);

rho=ISA(h);
q_bar=1/2*rho*V^2;

L=q_bar*S*CL;
D=q_bar*S*CD;
Ma=q_bar*S*c*Cm;

end