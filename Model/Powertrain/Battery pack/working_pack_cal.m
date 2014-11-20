% just a scratch workspace to test pack calibration stuff
% abk - nov 2014

clear;

cd('Data/Raw/');
generate_parameters();
out = calibrate_pack_RC(0.0254,0.0287,872.254,2.7018,Idc,V);

yout = out.get('yout');
tout = out.get('tout');

%% plot
clf;
hold on;
plot(tout, yout(:,2));
plot(V, 'r-');
hold off;
legend('Sim', 'Truth');

%% error
outV = timeseries(yout(:,2),tout);		% output terminal voltage timeseries
sse = V - resample(outV,V.time);
sse = sum((sse.Data).^2);

%% try to optimize
cd('Data/Raw/');
generate_parameters();

guess.R0 = 0.025;
guess.R1 = 0.025;
guess.C1 = 1000;
guess.Capacity = 2.5;

fxn = @(x)calibrate_pack_RC(x(1), x(2), x(3), x(4), Idc, V);
[result, what, sse] = fminsearch( fxn, [guess.R0 guess.R1 guess.C1 guess.Capacity]);