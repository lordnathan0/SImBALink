close all
load Tire_Val

%magic number validation on BikeSim Data

k = Slip;

x = fsolve(@magic_err,[10,1.9,1,.97])

u = x(3).*sin(x(2).*atan(( x(1).*k - x(4).*(x(1).*k - atan(x(1).*k)))));



figure
hold all
plot(k,u);
plot(k,Fmax400./400);
legend('Fit','Data');
title('Tire Calibration');
xlabel('Slip')
ylabel('Tire coeffient')


figure
hold all
plot(k,u);
plot(k,Fmax1000./1000);
plot(k,Fmax1600./1600);
plot(k,Fmax2200./2200);
legend('Fit','Fn = 1000','Fn = 1600','Fn = 2200');
title('Tire Validation');
xlabel('Slip')
ylabel('Tire coeffient')




