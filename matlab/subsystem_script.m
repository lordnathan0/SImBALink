clear all

% get workspace of the external subsystem
sub = get_param('test_create_subsystem','ModelWorkspace');

% choose what parameter to fill
x = 2;

%load parameters. ALWAYS DO THIS BEFORE RUNNING A MODEL! YOU DON'T KNOW
%WHAT VARIABLES ARE IN THE WORKSPACE FROM PREVIOUS RUNS 
sub.reload

%run simulation
sim('use_test')
out(1)
% should be 2

%change parameter A and run
assignin(sub,'A',10)

sim('use_test')
out(1)
% should be 10

%etc
x = 3;
sub.reload
sim('use_test')
out(1)
% should be 3

%etc
assignin(sub,'A',10)

sim('use_test')
out(1)
% should be 10

clear all
