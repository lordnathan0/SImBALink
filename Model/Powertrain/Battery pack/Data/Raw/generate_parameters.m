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
cell = 'RedCell';

%% CALIBRATION

%%% OCV calibration
load( fullfile(cell, '0.1C_Discharge.mat') );
dt			= [0; diff( Time )];	
Ah			= -cumsum( Current .* dt )/3600;		% discharged capacity, Ah
Capacity 	= max( abs(Ah) );						% observed cell capacity, Ah

Voc.SOC		= flip( (Capacity-Ah)./Capacity )';
Voc.V		= flip( Voltage )';

% Write model parameter workspace
info = ['Generated ' date];
save('Battery pack.mat', 'Voc', 'Q_0')

%%% Resistance calibration
load( fullfile(cell, 'Pulse_Discharge_Test.mat') );
Idc		= timeseries(Amps,Time-Time(1));
V		= timeseries(Volts,Time-Time(1));
