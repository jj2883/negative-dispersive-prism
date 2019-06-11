clear all;
close all;

%%Collected Data
%original data collection
x_delay1 = [320 325 330 333 336 340 344 347 350 351 352 353 354 355 356 357 358 359 360 361 362 363 364 365 366 367 368 369 370 371 372 373 374 375 376 377 378 379 380 381 382 383 384 385 386 387 388 389 390 391 392 393 395 397 399 401 405 410 412 413 414 415 416 417 418 420 422 432 438 442];
y_intensity =[9.32 10.01 11.6 13.49 16.05 20.63 22.43 23.58 21.67 21.45 20.72 21.15 21.85 22.46 26.11 28.11 30.4 37.1 44.28 45.87 50.29 62.62 69.79 80.44 96.55 107.26 132.47 150.55 163.28 177.08 186.22 192.06 207.3 203.1 199.01 195.84 187.96 174 170.56 153.3 145.57 129 110 102.69 86.77 69.92 54.2 47.25 41.5 37 33.3 31.04 26 18.4 19.56 19.1 21.51 20.23 19.23 17.79 16.39 15.29 15.32 14.32 13.31 11.32 10.22 9.55 9.7 9.31]-9.31; 
x_delay2 = [365 366 367 368 369 370 371 372 373 374 375 376 377 378 379 380 381 382 383 384 385];
y_intensity2 =[80.44 96.55 107.26 132.47 150.55 163.28 177.08 186.22 192.06 207.3 203.1 199.01 195.84 187.96 174 170.56 153.3 145.57 129 110 102.69 ]; 
delta_x_delay2 = (x_delay2 - x_delay2(1)).*10^(-6);
delta_t_delay2 = 2/299700000 .*delta_x_delay2;


%delta x in meters
delta_x_delay = (x_delay1 - 320).*10^(-6);

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
       a1 =       198.6;%  (211.5, 245.8)
       b1 =   3.704e-13; % (3.562e-13, 3.645e-13)
       c1 =   7.081e-14;        
    %increase delay time from -200fs to 200fs in increments of 10fs
    x_gauss =   0:0.1*10^(-14):7*10^(-13); 
       
    %plug into gaussian curve       
    y_gauss =  a1.*exp(-((x_gauss-b1)./c1).^2);

    figure
    plot(delta_t_delay, y_intensity);
    hold on
    plot(x_gauss,y_gauss)
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
pulse_duration_out = sqrt((7.081e-14)^2 /2) * 2*sqrt(2*log(2))*0.707;
%used 3dB points for bandwidth
bandwidth_wavelength = (30)*10^(-9);
%C is field profile. c = 0.441 for gaussian

%bandwidth_frequency = bandwidth_wavelength * 0.441 /(805*10^(-9))^2;
bandwidth_frequency = 0.4413/3.386897097449185e-14 ;
GDD = (1/(4*log(2))) * sqrt( (0.441*pulse_duration_out/bandwidth_frequency)^2 - (0.441/bandwidth_frequency)^4)

