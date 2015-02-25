function [Rider,Env,Battery,MotorController,Motor,Chassis,Gear,Brakes,Tires] = RW3_Pikes_Peak_Config()
%% add paths
addpath('Rider');
addpath('Environment');
addpath('Powertrain/Battery_pack');
addpath('Powertrain/Motor');
addpath('Powertrain/Motor_controller');
addpath('Vehicle/Brakes');
addpath('Vehicle/Chassis');
addpath('Vehicle/Gear_Chain');
addpath('Vehicle/Tires');
%% Load systems
load_system('Battery_pack');
Battery = get_param(bdroot, 'modelworkspace');
load_system('Rider_PI');
Rider = get_param(bdroot, 'modelworkspace');
load_system('Environment');
Env = get_param(bdroot, 'modelworkspace');
load_system('Motor');
Motor = get_param(bdroot, 'modelworkspace');
load_system('Motor_controller');
MotorController = get_param(bdroot, 'modelworkspace');
load_system('Brakes');
Brakes = get_param(bdroot, 'modelworkspace');
load_system('Chassis');
Chassis = get_param(bdroot, 'modelworkspace');
load_system('Gear_Chain');
Gear = get_param(bdroot, 'modelworkspace');
load_system('Tires');
Tires = get_param(bdroot, 'modelworkspace');
%% Load Correct Config
%run('Powertrain/Battery_pack/Data/Raw/RW3_generate_parameters.m')
Battery.FileName = 'Powertrain/Battery_pack/Data/RW3 Battery pack.mat' ;
Battery.reload();		% reload workspace from source file

run('Vehicle/Brakes/Data/RW3_generate_parameters.m')
Brakes.FileName = 'Vehicle/Brakes/Data/RW3_Brakes.mat' ;
Brakes.reload();		% reload workspace from source file

%needs to be corrected
run('Vehicle/Chassis/Data/RW3_generate_parameters.m')
Brakes.FileName = 'Vehicle/Chassis/Data/RW3_Chassis.mat' ;
Brakes.reload();		% reload workspace from source file

%needs to be corrected
run('Environment/Data/Pikes_Peak_generate_parameters.m')
Env.FileName = 'Environment/Data/Pikes_Peak_Environment.mat' ;
Env.reload();		% reload workspace from source file

%needs to be corrected
run('Vehicle/Gear_Chain/Data/RW3_generate_parameters.m')
Gear.FileName = 'Vehicle/Gear_Chain/Data/RW3_Gear.mat' ;
Gear.reload();		% reload workspace from source file

%needs to be corrected
run('Powertrain/Motor/Data/RW3_generate_parameters.m')
Motor.FileName = 'Powertrain/Motor/Data/RW3_Motor.mat' ;
Motor.reload();		% reload workspace from source file

%needs to be corrected
run('Powertrain/Motor_controller/Data/RW3_generate_parameters.m')
MotorController.FileName = 'Powertrain/Motor_controller/Data/RW3_MotorController.mat' ;
MotorController.reload();		% reload workspace from source file

run('Rider/RW3_generate_parameters.m')
Rider.FileName = 'Rider/RW3_Rider_PI.mat' ;
Rider.reload();		% reload workspace from source file

run('Vehicle/Tires/Data/RW3_generate_parameters.m')
Tires.FileName = 'Vehicle/Tires/Data/RW3_Tires.mat' ;
Tires.reload();		% reload workspace from source file
end

