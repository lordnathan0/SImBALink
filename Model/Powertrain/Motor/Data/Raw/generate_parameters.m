% Generate a motor parameter file (MOTOR_NAME.mat) for the Motor.slx model.
% 

clear;
clc;

% The name of the data set to use for calibration (should be a folder in
% the "Raw" directory).
motor	= 'EMRAX_228HV';
output	= fullfile('..', 'Motor.mat');

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
