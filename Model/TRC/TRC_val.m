load CoastDownTimeSeries
load('228hv_tau_coastdown.mat')

datastart = 1300;
addpath(genpath('/Powertrain'))
addpath(genpath('/Vehicle'))

close all
starttime = ts{1}.Data(datastart);
endtime = 832;
thr = ts{26};
rpm = ts{34};
eff_tyre = -0.01843; %(m/s)/RPM

v0 = rpm.Data(datastart) * eff_tyre;

sample_tau = getsampleusingtime(sim_tau,starttime,endtime);
sample_tau.Time = sample_tau.Time - sample_tau.Time(1);

rpm_sample = getsampleusingtime(rpm,starttime,endtime);
rpm_sample.Time = rpm_sample.Time - rpm_sample.Time(1);

load_system('Chassis')

chas = get_param('Chassis','ModelWorkspace');
gear = get_param('Gear_Chain','ModelWorkspace');
tire = get_param('Tires','ModelWorkspace');

assignin(chas,'v0',v0);
g1 = getVariable(tire,'Ct');
%gearratio = 1/((-eff_tyre)*(1/g1)*9.54929659643);
gearratio = 3.1;
assignin(gear,'w0',(v0)/g1);
assignin(gear,'Rg',gearratio);
assignin(chas,'CdA',.4);

rho = 1.2;
Or = 0;
Beta = 0;
V_cmd = 40;
Rc = 10000;


sim('TRC',600);

figure
hold all
plot(t,v)
plot(rpm_sample.Time,rpm_sample.Data*eff_tyre);
title('Velocity m/s');
legend('sim','data')

figure
hold all
plotyy(t,Or, t, Rc);
title('Road grad');


figure
plot(t,Tm)
title('torque');

figure
plot(t,ks)
title('slip');