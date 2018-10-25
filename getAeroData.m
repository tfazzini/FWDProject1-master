function [aero] = getAeroData()

% Aircraft type
aero.type = 'fighter';

% Aerodynamic parameters based on assumed airfoil
aero.CLmax = 0.766;
aero.CD0 = 0.018;
aero.AR = 4.8; % Aspect ratio
aero.e = 0.94; % Oswald's efficiency factor
aero.K1 = 1/(pi*aero.e*aero.AR); % Induced drag coefficient
aero.K2 = 0; % Interference drag coefficient
aero.CDR = 0.005;
aero.Mcrit = 0.8; % NEED TO FIND A VALUE FOR THIS
aero.LDmax = 13;
aero.T0 = 90;



end
