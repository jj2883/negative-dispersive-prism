figure
subplot(2,2,1)
x = -2*pi:0.01:2*pi; 
plot(x,sech(x))
title('Sech')
xlabel('Time')
ylabel('Intensity')

% x = [-3:.1:3];
subplot(2,2,2)
norm = normpdf(x,0,1);
plot(x,norm)
title('Gaussian')
xlabel('Time')
ylabel('Intensity')

subplot(2,2,3)
gam=1;
lorentz = 1/pi *(0.5*gam)./(x.^2 +(0.5*gam)^2);
plot(x,lorentz)
title('Lorentzian')
xlabel('Time')
ylabel('Intensity')


subplot(2,2,4)
gam=1;
square = 0.5+0.*xx;
xx = -1:0.1:1;
plot(xx,square)
title('Rectangle')
xlabel('Time')
ylabel('Intensity')