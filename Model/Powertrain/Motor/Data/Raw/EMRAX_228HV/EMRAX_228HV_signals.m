% Signals used in the EMRAX_228HV model

eta_m				=	Simulink.Signal;
eta_m.DocUnits		=	'';
eta_m.Description	=	'Motor efficiency (instantaneous)';

Pwaste				=	Simulink.Signal;
Pwaste.DocUnits		=	'W';
Pwaste.Description	=	'Motor waste power (to heat)';

Vs					=	Simulink.Signal;
Vs.DocUnits			=	'V';
Vs.Description		=	'Motor terminal voltage (bus)';