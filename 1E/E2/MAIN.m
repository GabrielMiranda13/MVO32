clear all
close all
clc

global g
global aircraft

g = 9.80665;

Kn_array=-0.1:0.01:0.3;
Values=zeros(length(Kn_array),4);

for index=1:length(Kn_array)
    
    % CG dislpacement 
    Kn = Kn_array(index); % escolher margem estática
    Cm_alpha = -0.0402;
    CL_alpha = 0.133;
    DX_CG = -Kn-Cm_alpha/CL_alpha;

    aircraft = struct('S',116,'c',3.862,'b',32.757,...
        'm',55788,'Iyy',3.344e6,'DX_CG',DX_CG,... % DX_CG (displacement CG)
        'i_p_deg',2,'t_p_deg',1.5,'x_p',4.899,'z_p',1.435,... 
        'Tmax',100000,'n_rho',0.8);

    trim_par(1) = struct('V',230.15,'h',11582.4,'gamma_deg',0,...
        'thetadot_deg_s',0);
    %--------------------------------------------------------------------------

    % https://www.mathworks.com/help/optim/ug/tolerances-and-stopping-criteria.html
    options = optimset('Display','iter','TolX',1e-10,'TolFun',1e-10);
    % % In newer MATLAB versions, the following command might be necessary:
    % options = optimoptions(@fsolve,'Display','iter','StepTolerance',1e-10,'FunctionTolerance',1e-10);
    % % or:
    % options = optimoptions(@fsolve,'Display','iter','TolX',1e-10,'TolFun',1e-10);

    %--------------------------------------------------------------------------
    % Trimmed flight conditions:

    trim_output(length(trim_par)) = struct('X_eq',zeros(6,1),'U_eq',zeros(3,1),...
        'Y_eq',zeros(6,1));

    for flag_cond=1:length(trim_par)
        x_eq_0 = zeros(4,1);
        x_eq = fsolve(@trim_function,x_eq_0,options,trim_par,flag_cond);
        [~,X_eq,U_eq,Y_eq] = trim_function(x_eq,trim_par,flag_cond);

        trim_output(flag_cond).X_eq = X_eq;
        trim_output(flag_cond).U_eq = U_eq;
        trim_output(flag_cond).Y_eq = Y_eq;

    %     fprintf('\n----- A%d FLIGHT CONDITION -----\n\n',flag_cond);
    %     fprintf('   %-10s = %10.4f %-4s\n','gamma',trim_par(flag_cond).gamma_deg,'deg');
    %     fprintf('   %-10s = %10.4f %-4s\n','theta_dot',trim_par(flag_cond).thetadot_deg_s,'deg/s');
    %     fprintf('\n');
    %     fprintf('   %-10s = %10.2f %-4s\n','V',X_eq(1),'m/s');
    %     fprintf('   %-10s = %10.4f %-4s\n','alpha',X_eq(2),'deg');
    %     fprintf('   %-10s = %10.4f %-4s\n','q',X_eq(3),'deg/s');
    %     fprintf('   %-10s = %10.4f %-4s\n','theta',X_eq(4),'deg');
    %     fprintf('   %-10s = %10.1f %-4s\n','h',X_eq(5),'m');
    %     fprintf('\n');
    %     fprintf('   %-10s = %10.2f %-4s\n','throttle',U_eq(1)*100,'%');
    %     fprintf('   %-10s = %10.2f %-4s\n','Thrust',Y_eq(2),'N');
    %     fprintf('   %-10s = %10.4f %-4s\n','i_t',U_eq(2),'deg');
    %     fprintf('   %-10s = %10.4f %-4s\n','delta_e',U_eq(3),'deg');
    %     fprintf('\n');
    %     fprintf('   %-10s = %10.4f %-4s\n','Mach',Y_eq(3),'');
    %     fprintf('   %-10s = %10.4f %-4s\n','C_D',Y_eq(4),'');
    %     fprintf('   %-10s = %10.4f %-4s\n','C_L',Y_eq(5),'');
    %     fprintf('   %-10s = %10.4f %-4s\n','C_m',Y_eq(6),'');
    %     fprintf('\n');
    end
    
    %                alpha | i_t | throttle | thrust
    Values(index,:)=[X_eq(2) U_eq(2) U_eq(1) Y_eq(2)];
end

figure(1)
subplot(2,2,1)
plot(100*Kn_array,Values(:,1))
hold all
xlabel('K_n [%]')
ylabel('\alpha [deg]')

subplot(2,2,2)
plot(100*Kn_array,Values(:,2))
hold all
xlabel('K_n [%]')
ylabel('i_t [deg]')

subplot(2,2,3)
plot(100*Kn_array,Values(:,3)*100)
hold all
xlabel('K_n [%]')
ylabel('Throttle [%]')

subplot(2,2,4)
plot(100*Kn_array,Values(:,4))
hold all
xlabel('K_n [%]')
ylabel('Thrust [N]')

