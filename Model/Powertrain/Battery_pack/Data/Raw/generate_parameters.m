% generate_parameters.m : generate model parameters for battery pack model
% Aaron Bonnell-Kangas, November 2014

%% USAGE
% generate_parameters.m runs several functions, which are expected to be in
% the <CellName> directory. 
% For example, the function "calibrate_ocv.m" for the "Samsung-25R" cell 
% should be located at ./Samsung-25R/calibrate_ocv.m .
% 
% A cell model includes:
%	- calibrate_ocv.m
%		Function which takes no arguments and returns:
%			* Voc	- struct
%			* Q_0	- float
%			* T_0	- float
%	- calibrate_RC.m
%		Function which takes no arguments and returns the parameters R0,
%		R1, and C1.
%	- static_parameters.m
%		Script which sets constant parameters for the cell.
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
cell	= 'Samsung-25R';
output	= fullfile('..', [cell '.mat']); 
path(fullfile(pwd, cell), path);

%% CALIBRATION

%%% OCV calibration
[Voc, Q_0, T_0] = calibrate_ocv();

% Write OCV data
info = ['Generated ' date];
save(output, 'Voc', 'Q_0', 'T_0')

%%% Resistance calibration
[R0 R1 C1] = calibrate_RC();

save(output, 'R0', 'R1', 'C1', '-append');
