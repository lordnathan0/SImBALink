function phi_m = calculate_fluxlinkage( )
%CALCULATE_FLUXLINKAGE Use methods to calibrate motor flux linkage
%   Detailed explanation goes here

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
phi_m_cal_source = '228HV_Coastdown_Calibration.mat';

path('..', path)

%% Calibrate phi_m

load( phi_m_cal_source );		%FIXME: should this have a standard filename
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

omega	=	ts{34}*(pi/60)*(-1);	% motor speed (rpm -> rad/sec)
omega.Time = omega.Time - startTime;

f = @(phi) calibrate_motor_phi(phi, Is, omega, Vs);

guess = 1;

options = optimset('PlotFcns',@optimplotfval);
phi_m = fminsearch( f, guess, options);


end

