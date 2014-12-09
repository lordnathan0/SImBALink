% generate_paramfile.m
% This is a hacked together script to write a motor configuration file
% (Motor.mat) for the EMRAX 228
% Eventually this should probably be generalized.

% Aaron Bonnell-Kangas, Dec 2014

% Name of this configuration
motor_name = 'EMRAX_228HV';

% Model matfile that we are using as a template
base_matfile = fullfile( '..' , '..', 'Motor.mat' );

% Output matfile
outfile = motor_name;

% something to remember me by
info = 'EMRAX 228HV motor parameter data - Dec 2014';
save(outfile, 'info', '-append');

%% Static parameters
% These should be moved to a separate MATfile or something

load(base_matfile, 'Ld', 'Lq', 'R');

Ld.Value	= 175e-6;
Lq.Value	= 180e-6;
R.Value		= 18e-3;
Kt.Value	= 1.1;

save(outfile, 'Ld', 'Lq', 'R', 'Kt', '-append');

%% Stored elsewhere
% Load efficiency data from CSV. Right now this CSV is just a table with
% the breakpoints we need.

effData = csvread('EMRAX_228HV_efficiency.csv', 1);

eta.speed		= effData(:,1);
eta.tau			= effData(:,2);
eta.eta			= effData(:,3);

save(outfile, 'eta', '-append');
