


L = Simulink.Parameter;
L.Value = 0.0065;
L.CoderInfo.StorageClass = 'Auto';
L.CoderInfo.Alias = '';
L.CoderInfo.Alignment = -1;
L.CoderInfo.CustomStorageClass = 'Default';
%L.CoderInfo.CustomAttributes.ConcurrentAccess = false;
L.Description = 'rate of degree change per meter of altitude change';
L.DataType = 'auto';
L.Min = [];
L.Max = [];
L.DocUnits = 'K/m';

M = Simulink.Parameter;
M.Value = 28.9644;
M.CoderInfo.StorageClass = 'Auto';
M.CoderInfo.Alias = '';
M.CoderInfo.Alignment = -1;
M.CoderInfo.CustomStorageClass = 'Default';
%M.CoderInfo.CustomAttributes.ConcurrentAccess = false;
M.Description = 'Molar Mass of air';
M.DataType = 'auto';
M.Min = [];
M.Max = [];
M.DocUnits = '';

P0 = Simulink.Parameter;
P0.Value = 100000;
P0.CoderInfo.StorageClass = 'Auto';
P0.CoderInfo.Alias = '';
P0.CoderInfo.Alignment = -1;
P0.CoderInfo.CustomStorageClass = 'Default';
%P0.CoderInfo.CustomAttributes.ConcurrentAccess = false;
P0.Description = 'Preasure at 0 altitude';
P0.DataType = 'auto';
P0.Min = [];
P0.Max = [];
P0.DocUnits = 'Pa';

R = Simulink.Parameter;
R.Value = 8.31432;
R.CoderInfo.StorageClass = 'Auto';
R.CoderInfo.Alias = '';
R.CoderInfo.Alignment = -1;
R.CoderInfo.CustomStorageClass = 'Default';
%R.CoderInfo.CustomAttributes.ConcurrentAccess = false;
R.Description = 'Air Constant';
R.DataType = 'auto';
R.Min = [];
R.Max = [];
R.DocUnits = '';

load('pikes_peak_updated_20pt_least_sqaures.mat')
I_nonzero = find(diff(distance) ~= 0);

Rcx = Simulink.Parameter;
Rcx.Value = distance(I_nonzero);
Rcx.CoderInfo.StorageClass = 'Auto';
Rcx.CoderInfo.Alias = '';
Rcx.CoderInfo.Alignment = -1;
Rcx.CoderInfo.CustomStorageClass = 'Default';
%Rcx.CoderInfo.CustomAttributes.ConcurrentAccess = false;
Rcx.Description = 'distance for radius profile';
Rcx.DataType = 'auto';
Rcx.Min = [];
Rcx.Max = [];
Rcx.DocUnits = 'm';

Rcy = Simulink.Parameter;
Rcy.Value = radius(I_nonzero);
Rcy.CoderInfo.StorageClass = 'Auto';
Rcy.CoderInfo.Alias = '';
Rcy.CoderInfo.Alignment = -1;
Rcy.CoderInfo.CustomStorageClass = 'Default';
%Rcy.CoderInfo.CustomAttributes.ConcurrentAccess = false;
Rcy.Description = 'radius in radius profile';
Rcy.DataType = 'auto';
Rcy.Min = [];
Rcy.Max = [];
Rcy.DocUnits = 'm';

T0 = Simulink.Parameter;
T0.Value = 300;
T0.CoderInfo.StorageClass = 'Auto';
T0.CoderInfo.Alias = '';
T0.CoderInfo.Alignment = -1;
T0.CoderInfo.CustomStorageClass = 'Default';
%T0.CoderInfo.CustomAttributes.ConcurrentAccess = false;
T0.Description = 'degrees at 0 altitude ';
T0.DataType = 'auto';
T0.Min = [];
T0.Max = [];
T0.DocUnits = 'K';

load('disttoalt_pp.mat')
I_nonzero = find(diff(distance) ~= 0);

altx = Simulink.Parameter;
altx.Value = distance(I_nonzero);
altx.CoderInfo.StorageClass = 'Auto';
altx.CoderInfo.Alias = '';
altx.CoderInfo.Alignment = -1;
altx.CoderInfo.CustomStorageClass = 'Default';
%altx.CoderInfo.CustomAttributes.ConcurrentAccess = false;
altx.Description = 'distance in alt profile';
altx.DataType = 'auto';
altx.Min = [];
altx.Max = [];
altx.DocUnits = 'm';

alty = Simulink.Parameter;
alty.Value = altitude(I_nonzero);
alty.CoderInfo.StorageClass = 'Auto';
alty.CoderInfo.Alias = '';
alty.CoderInfo.Alignment = -1;
alty.CoderInfo.CustomStorageClass = 'Default';
%alty.CoderInfo.CustomAttributes.ConcurrentAccess = false;
alty.Description = 'alt in alt profile';
alty.DataType = 'auto';
alty.Min = [];
alty.Max = [];
alty.DocUnits = 'm';

g = Simulink.Parameter;
g.Value = 9.81;
g.CoderInfo.StorageClass = 'Auto';
g.CoderInfo.Alias = '';
g.CoderInfo.Alignment = -1;
g.CoderInfo.CustomStorageClass = 'Default';
%g.CoderInfo.CustomAttributes.ConcurrentAccess = false;
g.Description = '';
g.DataType = 'auto';
g.Min = [];
g.Max = [];
g.DocUnits = '';

save('Pikes_Peak_Environment.mat','alty','altx','T0','g','P0','L','R','M','Rcy','Rcx');
