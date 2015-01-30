function [Voc, Q_0, T_0] = calibrate_ocv()
%calibrate_ocv Generate the open-circuit voltage structure for a battery
%cell model
%
%	The function expects the Buckeye Current "Scripts" folder is on the
%	MATLAB path.
%
%	This function is currently hard-coded per cell.

%% Constant
% File to load 0.1C discharges from
discharge = '2014_12_30_OCV_discharge_3.txt';

%% Load 
[testData cellData] = read_PL8( discharge );

% The code in this section assumes that all of the timeseries already have
% a common time vector.

% The PL-8 "AhrOUT" channel has been unreliable so calculate ourselves
dt			= [0; diff(testData.Current.Time)];				
Ah			= -cumsum( testData.Current.Data .* dt )/3600;	% discharged capacity, Ah
Capacity	= max( abs(Ah) );								% observed cell capacity, Ah

%TODO: Should average all of the cells in the datafile instead of picking
%cell 4

%TODO: Need to fix data so that SOC breakpoints do not repeat (breaks
%lookup tables)

Voc.SOC		= flip( (Capacity-Ah)./Capacity )';
Voc.V		= flip( cellData{4}.Data )';
Q_0			= Capacity * 3600;						% Ah -> C

% Temporary - quick fix
Voc.SOC		= Voc.SOC(1:end-3);
Voc.V		= Voc.V(1:end-3);

% TEMPORARY - SHOULD LOAD FROM FILE
T_0			= 20;

end