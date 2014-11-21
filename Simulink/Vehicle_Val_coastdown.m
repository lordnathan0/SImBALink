close all
load CdA_data
%   CdA_data{a,b}
%   a: varible identfier 
%       1: RPM
%       2: Time (s)
%   b: run idenifier
%       1-7
%
% air density 
% alpha (road grad)
% bike_mass (including rider)
% eff_tyre (effective tire mps / RPM)
figure
hold all

cda_runs = [7];
for i = cda_runs
    %acceleration
    I = find(diff(CdA_data{1,i}));
    CdA_data{4,i} = CdA_data{1,i}(I).*eff_tyre;
end

v0 = 30;
chas = get_param('Chassis','ModelWorkspace');
gear = get_param('Gear_Chain','ModelWorkspace');
tire = get_param('Tires','ModelWorkspace');

assignin(chas,'v0',v0);
g1 = getVariable(tire,'Ct');
g2 = getVariable(gear,'Rg');


rho = 1.2;
Or = 0;
Beta = 0;
V_cmd = 0;
Rc = 10000;
Tm = 10;
ks_cmd = .15;

assignin(gear,'w0',(v0)/g1);



dur = 100;
sim('Vehicle_Validation', dur)

figure
hold all
plot(t,v)
title('Vehicle Speed')
xlabel('Time [s]')
ylabel('Velocity [m/s]')
for i = cda_runs
    plot(CdA_data{4,i})
end
legend('sim','data')

figure
plot(t,Tm)
title('Motor Torque')
xlabel('Time [s]')
ylabel('Motor Torque [Nm]')

figure
plot(t,ks)
title('Wheel Slip')
xlabel('Time [s]')
ylabel('Wheel Slip [ratio]')
