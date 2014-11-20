% generate_parameters.m : generate model parameters for battery pack model
% Aaron Bonnell-Kangas, November 2014

%% USAGE
% generate_parameters.m expects a number of input files:
%	* 0.1C_Discharge.mat: current and voltage measurements from a 0.1C
%	discharge from a fully charged cell
%		This file should have three vectors:
%			* "Time", a vector with relative time measurements, in seconds
%			* "Current", the discharge current out of the cell, in amps
%			* "Voltage", the cell's terminal voltage, in volts
%		It is assumed that the discharge current is small enough that Vcell
%		~= OCV (i.e., voltage drop over cell internal resistance is
%		negligible).
%
%	* Pulse_Discharge_Test.mat: current and voltage measurements from a
%	pulse-discharge test suitable for characterizing cell internal
%	resistance and capacitance
%		This file should have the same three vectors as
%		"0.1C_Discharge.mat".

%% CONFIGURATION
clear;
clc;

% The name of the data set to use for calibration (should be a folder in
% the "Raw" directory).
cell	= 'RedCell';
output	= fullfile('..', 'Battery pack.mat'); 

%% CALIBRATION

%%% OCV calibration
load( fullfile(cell, '0.1C_Discharge.mat') );

Time		= Time*3600*24;				% date number to seconds
dt			= [0; diff( Time )];	
Ah			= -cumsum( Current .* dt )/3600;		% discharged capacity, Ah
Capacity 	= max( abs(Ah) );						% observed cell capacity, Ah

Voc.SOC		= flip( (Capacity-Ah)./Capacity )';
Voc.V		= flip( Voltage )';
Q_0			= Capacity * 3600;						% Ah -> C

% TEMPORARY - SHOULD LOAD FROM FILE
T_0			= 20;

% Write model parameter workspace
info = ['Generated ' date];
save(output, 'Voc', 'Q_0')

%%% Resistance calibration
display 'Calibrating resistances...'
load( fullfile(cell, 'Pulse_Discharge_Test.mat') );
Idc		= timeseries(Current,Time-Time(1));
V		= timeseries(Voltage,Time-Time(1));

% starting points for calibration
guess.R0 = 0.025;
guess.R1 = 0.025;
guess.C1 = 1000;
guess.Capacity = 2.5;

fxn = @(x)calibrate_pack_RC(x(1), x(2), x(3), x(4), Idc, V);

options = optimset('PlotFcns',@optimplotfval);
rc = fminsearch( fxn, [guess.R0 guess.R1 guess.C1 guess.Capacity], options);

R0	=	rc(1);
R1	=	rc(2);
C1	=	rc(3);

save(output, 'R0', 'R1', 'C1', '-append');
