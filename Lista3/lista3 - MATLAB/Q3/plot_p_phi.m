figure(6)

subplot(211)
plot(T,deltaX(:,8))
hold all
xlabel('t [s]')
ylabel('\Delta\phi [deg]')

subplot(212)
plot(T,deltaX(:,9))
hold all
xlabel('t [s]')
ylabel('\Deltap [deg/s]')