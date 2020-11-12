figure(3)
subplot(231)
plot(T,Y(:,1))
hold all
xlabel('t [s]')
ylabel('\gamma [deg]')

subplot(232)
plot(T,Y(:,2))
hold all
xlabel('t [s]')
ylabel('Thrust [N]')

subplot(233)
plot(T,Y(:,3))
hold all
xlabel('t [s]')
ylabel('Mach')

subplot(234)
plot(T,Y(:,4))
hold all
xlabel('t [s]')
ylabel('C_D')

subplot(235)
plot(T,Y(:,5))
hold all
xlabel('t [s]')
ylabel('C_L')

subplot(236)
plot(T,Y(:,6))
hold all
xlabel('t [s]')
ylabel('C_m')