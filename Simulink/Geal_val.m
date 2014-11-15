close all
sub = get_param('Gear_Chain','ModelWorkspace');
sub.reload;

%%
close all
Rg = evalin(sub,'Rg');
dur = 100;
Tm = ones(1,dur) * 10 * Rg;
Tt = linspace(0,10,dur);
t = [1:1:dur];
Timespan = max(t);

UT = [t',Tm',Tt'];
opt = simset('ReturnWorkspaceOutputs', 'off');
[T,X,Y] = sim('Gear_Chain',Timespan,opt, UT);
sub.reload;

figure
plot(T,Y(:,1));
title('Wheel Speed')
xlabel('Time [s]')
ylabel('Wheel Speed [rad/s]')
figure
plot(Y(:,1),Y(:,2));
xlabel('Wheel Speed [rad/s]');
ylabel('Wheel Torque [Nm]');
title('Lossy chain')
