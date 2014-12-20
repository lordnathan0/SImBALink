% just gonna make some figures

clear
clc
close all

%% motor calibration dataset
phi_m_cal_source = fullfile( '..', '..', '..', 'Data', 'Raw', 'EMRAX_228HV', '228HV_Coastdown_Calibration.mat');
load( phi_m_cal_source );		%FIXME: should this have a standard filename
ts = ts_subset;

Is.Iq	=	ts{28}*(-1); %Iq
Is.Id	=	ts{27}*(-1); %Id

% first timestamp
startTime = max( min(Is.Iq.time), min(Is.Id.time) );


Is.Iq.Time = Is.Iq.Time - startTime;
Is.Id.Time = Is.Id.Time - startTime;

Vs.Vq	=	ts{36};		%Vq
Vs.Vq.Time = Vs.Vq.Time - startTime;
Vs.Vd	=	ts{33};		%Vd
Vs.Vd.Time = Vs.Vd.Time - startTime;

omega	=	ts{34}*(pi/60)*(-1);	% motor speed (rpm -> rad/sec)
omega.Time = omega.Time - startTime;

figure(1)
hold on;
plot(Vs.Vq)
plot(omega, 'r')
legend('V_q (V)', 'omega (rad/sec)');
xlabel('Time');
ylabel('Voltage (Vq), speed (omega)');
hold off;

saveas(gcf, '228HV_coastdown_calibration_data.eps', 'epsc');