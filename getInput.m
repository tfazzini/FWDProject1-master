function [input] = getInput() 

missionTable = readtable('INPUT_TEST2.csv');

% Phase of mission
input.phase = missionTable.flight_condition;

% Power setting of mission
input.power = missionTable.power;

% Velocity (ft/s)
input.V = missionTable.V;

% Altitude (ft)
input.h = missionTable.h;

% Distance (ft)
input.s = missionTable.s;

% Time (min)
input.t = missionTable.t;

inputTable = readtable('segmentInputsBenchmark.csv');

% Aircraft input
input.type = inputTable.type;
input.WP = inputTable.WP;
input.WC = inputTable.WC;

% Takeoff input
input.takeoff.alt = inputTable.alt_TO; % ft
input.takeoff.mu_TO = inputTable.mu_TO;
input.takeoff.k_TO = inputTable.k_TO;
input.takeoff.warmupTime = inputTable.warmupTime; % sec
input.takeoff.accelTime = inputTable.accelTime; % sec
input.takeoff.rotateTime = inputTable.rotateTime; % sec(Raymer says normally 3 sec)
input.takeoff.groundTime = inputTable.groundTime; % sec
input.takeoff.h_obs = inputTable.h_obs;
input.takeoff.ROCmax = inputTable.ROCmax; % ft/s
input.takeoff.startFuel = inputTable.startFuel; % lb/engine
input.takeoff.warmupFuel = inputTable.warmupFuel; % lb/min/engine
input.takeoff.runUpFuel = inputTable.runUpFuel; % lb/engine
input.takeoff.length = inputTable.TO_length; % ft

% Landing input
input.land.alt = inputTable.alt_L; % ft
input.land.mu_L = inputTable.mu_L;
input.land.k_TD = inputTable.k_TD;
input.land.fuelReservePercent = inputTable.fuelReservePercent; % percent
input.land.fuelReserveHeight = inputTable.fuelReserveHeight; % ft
input.land.fuelReserveSpeed = inputTable.fuelReserveSpeed; % fps
input.land.fuelReserveTime = inputTable.fuelReserveTime; % sec
input.land.length = inputTable.L_length; % ft

% Combat information
input.combat.sustain_g = inputTable.sustain_g; % g's
input.combat.instant_g = inputTable.instant_g; % g's
input.combat.dash = inputTable.dash; % M
input.combat.dashTime = inputTable.dashTime; % s

end