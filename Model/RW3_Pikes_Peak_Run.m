%% Run Pikes Peak Simulation with RW3

%% Initialize default config
[Rider,Env,Battery,MotorController,Motor,Chassis,Gear,Brakes,Tires] = RW3_Pikes_Peak_Config();

%% Make Changes to the Config
% other values can be changed by looking in the documentation
assignin(Gear,'Rg',1); %change Gear ratio
assignin(Env,'T0',300); %Update sea level tempurature to be correct

%% Run simuilation

load_system('Pikes_Peak');
PP = get_param('Pikes_Peak', 'modelworkspace');

time = 100; %set max time
assignin(PP,'D_max',1); %set max distance

sim('Pikes_Peak',time);

%%
figure
plot(Pikes_Peak_Data.Velocity);
figure
plot(Pikes_Peak_Data.Wheel_Slip);