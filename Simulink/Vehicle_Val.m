close all

v0 = 20;
chas = get_param('Chassis','ModelWorkspace');
gear = get_param('Gear_Chain','ModelWorkspace');
tire = get_param('Tires','ModelWorkspace');

assignin(chas,'v0',v0);
g1 = getVariable(tire,'Ct');
g2 = getVariable(gear,'Rg');


rho = 1.2;
Or = 0;
Beta = 0;
V_cmd = 30;
Rc = 10000;
Tm = 10;
ks_cmd = .15;

assignin(gear,'w0',(v0)/g1);



dur = 100;
sim('Vehicle_Validation', dur)

figure
plot(t,v)

figure
plot(t,Tm)

figure
plot(t,ks)
