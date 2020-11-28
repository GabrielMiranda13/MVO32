close all; clear all; clc;

x_CA_wb=0.235;
St_S=0.25;
eta=0.95;
VH_bar=0.42;
epsilonA=0.35;
CLA_wb=0.095*180/pi; % [rad^-1]
CLA_t=0.075*180/pi; % [rad^-1]

CheA_t=-0.0045*180/pi; % [rad^-1]
CheE=-0.0065*180/pi; % [rad^-1]
Che0=-0.005;
Se_St=0.35;

raizes=roots([0.342 -0.0287 0.6028 0.239 -Se_St]); % regressão da questão 2
v_tau=raizes(4); % raízes reais e positivas

for i=1:length(v_tau)
    tau=v_tau(i);
    dCLt_dE=tau*CLA_t; % fórmula contida no enunciado

    CLA=CLA_wb+eta*St_S*CLA_t*(1-epsilonA);
    CLE=eta*St_S*dCLt_dE;

    f=1-dCLt_dE*(1/CLA_t)*(CheA_t/CheE);
    F=1-(CLE/CLA)*(CheA_t/CheE)*(1-epsilonA);

    xn(i)=x_CA_wb+(f/F)*eta*VH_bar*(1-epsilonA)*CLA_t/CLA;
end

