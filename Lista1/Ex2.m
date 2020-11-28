close all; clear all; clc;

VH=0.7;
eta=1.05;
CLA_t=4.1; % [rad^-1]
S_t=7; % [m^2]
alpha=10; % [deg]

dE=linspace(-20,25,1e3); % batentes do profundor [deg]

for i=1:length(dE)
    tau(i)=(-0.33-0.044*alpha)/(eta*VH*CLA_t*dE(i)*pi/180);
end

figure
plot(dE,tau)
S_e=(0.342*tau.^4-0.0287*tau.^3+0.6028*tau.^2+0.239*tau)*S_t;

figure
plot(dE,S_e)
axis([xlim 0 10])
grid on
xlabel('\delta_e')
ylabel('S_e')

S_e_min=min(S_e); % área mínima necessária para equilibrar