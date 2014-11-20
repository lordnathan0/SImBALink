close all
sub = get_param('Tires','ModelWorkspace');
sub.reload;

%%

Ct = evalin(sub,'Ct');

ws = [0:.01:1];
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

%%

Ct = evalin(sub,'Ct');
ws = [-1:.01:1];
dur = length(ws);
t = [1:1:dur];
v = ones(dur,1)*.1;
wt = (((ws'.*v)-v)/-Ct);
Ol = ones(dur,1) .* 0;
Tg = ones(dur,1) .* 450/Ct;
Flong = ones(dur,1) .* 0;
Fb = ones(dur,1) .* 0;
Fn = ones(dur,1) .* 400;
Timespan = max(t);

UT = [t',v, wt,Ol,Tg,Flong, Fb, Fn];
opt = simset('ReturnWorkspaceOutputs', 'off');
[T,X,Y] = sim('Tires',Timespan,opt, UT);
sub.reload;

figure
hold all
plot(Y(:,2),Y(:,1))
plot(Y(:,2),Y(:,6))
title('Validate Traction')
xlabel('Slip Speed [ratio]')
ylabel('Tire Force [N]')
legend('Limited','Max');




