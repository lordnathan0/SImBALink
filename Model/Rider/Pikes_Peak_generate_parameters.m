
                                 
Rider_I = Simulink.Parameter;
Rider_I.Value = 0;
Rider_I.CoderInfo.StorageClass = 'Auto';
Rider_I.CoderInfo.Alias = '';
Rider_I.CoderInfo.Alignment = -1;
Rider_I.CoderInfo.CustomStorageClass = 'Default';
%Rider_I.CoderInfo.CustomAttributes.ConcurrentAccess = false;
Rider_I.Description = 'Integral Control Constant';
Rider_I.DataType = 'auto';
Rider_I.Min = [];
Rider_I.Max = [];
Rider_I.DocUnits = 'nan';

Rider_P = Simulink.Parameter;
Rider_P.Value = 100;
Rider_P.CoderInfo.StorageClass = 'Auto';
Rider_P.CoderInfo.Alias = '';
Rider_P.CoderInfo.Alignment = -1;
Rider_P.CoderInfo.CustomStorageClass = 'Default';
%Rider_P.CoderInfo.CustomAttributes.ConcurrentAccess = false;
Rider_P.Description = 'Proportional Control Constant';
Rider_P.DataType = 'auto';
Rider_P.Min = [];
Rider_P.Max = [];
Rider_P.DocUnits = 'nan';

Rider_D = Simulink.Parameter;
Rider_D.Value = 1;
Rider_D.CoderInfo.StorageClass = 'Auto';
Rider_D.CoderInfo.Alias = '';
Rider_D.CoderInfo.Alignment = -1;
Rider_D.CoderInfo.CustomStorageClass = 'Default';
%Rider_D.CoderInfo.CustomAttributes.ConcurrentAccess = false;
Rider_D.Description = 'Proportional Control Constant';
Rider_D.DataType = 'auto';
Rider_D.Min = [];
Rider_D.Max = [];
Rider_D.DocUnits = 'nan';

load('least_square_cdts_11_10.mat')
I_nonzero = find(diff(distance) ~= 0);

SpeedProfile_x = Simulink.Parameter;
SpeedProfile_x.Value = distance(I_nonzero);
SpeedProfile_x.CoderInfo.StorageClass = 'Auto';
SpeedProfile_x.CoderInfo.Alias = '';
SpeedProfile_x.CoderInfo.Alignment = -1;
SpeedProfile_x.CoderInfo.CustomStorageClass = 'Default';
%SpeedProfile_x.CoderInfo.CustomAttributes.ConcurrentAccess = false;
SpeedProfile_x.Description = 'Distance For speed profile';
SpeedProfile_x.DataType = 'auto';
SpeedProfile_x.Min = [];
SpeedProfile_x.Max = [];
SpeedProfile_x.DocUnits = 'm';

SpeedProfile_y = Simulink.Parameter;
SpeedProfile_y.Value = speed(I_nonzero);
SpeedProfile_y.CoderInfo.StorageClass = 'Auto';
SpeedProfile_y.CoderInfo.Alias = '';
SpeedProfile_y.CoderInfo.Alignment = -1;
SpeedProfile_y.CoderInfo.CustomStorageClass = 'Default';
%SpeedProfile_y.CoderInfo.CustomAttributes.ConcurrentAccess = false;
SpeedProfile_y.Description = 'Speeds for the speed profile';
SpeedProfile_y.DataType = 'auto';
SpeedProfile_y.Min = [];
SpeedProfile_y.Max = [];
SpeedProfile_y.DocUnits = 'm/s';

save('Pikes_Peak_Rider_PID.mat','SpeedProfile_y','SpeedProfile_x','Rider_P','Rider_I', 'Rider_D');


