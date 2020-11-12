deltaX = X-X_eq';

figure(2)
subplot(231)
plot(T,deltaX(:,7))
hold all
xlabel('t [s]')
ylabel('\Delta\beta [deg]')

subplot(232)
plot(T,deltaX(:,8))
hold all
xlabel('t [s]')
ylabel('\Delta\phi [deg]')

subplot(233)
plot(T,deltaX(:,9))
hold all
xlabel('t [s]')
ylabel('\Deltap [deg/s]')

subplot(234)
plot(T,deltaX(:,10))
hold all
xlabel('t [s]')
ylabel('\Deltar [deg/s]')

subplot(235)
plot(T,deltaX(:,11))
hold all
xlabel('t [s]')
ylabel('\Delta\psi [deg]')

subplot(236)
plot(T,deltaX(:,12))
hold all
xlabel('t [s]')
ylabel('\Deltay [m]')