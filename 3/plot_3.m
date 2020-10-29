[~,Y_eq]=long_dynamics(0,X_eq,U_eq,flag_cond);

delta_X=X-X_eq';
delta_Y=Y-Y_eq';

figure(5)
subplot(2,1,1)
plot(T,delta_X(:,2))
hold all
xlabel('t [s]')
ylabel('\Delta\alpha [deg]')

subplot(2,1,2)
plot(T,delta_X(:,3))
hold all
xlabel('t [s]')
ylabel('\Deltaq [deg/s]')