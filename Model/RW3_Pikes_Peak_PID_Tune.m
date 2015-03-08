%% Run Pikes Peak Simulation with RW3

%% Initialize default config
[Rider,Env,Battery,MotorController,Motor,Chassis,Gear,Brakes,Tires, FileNames] = RW3_Pikes_Peak_Config();

%% Make Changes to the Config
% other values can be changed by looking in the documentation
assignin(Gear,'Rg',1); %change Gear ratio
assignin(Env,'T0',300); %Update sea level tempurature to be correct
assignin(Brakes,'ub',500); %Make braking ablity HUGE!!
%% Run simuilation
warning off;

load_system('Pikes_Peak');
PP = get_param('Pikes_Peak', 'modelworkspace');

time = 1000; %set max time
assignin(PP,'D_max',1000); %set max distance

Pikes_Peak_Data = cell(0);
% Ps = [.1 1 5 10 100];
% i = 0;
% for P = Ps
%     i = i + 1;
%     assignin(Rider,'Rider_P',P);
%     sim('Pikes_Peak',time);
%     Pikes_Peak_Data{i} = Dataset2Ts(logsout);
% end
assignin(Rider,'Rider_P',100);
% Is = [0 .01 .1 .3];
% i = 0;
% for I = Is
%     i = i + 1;
%     assignin(Rider,'Rider_I',I);
%     sim('Pikes_Peak',time);
%     Pikes_Peak_Data{i} = Dataset2Ts(logsout);
% end

assignin(Rider,'Rider_I',0);
Ds = [0 1 5 10];
i = 0;
for D = Ds
    i = i + 1;
    assignin(Rider,'Rider_D',D);
    sim('Pikes_Peak',time);
    Pikes_Peak_Data{i} = Dataset2Ts(logsout);
end

RW3_Pikes_Peak_Defaults(Rider,Env,Battery,MotorController,Motor,Chassis,Gear,Brakes,Tires, FileNames);

warning on;
%% Plot
close all
figure
hold all
plot(Pikes_Peak_Data{1}.Request_Speed);
for i = [1:length(Pikes_Peak_Data)]
    plot(Pikes_Peak_Data{i}.Vehicle_Velocity);
end

