function error = calibrate_pack_RC(R0, R1, C1, Idc, V)
% calibrate_pack_RC.m: simulate battery pack model with specified R0, R1,
% C1; return fit quality
% Arguments:
%	R0		0-order resistance, ohms
%	R1		1-order resistance, ohms
%	C1		1-order capacitance, F
%	Idc		DC current timeseries
%	V		terminal voltage timeseries

%% configure model workspace
cd('../..');
load_system('Battery_pack');
mws = get_param(bdroot, 'modelworkspace');

mws.reload();		% reload workspace from source file

% set specified values in model workspace
mws.assignin('R0', R0);
mws.assignin('R1', R1);
mws.assignin('C1', C1);
mws.assignin('Idc',Idc);

set_param('Battery_pack', 'StopTime', 'max(Idc.Time)');
output = sim('Battery_pack', 'LoadExternalInput', 'on', 'ExternalInput', 'Idc');

error = output;



