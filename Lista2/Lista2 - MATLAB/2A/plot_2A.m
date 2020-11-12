[~,Y_eq]=long_dynamics(0,X_eq,U_eq,flag_cond);

delta_X=X-X_eq';
delta_Y=Y-Y_eq';

figure(5)
subplot(231)
plot(T,delta_X(:,1))
hold all
xlabel('t [s]')
ylabel('\DeltaV [m/s]')

subplot(232)
plot(T,delta_X(:,2))
hold all
xlabel('t [s]')
ylabel('\Delta\alpha [deg]')

subplot(233)
plot(T,delta_X(:,3))
hold all
xlabel('t [s]')
ylabel('\Deltaq [deg/s]')

subplot(234)
plot(T,delta_X(:,4))
hold all
xlabel('t [s]')
ylabel('\Delta\theta [deg]')

subplot(235)
plot(T,delta_X(:,5))
hold all
xlabel('t [s]')
ylabel('\Deltah [m]')

subplot(236)
plot(T,delta_Y(:,1))
hold all
xlabel('t [s]')
ylabel('\Delta\gamma [deg]')