function [sse, r2] = test_model_performance(cell_name)
%% test model performance 

% Name of the directory containing truth data to test against
%truth_dir = 'RedCell_3';
truth_dir = cell_name;

% Name of the truth file to test against
truth_file = 'PikesPeak_discharge';
%truth_file = 'Pulse_Discharge_Test';

truth = fullfile('..', 'Data', 'Truth', truth_dir, truth_file);

% Get timeseries voltage and current data for comparison
load( truth );
%Idc = timeseries( Current, Time );
%V	= timeseries( Voltage, Time );

load_system('Battery_pack');
mws = get_param(bdroot, 'modelworkspace');

% Is this where we want to keep the cell MATfile ?
% temporary
mws.FileName = fullfile('..', 'Data', [cell_name '.mat']);
mws.reload();		% reload workspace from source file
mws.assignin('Idc',Idc);

% Simulate
set_param('Battery_pack', 'StopTime', 'max(Idc.Time)');
set_param('Battery_pack', 'StartTime', 'min(Idc.Time)');
set_param('Battery_pack', 'MaxStep', '0.1');
out = sim('Battery_pack', 'LoadExternalInput', 'on', 'ExternalInput', 'Idc');
outTime = out.get('tout');
outValues = out.get('yout');

simulated.Voltage = timeseries (outValues(:,2), outTime);

%% metrics

sse = simulated.Voltage - resample(V, simulated.Voltage.time);		% resample truth timeseries to sim indices (likely that sim is more frequent, minimizing interpolation error)
sse = sum((sse.Data).^2);

avg = mean(simulated.Voltage.Data);

sst = sum( (simulated.Voltage.Data - avg).^2 );
r2 = 1 - sse/sst;

%% plot
figure(5)
clf;

hold on;
plot(simulated.Voltage);
plot(V, 'r');
title(['Terminal voltage: model and truth vs. time, ' cell_name]);
xlabel('Time (sec)');
ylabel('Terminal voltage (V)');
legend('Model', 'Truth');

annotation('textbox', [0.7,0.2,0.1,0.1], 'String', {['SSE: ' num2str(sse)], ['R^2: ' num2str(r2) ]});

hold off;

saveas(gcf, ['Figures/ModelAgreement_' cell_name '.eps'], 'epsc');
saveas(gcf, ['Figures/ModelAgreement_' cell_name '.png']);

% "pack voltage"
figure(6)
clf;

ax1 = subplot(211);
hold on;
plot(simulated.Voltage*108);
plot(V*108, 'r');
title(['Pack voltage: model and truth vs. time, ' cell_name]);
xlabel('Time (sec)');
ylabel('Pack voltage (V)');
legend('Model', 'Truth');

annotation('textbox', [0.15,0.55,0.1,0.1], 'String', {['SSE: ' num2str(sse)], ['R^2: ' num2str(r2) ]});

xlim([6100 6800]);

ax2 = subplot(212);
hold on;
plot((simulated.Voltage - resample(V, simulated.Voltage.time))*108, 'LineWidth', 1.5);
title( 'Pack voltage error (positive: overestimation)' );
ylabel( 'Voltage error (V)');
grid on;

% "Acceptable error" boundaries at +- 5 V
line([min(simulated.Voltage.Time) max(simulated.Voltage.Time)], [5 5], 'LineWidth', 2, 'Color', 'Red');
line([min(simulated.Voltage.Time) max(simulated.Voltage.Time)], [-5 -5], 'LineWidth', 2, 'Color', 'Red');
hold off;

linkaxes([ax1 ax2], 'x');

hold off;

saveas(gcf, ['Figures/ModelAgreement_packvoltage' cell_name '.eps'], 'epsc');
saveas(gcf, ['Figures/ModelAgreement_packvoltage' cell_name '.png']);

