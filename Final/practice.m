
%pulse width is AutoCorrelation width / sqrt(2) for gaussian
%pulse_duration_out = 2*FWHM_gauss/sqrt(2)
pulse_duration_out = sqrt((2.877e-14)^2 /2) * 2*sqrt(2*log(2))*0.707;
%used 3dB points for bandwidth
input_bandwidth_wavelength = (35)*10^(-9);
%C is field profile. c = 0.441 for gaussian
input_bandwidth_frequency = input_bandwidth_wavelength * 299700000/(800*10^(-9))^2;
%input_bandwidth_frequency = 0.4413/(50*10^(-15));
GDD = (1/(4*log(2))) * sqrt( (0.4413*pulse_duration_out/input_bandwidth_frequency)^2 - (0.4413/input_bandwidth_frequency)^4)
