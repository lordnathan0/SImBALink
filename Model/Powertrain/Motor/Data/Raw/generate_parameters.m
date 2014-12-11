% Generate a motor parameter file (MOTOR_NAME.mat) for the Motor.slx model.
% 

% REQUIREMENTS
%	A raw motor data set must have:
%	-	Motor flux linkage calibration data (see phi_m_cal_source, below)
%	-	"calculate_efficiency.m", a function that returns motor efficiency
%		map breakpoints
%	-	"<motorname>_const_parameters.m", a script that assigns variables
%		corresponding to "constant" motor parameters
%	-	"<motorname>_signals.m", a script that creates the Simulink.Signal
%		objects corresponding to the signals in the model

clear;
clc;

% Motor datafile info string. This is the only way people know what the
% hell the output file is!
info = 'EMRAX 228HV motor parameter data - Dec 2014';

% The name of the data set to use for calibration (should be a folder in
% the "Raw" directory).
motor	= 'EMRAX_228HV';
output	= fullfile('..', 'Motor.mat');
output	= fullfile('..', 'Configurations', [ motor '.mat']);

% phi_m_cal_source
% Name of the file containing the dataset to be used for phi_m calibration.
% This file should have:
%	* info		-	string describing the source of the data
%	* Is: structure
%	*	Is.Id	-	timeseries with d-axis motor current
%	*	Is.Iq	-	timeseries with q-axis motor current
%	* Vs: structure
%	*	Vs.Vd	-	timeseries with d-axis motor terminal voltage
%	*	Vs.Vq	-	timeseries with q-axis motor terminal voltage
%	* omega		-	timeseries of motor speed (rad/sec)
phi_m_cal_source = '228HV_Coastdown.mat';

% Generate a "test harness" bus so that the motor model can run standalone
% (this bus is normally defined by the input to the model)
Is_bus = Simulink.Bus;
Iq		= Simulink.BusElement;
Iq.Name	= 'Iq';
Id		= Simulink.BusElement;
Id.Name = 'Id';
Is_bus.Elements = [Iq Id];
clear('Iq', 'Id');

%% Calibrate phi_m
load( fullfile(motor, '228HV_Coastdown_Calibration.mat') );		%FIXME: this should have a standard filename
ts = ts_subset;

Is.Iq	=	ts{28}*(-1); %Iq
Is.Id	=	ts{27}*(-1); %Id

% first timestamp
startTime = max( min(Is.Iq.time), min(Is.Id.time) );


Is.Iq.Time = Is.Iq.Time - startTime;
Is.Id.Time = Is.Id.Time - startTime;

Vs.Vq	=	ts{36};		%Vq
Vs.Vq.Time = Vs.Vq.Time - startTime;
Vs.Vd	=	ts{33};		%Vd
Vs.Vd.Time = Vs.Vd.Time - startTime;

omega	=	ts{34}*(2*pi/60)*(-1);	% motor speed (rpm -> rad/sec)
omega.Time = omega.Time - startTime;

f = @(phi) calibrate_motor_phi(phi, Is, omega, Vs);

guess = 1;

options = optimset('PlotFcns',@optimplotfval);
cal = fminsearch( f, guess, options);
