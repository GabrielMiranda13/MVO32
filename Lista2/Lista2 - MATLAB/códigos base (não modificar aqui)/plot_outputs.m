figure(3)
subplot(231)
plot(T,Y(:,1))
xlabel('t [s]')
ylabel('\gamma [deg]')

subplot(232)
plot(T,Y(:,2))
xlabel('t [s]')
ylabel('Thrust [N]')

subplot(233)
plot(T,Y(:,3))
xlabel('t [s]')
ylabel('Mach')

subplot(234)
plot(T,Y(:,4))
xlabel('t [s]')
ylabel('C_D')

subplot(235)
plot(T,Y(:,5))
xlabel('t [s]')
ylabel('C_L')

subplot(236)
plot(T,Y(:,6))
xlabel('t [s]')
ylabel('C_m')