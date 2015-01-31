function [R0, R1, C1, Capacity] = calibrate_RC()
%calibrate_RC Calculate equivalent-circuit cell model resistances
% This function assumes that the Buckeye Current "Scripts" directory is on
% the MATLAB path.

%%% Resistance calibration
display 'Calibrating resistances...'
[Idc, V] = read_maccor( 'Curr_Cell8B_Res_111314_2 - 008.csv' );

% Drop the first 10k points because they probably have a charge cycle in
% them :|
Idc			= delsample( Idc, 'Index', [1:10000] );
V			= delsample( V, 'Index', [1:10000] );

% starting points for calibration
guess.R0 = 0.025;
guess.R1 = 0.01;
guess.C1 = 400;
guess.Capacity = 2.5;

fxn = @(x)calibrate_pack_RC(x(1), x(2), x(3), x(4), Idc, V);

options = optimset('PlotFcns',@optimplotfval);
rc = fminsearch( fxn, [guess.R0 guess.R1 guess.C1 guess.Capacity], options);

R0	=	rc(1);
R1	=	rc(2);
C1	=	rc(3);
Capacity = rc(4);

end
