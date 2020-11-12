figure(2)
subplot(221)
plot(T,U(:,1)*100)
hold all
xlabel('t [s]')
ylabel('Throttle [%]')

subplot(222)
plot(T,U(:,2))
hold all
xlabel('t [s]')
ylabel('i_t [deg]')

subplot(223)
plot(T,Y(:,2))
hold all
xlabel('t [s]')
ylabel('Thrust [N]')

subplot(224)
plot(T,U(:,3))
hold all
xlabel('t [s]')
ylabel('\delta_e [deg]')
