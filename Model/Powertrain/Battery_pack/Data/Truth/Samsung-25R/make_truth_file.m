% Make the validation truth file
% abk - Jan 2015

% load file
input	= 'Curr_Cell4B_PP_110614 - 008.csv';
[i, v]	= read_maccor(input);
output	= 'PikesPeak_discharge';
info	= [ 'Generated ' date ' from ' input ];

% truncate
start	= 6.124e4;	% sample number, not time
Idc = delsample(i, 'Index', 1:start );
V = delsample(v, 'Index', 1:start );

% save
save( output, 'Idc', 'V', 'info' );