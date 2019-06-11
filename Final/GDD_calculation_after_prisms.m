clear all;
close all;

%%Collected Data
%original data collection
x_delay1 = [372 377 380 382 383 384 385 386 387 388 389 390 391 392 393 394 395 396 397 398 399 400 401 402 403 404 405 406 407 408 409 410 411 413 415 418 420];
y_intensity = [ 6.02 5.65 4.2 8.24 8.5 10.84 11.63 17.24 17.82 25.15 27.25 30.43 37.54 54.69 55.64 74.64 100.89 125.8 144.07 146.64 138.06 123.54 95.31 88.78 66.89 56.4 28.69 26.82 24.76 19.61 17.61 15.66 9.57 7.17 5.45 6.4 7.72]-4.2;

%delta x in meters
delta_x_delay = (x_delay1 - x_delay1(1)).*10^(-6);

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

%% Guassian in time
    %f1 = fit(x.',y.','gauss1') gives the parameter for Guassian Equation
    % Coefficients (with 95% confidence bounds):
       a1 =       145.4;%  (144.8, 186.1)
       b1 =   1.735e-13;%  (1.706e-13, 1.764e-13)
       c1 =   3.199e-14;%
       x_gauss =   0:0.1*10^(-14):7*10^(-13); 
       
    %plug into gaussian curve       
    y_gauss =  a1.*exp(-((x_gauss-b1)./c1).^2);

    figure
    plot(delta_t_delay, y_intensity);
    hold on
    plot(x_gauss,y_gauss)
    title('Lorentz')
    hold off
    title('Plotted Fitted Gauss (s)');
    
    
%% Guassian in time
%     %f1 = fit(x.',y.','gauss1') gives the parameter for Guassian Equation
%     % Coefficients (with 95% confidence bounds):
%        a1 =       185;%  (211.5, 245.8)
%        b1 =   3.704e-13; % (3.562e-13, 3.645e-13)
%        c1 =   6.481e-14;    
%        d1 = 16.61;
%     %increase delay time from -200fs to 200fs in increments of 10fs
%     x_gauss =   0:0.1*10^(-14):7*10^(-13); 
%        
%     %plug into gaussian curve       
%     y_gauss =  a1.*exp(-((x_gauss-b1)./c1).^2) + d1;
% 
%     figure
%     plot(delta_t_delay, y_intensity);
%     hold on
%     plot(x_gauss,y_gauss)
%     title('Lorentz')
%     hold off
%     title('Plotted Fitted Gauss (s)');
%% Calculate GDD
%pulse width is AutoCorrelation width / sqrt(2) for gaussian
%pulse_duration = FWHM_gauss/sqrt(2)
%pulse_duration_out = sqrt((3.199e-14)^2 /2) * 2*sqrt(2*log(2))*0.707;
pulse_duration_out =8.335981351073228e-14;
%used 3dB points for bandwidth
bandwidth_wavelength = (35)*10^(-9);
%C is field profile. c = 0.441 for gaussian
%bandwidth_frequency = bandwidth_wavelength * 0.441 /(805*10^(-9))^2;
bandwidth_frequency = 0.4413/3.765965872346174e-14;

GDD = (1/(4*log(2))) * sqrt( (0.441*pulse_duration_out/bandwidth_frequency)^2 - (0.441/bandwidth_frequency)^4)

