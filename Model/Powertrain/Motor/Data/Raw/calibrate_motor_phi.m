function error = calibrate_motor_phi(phi_m, Is, omega, Vs)
% calibrate_motor_phi.m: simulate motor model with specified phi_m; return fit quality
% Arguments:
%	phi_m: double - motor flux linkage, V*sec/rad
%	Is: structure
%		Is.Iq:	timeseries of Q-axis currents (A)
%		Is.Id:	timeseries of D-axis currents (A)
%	omega: timeseries of motor speeds (rad/sec)
%	Vs: structure
%		Vs.Vq:	timeseries of Q-axis equivalent-circuit terminal voltages
%		(V)
%		Vs.Vd:	timeseries of D-axis equivalent-circuit terminal voltages
%		(V)

%% configure model workspace and simulate
load_system(fullfile( '..', '..', 'Motor'));
mws = get_param(bdroot, 'modelworkspace');

% change model data source path (temporary - we won't save this)
mws.FileName = fullfile('..', 'Configurations', 'EMRAX_228HV.mat');
mws.reload();		% reload workspace from source file

% set specified values in model workspace
mws.assignin('phi_m', phi_m);
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

sse1 = Vs.Vq - resample(vq_sim, Vs.Vq.time);		% resample simulation timeseries to truth time values
sse1 = sum((sse1.Data).^2);

sse2 = Vs.Vd - resample(vd_sim, Vs.Vd.time);		% resample simulation timeseries to truth time values
sse2 = sum((sse2.Data).^2);

error = sse1 + sse2;