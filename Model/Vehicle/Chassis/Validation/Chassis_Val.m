close all
load CdA_data
%   CdA_data{a,b}
%   a: varible identfier 
%       1: RPM
%       2: Time (s)
%   b: run idenifier
%       1-7
%
% air density 
% alpha (road grad)
% bike_mass (including rider)
% eff_tyre (effective tire mps / RPM)
figure
hold all
for i = [1,3,5]
    %acceleration
    I = find(diff(CdA_data{1,i}));
    
    CdA_data{3,i} = (diff(CdA_data{1,i}(I).*eff_tyre)./diff(CdA_data{2,i}(I)))*-bike_mass; 
    
    %filter data
    CdA_data{4,i} = CdA_data{1,i}(I).*eff_tyre;
    scatter(CdA_data{4,i}(2:end),CdA_data{3,i})
end
title('Coast Down Test')
xlabel('Speed [m/s]')
ylabel('Force [N]')


sub = get_param('Chassis','ModelWorkspace');
sub.reload;

assignin(sub,'v0',40);

dur = 1100;
Ft = ones(1,dur) * -10;
rho = ones(1,dur)*1.2;
Or = ones(1,dur)*-alpha;
Rc = ones(1,dur) * 100000;

t = [1:1:dur];
Timespan = max(t);

UT = [t',Ft',rho', Or',Rc'];
opt = simset('ReturnWorkspaceOutputs', 'off');
[T,X,Y] = sim('Chassis',Timespan,opt, UT);

plot(Y(:,1),Y(:,3));

assignin(sub,'CdA',.5);
UT = [t',Ft',rho', Or',Rc'];
opt = simset('ReturnWorkspaceOutputs', 'off');
[T,X,Y] = sim('Chassis',Timespan,opt, UT);

plot(Y(:,1),Y(:,3));

assignin(sub,'CdA',.6);
UT = [t',Ft',rho', Or',Rc'];
opt = simset('ReturnWorkspaceOutputs', 'off');
[T,X,Y] = sim('Chassis',Timespan,opt, UT);
sub.reload;

plot(Y(:,1),Y(:,3));
legend('data 1','data 3','data 5', 'Sim CdA = .4', 'Sim CdA = .5', 'Sim CdA = .6')

%% normal force and lean angle

%assignin(sub,'CdA',.5);
dur = 1100;
Ft = ones(1,dur) * 0;
rho = ones(1,dur)*1.2;
Or = linspace(-1,1,dur);
t = [1:1:dur];
Rc = ones(1,dur) * 100000;
Timespan = max(t);

UT = [t',Ft',rho', Or',Rc'];
opt = simset('ReturnWorkspaceOutputs', 'off');
[T,X,Y] = sim('Chassis',Timespan,opt, UT);

figure
scatter(Y(:,6),Y(:,4))
title('Normal Force Validation')
xlabel('Road Gradient [rad]')
ylabel('Normal Force [N]')



dur = 1000;
assignin(sub,'v0',10);

Rc = linspace(400,10,dur);
Ft = ones(1,dur) * 0;
rho = ones(1,dur)*1.2;
Or = ones(1,dur) * 0;
t = [1:1:dur];
Timespan = max(t);

UT = [t',Ft',rho', Or',Rc'];
opt = simset('ReturnWorkspaceOutputs', 'off');
[T,X,Y] = sim('Chassis',Timespan,opt, UT);

figure
scatter(Y(:,7),Y(:,5).*(180/pi))
title('Lean Angle Validation 10 m/s')
xlabel('Road Corner Radius [m]')
ylabel('Lean Angle [Degree]')