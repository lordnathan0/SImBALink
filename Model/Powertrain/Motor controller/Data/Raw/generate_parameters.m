% Generate a motor controller parameter file (MC_NAME.mat) for the Motor_controller.slx model.
% 

% REQUIREMENTS
%	A raw motor controller data set must have:
%	-	"<mcname>_const_parameters.m", a script that assigns variables
%		corresponding to "constant" motor parameters
%	-	"<mcname>_signals.m", a script that creates the Simulink.Signal
%		objects corresponding to the signals in the model

clear;
clc;

% Motor datafile info string. This is the only way people know what the
% hell the output file is!
info = 'WaveSculptor 200 preliminary configuration data - Dec 2014';

% The name of the data set to use for calibration (should be a folder in
% the "Raw" directory).
mc	= 'WaveSculptor_200';
output	= fullfile('..', 'Configurations', [ mc '.mat']);
path(mc, path);

%% Load constant parameters
run( [ mc '_const_parameters.m' ] );

%% Load motor signals
run( [ mc '_signals.m' ] );

%% Write to file (final)
save( output,						...
	'Sine_Current_Limit',			...
	'Motor_Ramp_Temperature',		...
	'Motor_Cutout_Temperature'		...
);
