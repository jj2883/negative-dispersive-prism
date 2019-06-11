%Lorentz signal generation aloong with their attractor plot and histogram%
close all;
clear all;
clc;
ti=0;
tf=1000;
tspan=[ti tf];
x0=[0.3 0.3 0.3]';
[t,x]= ode23('lorenz',tspan,x0);
figure
subplot(3,1,1), plot(t,x(:,1),'r'),grid on;
title('Lorenz Attractor'),ylabel('x1(t)');

figure
subplot(3,1,1),plot(hist(x(:,1)));
title('x1 histogram'),ylabel('x1(t)'),grid on;
%modulation test1%
bi=input('Enter the input binary sequence');
N=length(bi);
figure
stem(bi);
r1=randn(1,length(transpose(x(:,1))));% for 1st cahotic signal
figure
subplot(3,1,1),plot(t,r1);
title('r1 random noise'),ylabel('r1(t)'),grid on;

auto1=xcorr(x(:,1),x(:,1));
figure;
plot(auto1);

%length padding
N1=length(r1);
p1=N1-N;
b=padarray(bi,[0 p1],'post');

%modulation test fro signal 1%
k1=transpose(x(:,1))+b;% modulated signal
figure
subplot(3,1,1),plot(t,k1);
title('modualted Signal fro 1st Chaos'),ylabel('k1(t)'),grid on;
m1=k1+r1;% modulated signal with random noise
subplot(3,1,2),plot(t,m1);
title('modualted Signal with random signal'),ylabel('m1(t)'),grid on;

o1=m1-transpose(x(:,1));
figure;
plot(o1);
xlabel('time');
ylabel('amplitude');
title('recieved signal with chaos signal cancellation ');