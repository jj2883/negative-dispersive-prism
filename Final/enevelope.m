% GENENV Generates an envelope for a signal
% Usage: tprofile(type, length, [params])
% type flag is sum of:
% (two minor bits)
% 0 -> top hat
% 1 -> Gaussian
% 2 -> Lorentzian
% 3 -> (undefined)
% (major bit)
% 0 -> no modulation
% 4 -> pulsetrain
% (e.g. 1 is single Gaussian, 4 is train of top hats, 6 is train of Lorentzians)
% This is intended to be extensible to more complex configurations
%
% length is the total length of the output array (number of data points)
%
% params is a structure of parameters, which may be any of 'center',
% 'width' and 'spacing'. Width is rms for Gaussians and FWHM for
% Lorentzians. Center it w.r.t. the center of the window. These are all
% given in units of data points
%
% Example usage:
% env = genenv(5, 1000, struct('width', 10, 'spacing', 100));
% would generate a vector of 1000 values containing a train of Gaussians, each
% 10 points wide, with their centers spaced by 100 points
%
% env = genenv(2, 1000, struct('width', 100, 'center', 200));
% would generate a vector of 1000 values containing a Lorentzian with FWHM of
% 100 points, offset 200 points to the right of the window center
%
% N.B. The the output is scaled that so that it is always in the range [0,1]
subplot(2,1,1)
env = genenv(1, 800, struct('width', 50, 'spacing', 800));
plot(env)
title ('Laser Pulse in Frequency')
xlabel ('Hz')
ylabel ('Intensity')
subplot(2,1,2)
%env1 = genenv(5, 1000, struct('width', 10, 'spacing', 400));
%plot(env1)
% title ('Compressed UltraFast Laser Pulse')
% xlabel ('fs(10^-^1^5s)')
% ylabel ('Intensity')

env2 = conv(env,env);
env1 = genenv(1, 800, struct('width', 80, 'spacing', 800));
plot(env1);
title('Broadened Laser Pulse in Frequency')
xlabel('Hz')
ylabel ('Intensity')

%%Continuous Laser
figure
subplot(2,1,2)
env3 = genenv(4, 800, struct('width', 30, 'spacing', 20));
plot(env3)
title ('Continuous Laser in Time')
xlabel ('Time')
ylabel ('Intensity')
subplot(2,1,1)
%env1 = genenv(5, 1000, struct('width', 10, 'spacing', 400));
%plot(env1)
% title ('Compressed UltraFast Laser Pulse')
% xlabel ('fs(10^-^1^5s)')
% ylabel ('Intensity')

env4 = fft(env3);
plot(env4);
title('Countinuous Laser in Frequency')
xlabel('Frequency')
ylabel ('Intensity')

%%Pulsed Laser
figure
subplot(2,1,1)
env5 = genenv(1, 800, struct('width', 30, 'spacing', 20));
plot(env5)
title ('Continuous Laser in Time')
xlabel ('Time')
ylabel ('Intensity')
subplot(2,1,2)
%env1 = genenv(5, 1000, struct('width', 10, 'spacing', 400));
%plot(env1)
% title ('Compressed UltraFast Laser Pulse')
% xlabel ('fs(10^-^1^5s)')
% ylabel ('Intensity')

env6 = fft(env5);
plot(env6);
title('Countinuous Laser in Frequency')
xlabel('Frequency')
ylabel ('Intensity')