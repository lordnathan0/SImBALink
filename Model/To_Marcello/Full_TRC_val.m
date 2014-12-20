load CoastDownTimeSeries

datastart = 1300;

close all
starttime = ts{1}.Data(datastart);
endtime = 680;
thr = ts{26};
rpm = ts{34};
volt = ts{8};
vd = ts{33};
vq = ts{36};
id = ts{27};
iq = ts{28};

eff_tyre = -0.01843; %(m/s)/RPM
CdA = .4;

v0 = rpm.Data(datastart) * eff_tyre;

rpm_sample = getsampleusingtime(rpm,starttime,endtime);
rpm_sample.Time = rpm_sample.Time - rpm_sample.Time(1);

Volt_sample = getsampleusingtime(volt,starttime,endtime);
Volt_sample.Time = Volt_sample.Time - Volt_sample.Time(1);

Vq_sample = getsampleusingtime(vq,starttime,endtime);
Vq_sample.Time = Vq_sample.Time - Vq_sample.Time(1);

Iq_sample = getsampleusingtime(iq,starttime,endtime);
Iq_sample.Time = Iq_sample.Time - Iq_sample.Time(1);

Id_sample = getsampleusingtime(id,starttime,endtime);
Id_sample.Time = Id_sample.Time - Id_sample.Time(1);

load_system('Chassis')
load_system('Gear_Chain')
load_system('Tires')

chas = get_param('Chassis','ModelWorkspace');
gear = get_param('Gear_Chain','ModelWorkspace');
tire = get_param('Tires','ModelWorkspace');

assignin(chas,'v0',v0);
g1 = getVariable(tire,'Ct');
gearratio = 1/((-eff_tyre)*(1/g1)*9.54929659643);
assignin(gear,'w0',(v0)/g1);
assignin(gear,'Rg',gearratio);
assignin(chas,'CdA',CdA);

Is_bus = Simulink.Bus;
Iq		= Simulink.BusElement;
Iq.Name	= 'Iq';
Id		= Simulink.BusElement;
Id.Name = 'Id';
Is_bus.Elements = [Iq Id];

rho = 1.2;
Or = 0;
Beta = 0;
V_cmd = 40;
Rc = 10000;


sim_out = sim('Full_TRC',600);

vs_sim = logsout.get('Vs');
vd_sim = vs_sim.Values.Vd;
vq_sim = vs_sim.Values.Vq;

figure
hold all
plot(t,v)
plot(rpm_sample.Time,rpm_sample.Data*eff_tyre);
title('Velocity m/s');
legend('sim','data')

figure
hold all
plot(vq_sim.Time,vq_sim.Data)
plot(Vq_sample.Time,Vq_sample.Data);
title('Vq');
legend('sim','data')

figure
hold all
plot(t,-Iq)
plot(Iq_sample.Time,Iq_sample.Data);
title('Iq');
legend('sim','data')

figure
hold all
plot(t,Id)
plot(Id_sample.Time,Id_sample.Data);
title('Id');
legend('sim','data')


