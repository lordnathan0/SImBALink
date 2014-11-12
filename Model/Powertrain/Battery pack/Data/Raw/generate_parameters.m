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

%% CONFIGURATION
clear;
clc;

% The name of the data set to use for calibration (should be a folder in
% the "Raw" directory).
cell = 'BlueCell';

%% CALIBRATION

%%% OCV calibration
load( fullfile(cell, '0.1C_Discharge.mat') );
dt			= [0; diff( Time )];	
Ah			= -cumsum( Current .* dt )/3600;		% discharged capacity, Ah
Capacity 	= max( abs(Ah) );					% observed cell capacity, Ah

% TODO: write model parameters to parameter file