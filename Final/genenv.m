function profile = genenv(type, length, params)
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

minor = mod(type,4);
major = (type-minor)/4;

% Select what a "single" pulse looks like.
switch minor
	case 0 % top hat
		if nargin < 3 || ~isfield(params, 'width')
			% If the width hasn't been defined set it to the full window
			params.width = length;
		end
		
		pulse = @(x) (x > -params.width/2) & (x <= params.width/2);

	case 1 % Gaussian
		assert(nargin >= 3 && isfield(params, 'width'), ...
			'For a Gaussian the params structure must contain a ''width'' field.')
		if ~isfield(params, 'center')
			params.center = 0;
		end
		
		pulse = @(x) exp( -(x-params.center).^2/2/params.width.^2 );

	case 2 % Lorentzian
		assert(nargin >= 3 && isfield(params, 'width'), ...
			'For a Lorentzian the params structure must contain a ''width'' field.')
		if ~isfield(params, 'center')
			params.center = 0;
		end
		
		pulse = @(x) ( (x-params.center).^2 + (params.width/2)^2 ).^(-1) * ...
			(params.width/2)^2;
end

% Modulate the pulses accordingly
switch major
	case 0 % no modulation
		x = (-length/2+1):(length/2);
		profile = pulse(x);
	case 1 % pulse train
		assert(nargin >= 3 && isfield(params, 'spacing'), ...
			'For a a pulse train the params structure must contain a ''spacing'' field.')

		x = (-params.spacing/2+1):(params.spacing/2);
		npulses = floor(length / params.spacing) + 1;
		profile = repmat(pulse(x), 1, npulses);
		%Clear away excess data
		profile(length+1:end) = [];
end


end