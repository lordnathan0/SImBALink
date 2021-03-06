close all
sub = get_param('Tires','ModelWorkspace');
sub.reload;

%% magic formula validation

Ct = evalin(sub,'Ct');

ws = [-.5:.01:.5];
dur = length(ws);
t = [1:1:dur];
v = ones(dur,1)*.1;
wt = (((ws'.*v)-v)/-Ct);
Ol = ones(dur,1) .* 0;
Tg = ones(dur,1) .* 0;
Flong = ones(dur,1) .* 0;
Fb = ones(dur,1) .* 0;
Fn = ones(dur,1) .* 400;
Timespan = max(t);

UT = [t',v, wt,Ol,Tg,Flong, Fb, Fn];
opt = simset('ReturnWorkspaceOutputs', 'off');
[T,X,Y] = sim('Tires',Timespan,opt, UT);
sub.reload;


figure
plot(Y(:,2),Y(:,6))
title('Validate Magic Equation F_n = 400')
xlabel('Slip Speed [%]')
ylabel('Max Long Tire Force [N]')





