load freerun

y_freerun = polyfit(RPM_free(3:end),POWER_free(3:end)./(RPM_free(3:end).*0.104719755),2);

y = polyval(y_freerun,RPM_free(3:end));

figure
hold all
plot(RPM_free(3:end),POWER_free(3:end)./(RPM_free(3:end).*0.104719755))
plot(RPM_free(3:end),y)

%%
load CdA_data
%   CdA_data{a,b}
%   a: varible identfier 
%       1: RPM
%       2: Time (s)
%   b: run idenifier
%       1-7

air_density = 1.187;
bike_mass = 236.04 + 90.71 ;
gravity = 9.81;
eff_tyre = 0.01843; %(m/s)/RPM
motor_eff = .2;
ds = 20;
alpha = -0.0157;

close all
figure
hold all
for i = [1:7]
    plot(CdA_data{1,i}.*eff_tyre);
end
title('Coast Down Test')
xlabel('samples')
ylabel('speed m/s')
legend('1','2','3','4','5','6','7')

figure
hold all
% for i = [1:7]
%     %acceleration
%     CdA_data{3,i} = diff(downsample((CdA_data{1,i}.*eff_tyre),ds))./(diff(downsample(CdA_data{2,i},ds)));
%     
%     %downsample speed
%     CdA_data{4,i} = downsample(CdA_data{1,i},ds);
%     scatter(CdA_data{4,i}(2:end),CdA_data{3,i})
% end
for i = [1:7]
    %acceleration
    I = find(diff(CdA_data{1,i}));
    
    CdA_data{3,i} = diff(CdA_data{1,i}(I)*eff_tyre)./diff(CdA_data{2,i}(I)); 
    
    %filter data
    CdA_data{4,i} = CdA_data{1,i}(I);
    plot(CdA_data{4,i}(2:end),CdA_data{3,i})
end
title('Coast Down Test Accleration')
xlabel('RPM')
ylabel('Acceleration m/s^2')
legend('1','2','3','4','5','6','7')

k = 0;
Speed = 0;
Accel = 0;
for i = [1,3,5]
    %make on big array of all data
    Speed = vertcat(Speed(2:end),CdA_data{4,i}.*eff_tyre);
    
    
    RPM = Speed./eff_tyre;

    Accel = vertcat(Accel,CdA_data{3,i}); 
end
I = find(Speed < 30);



% Identify model of form F = 0.5*Cda*air_density*x^2 + r*bike_mass*gravity*x*cos(alpha) + bike_mass*gravity*sin(alpha)

grad = ones(length(Accel),1).*bike_mass.*gravity.*sin(alpha);
aero = 0.5.*air_density.*Speed.^2;
tire = bike_mass.*gravity.*Speed.*cos(alpha);
motor = polyval(y_freerun,RPM)./eff_tyre;

Y = -Accel.*bike_mass - grad - motor;

H = [aero tire];

% Identify parameter vector P
x = inv(H'*H)*H'*Y

figure
hold all
scatter(Speed,Y)
scatter(Speed,aero*x(1) + tire*x(2))
scatter(Speed,aero*.4 + tire*.002)

title('Cost Down Calibration')
xlabel('Speed [m/s]')
ylabel('Force due to drag and tire [m/s^2]')
legend('data','least squares','guess')


Speed = 0;
Accel = 0;
for i = [6,7]
    %make on big array of all data
    Speed = vertcat(Speed(2:end),CdA_data{4,i}.*eff_tyre);
    
    
    RPM = Speed./eff_tyre;

    Accel = vertcat(Accel,CdA_data{3,i}); 
end

alpha = 0.0157;
grad = ones(length(Accel),1).*bike_mass.*gravity.*sin(alpha);
aero = 0.5.*air_density.*Speed.^2;
tire = bike_mass.*gravity.*Speed.*cos(alpha);
motor = polyval(y_freerun,RPM)./eff_tyre;

Y = -Accel.*bike_mass + grad - motor;


figure
hold all
scatter(Speed,Y)
scatter(Speed,aero*x(1) + tire*x(2))
scatter(Speed,aero*.4 + tire*.002)

title('Cost Down Validation')
xlabel('Speed [m/s]')
ylabel('Force due to drag and tire [m/s^2]')
legend('data','least squares','guess')



