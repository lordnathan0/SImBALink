function error = calibrate_pack_RC(R0, R1, C1, Capacity, Idc, V)
% calibrate_pack_RC.m: simulate battery pack model with specified R0, R1,
% C1; return fit quality
% Arguments:
%	R0		0-order resistance, ohms
%	R1		1-order resistance, ohms
%	C1		1-order capacitance, F
%	Idc		DC current timeseries
%	V		terminal voltage timeseries

%% configure model workspace
model_path = fullfile( '..', '..', 'Battery_pack' );
load_system(model_path);
mws = get_param(bdroot, 'modelworkspace');

% FIXME: need to choose model data source dynamically - maybe we should
% have a global for this?

% change model data source path (temporary - we won't save this)
mws.FileName = fullfile('..', 'Samsung-25R.mat');
mws.reload();		% reload workspace from source file

% set specified values in model workspace
mws.assignin('R0', R0);
mws.assignin('R1', R1);
mws.assignin('C1', C1);
mws.assignin('Q_0', Capacity*3600);
mws.assignin('Idc',Idc);

set_param('Battery_pack', 'StopTime', 'max(Idc.Time)');
out = sim('Battery_pack', 'LoadExternalInput', 'on', 'ExternalInput', 'Idc');

%% Calculate error metric
yout = out.get('yout');
tout = out.get('tout');

outV = timeseries(yout(:,2),tout);		% Timeseries of simulation output
sse = V - resample(outV,V.time);		% resample simulation timeseries to truth indices
sse = sum((sse.Data).^2);	

error = sse;							% return SSE
%error = out;



