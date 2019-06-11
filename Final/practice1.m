clear all;
close all;

%%Collected Data
%original data collection
x_delay1 =[16.410 16.415 16.420 16.422 16.424 16.426 16.428 16.430 16.432 16.433 16.434 16.435 16.436 16.437 16.438 16.439 16.440 16.441 16.442 16.443 16.444 16.445 16.446 16.447 16.448 16.449 16.450 16.451 16.452 16.453 16.454 16.455 16.456 16.457 16.458 16.459 16.460 16.461 16.462 16.463 16.464 16.465 16.466 16.467 16.468 16.469 16.470];
y_intensity =[8.6 11.9 16 18.6 17.4 14.4 15.5 18.5 25.5 33 34 36 36 34 31 35 50 56 115 155 222 252 321 329 318 292 226 171 142 95 67 53 48 37 35 35 33 29 27 22 20 13.5 13.1 13.6 14.4 15 17];

%delta x in meters
delta_x_delay = (x_delay1 - 16.410).*0.001;

%delta x in seconds
delta_t_delay = 2/299700000 .*delta_x_delay;

figure
subplot(2, 1, 1);
plot(delta_x_delay, y_intensity)
title('AutoCorreelation Displacement Profile')
xlabel('Displacement (m)')
ylabel('Intensity')

subplot(2, 1, 2);
plot(delta_t_delay, y_intensity)
title('AutoCorreelation Delay Profile')
xlabel('Displacement (s)')
ylabel('Intensity')


%%Compare Lorentzian and Guassian Curve Fit
figure
x= delta_t_delay;
y= y_intensity;
subplot(2, 1, 1);
f1 = fit(x.',y.','gauss1')
plot(f1,x,y)
title('Guass1')

lorentz1=lorentzfit(x,y);
subplot(2,1,2)
plot(x,y);
hold on
plot(x,lorentz1)
title('Lorentz')
hold off

%% Guassian in time
    %f1 = fit(x.',y.','gauss1') gives the parameter for Guassian Equation
    % Coefficients (with 95% confidence bounds):
       a1 =       349.5;%  (326.5, 372.6)
       %center at 0
       b1 =   0;%   2.469e-13;%  (2.45e-13, 2.488e-13)
       c1 =   2.877e-14;%  (fixed at bound)
       
    %increase delay time from -200fs to 200fs in increments of 10fs
    x_gauss = -2*10^(-13):0.1*10^(-14):2*10^(-13); 
       
    %plug into gaussian curve       
    y_gauss =  a1.*exp(-((x_gauss-b1)./c1).^2);

    figure
    plot(x_gauss,y_gauss);
    title('Plotted Fitted Gauss (s)');

    %find half maximum and get corres ponding indices
    gauss1_half_maximum = max(y_gauss)/2

    %indices corresponding to Half Maximum
    gauss_delay_lower_bound = x_gauss(177);  
    gauss_delay_upper_bound = x_gauss(225);

    FWHM_gauss = gauss_delay_upper_bound - gauss_delay_lower_bound

%% Lorents in mm
%lorentz function is given by
% YPRIME(X) = P1./((X - P2).^2 + P3) + C. 
[yPrime param resNorm residual] = lorentzfit(delta_t_delay,y_intensity);

p1 = 2.440712897427114e-25;
p2 = 2.002002002001959e-13;
p3 = 1.603204806407951e-27;
c = 8.600000000000000;

x_lorentz1 = 0:0.1*10^(-14):4*10^(-13);; 

y_lorentz1 = p1./((x_lorentz1-p2).^2 +p3) +c;

figure
plot(x_lorentz1,y_lorentz1);
title('Plotted Fitted Lorentz (fs)');

%
loretnz_half_maximum = max(y_lorentz1)/2
%indices corresponding to Half Maximum
lorentz1_delay_lower_bound = x_lorentz1(159);  
lorentz1_delay_upper_bound = x_lorentz1(244);


FWHM_lorentz1 = lorentz1_delay_upper_bound - lorentz1_delay_lower_bound


%% Calculate GDD
%pulse width is AutoCorrelation width / sqrt(2) for gaussian
%pulse_duration_out = 2*FWHM_gauss/sqrt(2)
pulse_duration_out = 150*10^(-15);
%used 3dB points for bandwidth
input_bandwidth_wavelength = (815 - 795)*10^(-9);
%C is field profile. c = 0.441 for gaussian
%input_bandwidth_frequency = input_bandwidth_wavelength * 299700000/(800*10^(-9))^2;
input_bandwidth_frequency = 0.4413/(50*10^(-15));
GDD = (1/(4*log(2))) * sqrt( (0.4413*pulse_duration_out/input_bandwidth_frequency)^2 - (0.4413/input_bandwidth_frequency)^4)

