function [Rider,Env,Battery,MotorController,Motor,Chassis,Gear,Brakes,Tires, FileName] = RW3_Pikes_Peak_Config()
%% add paths
addpath(fullfile('Rider'));
addpath(fullfile('Environment'));
addpath(fullfile('Powertrain','Battery_pack'));
addpath(fullfile('Powertrain','Motor'));
addpath(fullfile('Powertrain','Motor_controller'));
addpath(fullfile('Vehicle','Brakes'));
addpath(fullfile('Vehicle','Chassis'));
addpath(fullfile('Vehicle','Gear_Chain'));
addpath(fullfile('Vehicle','Tires'));
%% Load systems
load_system('Battery_pack');
Battery = get_param('Battery_pack', 'modelworkspace');
load_system('Rider_PID');
Rider = get_param('Rider_PID', 'modelworkspace');
load_system('Environment');
Env = get_param('Environment', 'modelworkspace');
load_system('Motor');
Motor = get_param('Motor', 'modelworkspace');
load_system('Motor_controller');
MotorController = get_param('Motor_controller', 'modelworkspace');
load_system('Brakes');
Brakes = get_param('Brakes', 'modelworkspace');
load_system('Chassis');
Chassis = get_param('Chassis', 'modelworkspace');
load_system('Gear_Chain');
Gear = get_param('Gear_Chain', 'modelworkspace');
load_system('Tires');
Tires = get_param('Tires', 'modelworkspace');
%% Load Correct Config
%run('Powertrain/Battery_pack/Data/Raw/RW3_generate_parameters.m')
FileName.Battery = Battery.FileName;
Battery.FileName = fullfile('Powertrain','Battery_pack','Data','Battery pack.mat');
Battery.reload();		% reload workspace from source file

run(fullfile('Vehicle','Brakes','Data','RW3_generate_parameters.m'))
FileName.Brakes = Brakes.FileName;
Brakes.FileName = fullfile('Vehicle','Brakes','Data','RW3_Brakes.mat') ;
Brakes.reload();		% reload workspace from source file

run(fullfile('Vehicle','Chassis','Data','RW3_generate_parameters.m'))
FileName.Chassis = Chassis.FileName;
Chassis.FileName = fullfile('Vehicle','Chassis','Data','RW3_Chassis.mat') ;
Chassis.reload();		% reload workspace from source file


run(fullfile('Environment','Data','Pikes_Peak_generate_parameters.m'))
FileName.Env = Env.FileName;
Env.FileName =fullfile('Environment','Data','Pikes_Peak_Environment.mat') ;
Env.reload();		% reload workspace from source file

%needs to be corrected
run(fullfile('Vehicle','Gear_Chain','Data','RW3_generate_parameters.m'))
FileName.Gear = Gear.FileName;
Gear.FileName = fullfile('Vehicle','Gear_Chain','Data','RW3_Gear.mat') ;
Gear.reload();		% reload workspace from source file

%needs to be corrected
%run('Powertrain/Motor/Data/RW3_generate_parameters.m')
FileName.Motor = Motor.FileName;
%Motor.FileName = 'Powertrain/Motor/Data/RW3_Motor.mat' ;
Motor.reload();		% reload workspace from source file

%needs to be corrected
%run('Powertrain/Motor_controller/Data/RW3_generate_parameters.m')
FileName.MotorController = MotorController.FileName;
%MotorController.FileName = 'Powertrain/Motor_controller/Data/RW3_MotorController.mat' ;
MotorController.reload();		% reload workspace from source file

%needs to be corrected
run(fullfile('Rider','Pikes_Peak_generate_parameters.m'))
FileName.Rider = Rider.FileName;
Rider.FileName = fullfile('Rider','Pikes_Peak_Rider_PID.mat');
Rider.reload();		% reload workspace from source file

run(fullfile('Vehicle','Tires','Data','RW3_generate_parameters.m'))
FileName.Tires = Tires.FileName;
Tires.FileName = fullfile('Vehicle','Tires','Data','RW3_Tires.mat') ;
Tires.reload();		% reload workspace from source file
end

