close all


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
V_cmd = 40;
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
