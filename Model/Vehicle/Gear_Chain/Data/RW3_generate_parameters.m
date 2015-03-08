
Jc = Simulink.Parameter;
Jc.Value = 0;
Jc.CoderInfo.StorageClass = 'Auto';
Jc.CoderInfo.Alias = '';
Jc.CoderInfo.Alignment = -1;
Jc.CoderInfo.CustomStorageClass = 'Default';
%Jc.CoderInfo.CustomAttributes.ConcurrentAccess = false;
Jc.Description = 'chain inertia';
Jc.DataType = 'auto';
Jc.Min = [];
Jc.Max = [];
Jc.DocUnits = 'kg m^2';

Jg = Simulink.Parameter;
Jg.Value = 0;
Jg.CoderInfo.StorageClass = 'Auto';
Jg.CoderInfo.Alias = '';
Jg.CoderInfo.Alignment = -1;
Jg.CoderInfo.CustomStorageClass = 'Default';
%Jg.CoderInfo.CustomAttributes.ConcurrentAccess = false;
Jg.Description = 'gear inertia';
Jg.DataType = 'auto';
Jg.Min = [];
Jg.Max = [];
Jg.DocUnits = 'kg m^2';

Jm = Simulink.Parameter;
Jm.Value = 4.72;
Jm.CoderInfo.StorageClass = 'Auto';
Jm.CoderInfo.Alias = '';
Jm.CoderInfo.Alignment = -1;
Jm.CoderInfo.CustomStorageClass = 'Default';
%Jm.CoderInfo.CustomAttributes.ConcurrentAccess = false;
Jm.Description = 'motor inertia';
Jm.DataType = 'auto';
Jm.Min = [];
Jm.Max = [];
Jm.DocUnits = 'kg m^2';

Jt = Simulink.Parameter;
Jt.Value = 1;
Jt.CoderInfo.StorageClass = 'Auto';
Jt.CoderInfo.Alias = '';
Jt.CoderInfo.Alignment = -1;
Jt.CoderInfo.CustomStorageClass = 'Default';
%Jt.CoderInfo.CustomAttributes.ConcurrentAccess = false;
Jt.Description = 'tire inertia';
Jt.DataType = 'auto';
Jt.Min = [];
Jt.Max = [];
Jt.DocUnits = 'kg m^2';

Rg = Simulink.Parameter;
Rg.Value = 1.8;
Rg.CoderInfo.StorageClass = 'Auto';
Rg.CoderInfo.Alias = '';
Rg.CoderInfo.Alignment = -1;
Rg.CoderInfo.CustomStorageClass = 'Default';
%Rg.CoderInfo.CustomAttributes.ConcurrentAccess = false;
Rg.Description = 'Gear Ratio';
Rg.DataType = 'auto';
Rg.Min = [];
Rg.Max = [];
Rg.DocUnits = '';

ceffx = Simulink.Parameter;
ceffx.Value = [0; 78.53981625; 157.0796325; 230.383461; 314.159265; 366.5191425; ...
               ];
ceffx.CoderInfo.StorageClass = 'Auto';
ceffx.CoderInfo.Alias = '';
ceffx.CoderInfo.Alignment = -1;
ceffx.CoderInfo.CustomStorageClass = 'Default';
%ceffx.CoderInfo.CustomAttributes.ConcurrentAccess = false;
ceffx.Description = 'rad/s of chain eff lookup';
ceffx.DataType = 'auto';
ceffx.Min = [];
ceffx.Max = [];
ceffx.DocUnits = 'rad/s';

ceffy = Simulink.Parameter;
ceffy.Value = [0.99; 0.99; 0.98; 0.965; 0.94; 0.91];
ceffy.CoderInfo.StorageClass = 'Auto';
ceffy.CoderInfo.Alias = '';
ceffy.CoderInfo.Alignment = -1;
ceffy.CoderInfo.CustomStorageClass = 'Default';
%ceffy.CoderInfo.CustomAttributes.ConcurrentAccess = false;
ceffy.Description = 'Eff of Eff lookup';
ceffy.DataType = 'auto';
ceffy.Min = [];
ceffy.Max = [];
ceffy.DocUnits = '';

w0 = Simulink.Parameter;
w0.Value = 1;
w0.CoderInfo.StorageClass = 'Auto';
w0.CoderInfo.Alias = '';
w0.CoderInfo.Alignment = -1;
w0.CoderInfo.CustomStorageClass = 'Default';
%w0.CoderInfo.CustomAttributes.ConcurrentAccess = false;
w0.Description = 'inital chain velocity ';
w0.DataType = 'auto';
w0.Min = [];
w0.Max = [];
w0.DocUnits = 'rad/s';

save('RW3_Rider_PI.mat','w0','ceffy','ceffx','Rg','P0','Jt','Jm','Jc','Jg');
