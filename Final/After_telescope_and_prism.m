x_delay1 = [320 325 330 333 336 340 344 347 350 351 352 353 354 355 356 357 358 359 360 361 362 363 364 365 366 367 368 369 370 371 372 373 374 375 376 377 378 379 380 381 382 383 384 385 386 387 388 389 390 391 392 393 395 397 399 401 405 410 412 413 414 415 416 417 418 420 422 432 438 442];
y_intensity =[9.32 10.01 11.6 13.49 16.05 20.63 22.43 23.58 21.67 21.45 20.72 21.15 21.85 22.46 26.11 28.11 30.4 37.1 44.28 45.87 50.29 62.62 69.79 80.44 96.55 107.26 132.47 150.55 163.28 177.08 186.22 192.06 207.3 203.1 199.01 195.84 187.96 174 170.56 153.3 145.57 129 110 102.69 86.77 69.92 54.2 47.25 41.5 37 33.3 31.04 26 18.4 19.56 19.1 21.51 20.23 19.23 17.79 16.39 15.29 15.32 14.32 13.31 11.32 10.22 9.55 9.7 9.31]-9.31; 

%delta x in meters
delta_x_delay = (x_delay1 - 320).*10^(-6);

%delta x in seconds
delta_t_delay = 2/299700000 .*delta_x_delay./(10^(-15));

figure
subplot(2, 1, 1);
plot(delta_t_delay, y_intensity)
title('AutoCorrelation after Laser Setup')
xlabel('Time Delay (fs)')
ylabel('Intensity')
hold on
a1 =       191.2;%  (187, 195.5)
       b1 =       369.4;%  (368, 370.7)
       c1 =       73.92;%  (72.01, 75.83)
     fit =  a1.*exp(-((delta_t_delay-b1)./c1).^2);
       plot(delta_t_delay,fit);
       hold off

x_delay11 = [372 377 380 382 383 384 385 386 387 388 389 390 391 392 393 394 395 396 397 398 399 400 401 402 403 404 405 406 407 408 409 410 411 413 415 418 420];
y_intensity11 = [ 6.02 5.65 4.2 8.24 8.5 10.84 11.63 17.24 17.82 25.15 27.25 30.43 37.54 42 55.64 74.64 100.89 125.8 138.07 144.64 138.06 123.54 95.31 88.78 66.89 56.4 28.69 26.82 24.76 19.61 17.61 15.66 9.57 7.17 5.45 6.4 7.72]-4.2;

%delta x in meters
delta_x_delay11 = (x_delay11 - x_delay11(1)).*10^(-6);

%delta x in seconds
delta_t_delay11 = 2/299700000 .*delta_x_delay11./(10^(-15));


subplot(2, 1, 2);
plot(delta_t_delay11, y_intensity11)
title('AutoCorrelation after Setup and Prism')
xlabel('Time Delay (fs)')
ylabel('Intensity')

hold on

        a1 =         134 ;% (127.2, 140.9)
       b1 =       174.1  ;%(172.5, 175.7)
       c1 =       38.77; 
     fit11 =  a1.*exp(-((delta_t_delay11-b1)./c1).^2);
plot(delta_t_delay11,fit11)
hold off

fwhm(delta_t_delay,y_intensity)
fwhm(delta_t_delay11,y_intensity11)