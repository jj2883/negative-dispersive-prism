x = [-3:.1:3];
norm = normpdf(x,0,1);
figure
subplot(2,1,1)
plot(norm)
title('Gaussian Pulse')
xlabel('time')
ylabel ('Arbitrary Unit')
subplot(2,1,2)
env2 = conv(norm,norm);
plot(env2);
title('AutoCorrelation')
xlabel('time')
ylabel ('Arbitrary Unit')

