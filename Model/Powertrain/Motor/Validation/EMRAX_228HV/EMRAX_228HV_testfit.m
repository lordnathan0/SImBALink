% This function tests the model fit to a dataset and plots the response.

clear;
clc;
close all;

%% Load input data
load('EMRAX_228HV_testfit_data.mat');		%FIXME: should this have a standard filename
ts = ts_full;

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

%% configure model workspace and simulate
load_system(fullfile( '..', '..', 'Motor'));
mws = get_param(bdroot, 'modelworkspace');

mws.reload();		% reload workspace from source file

% set specified values in model workspace
mws.assignin('Is', Is);
mws.assignin('omega', omega);

% Generate a "test harness" bus so that the motor model can run standalone
% (this bus is normally defined by the input to the model)
Is_bus = Simulink.Bus;
Iq		= Simulink.BusElement;
Iq.Name	= 'Iq';
Id		= Simulink.BusElement;
Id.Name = 'Id';
Is_bus.Elements = [Iq Id];
clear('Iq', 'Id');
assignin('base', 'Is_bus', Is_bus);

% only run as long as we have all calibration inputs
set_param('Motor', 'StopTime', 'min( max(Is.Iq.Time), max(Is.Id.Time) )');

out = sim('Motor', 'LoadExternalInput', 'on', 'ExternalInput', 'Is omega');

%% Analyze model fit
sim_log = get(out, 'logsout');
vs_sim = sim_log.get('Vs');
vd_sim = vs_sim.Values.Vd;
vq_sim = vs_sim.Values.Vq;