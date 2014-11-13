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
plot(Y(:,1));
figure
plot(Y(:,2));
