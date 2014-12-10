function [ eta ] = calculate_efficiency( )
%CALCULATE_EFFICIENCY - Calculate motor efficiency map breakpoints

% This script returns motor efficiency map breakpoints in a usable format
% after reading them from a CSV. In order for this to work right, the CSV
% has to have enough datapoints to completely populate a n x m  matrix,
% where n is the number of unique speed breakpoints, and m is the number of
% unique torque breakpoints.

effData = csvread('EMRAX_228HV_efficiency.csv', 1);

eta.speed		= effData(:,1);
eta.tau			= effData(:,2);
eta.eta			= effData(:,3);

end

