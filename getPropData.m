function [prop] = getPropData()

% Engine type
prop.type = 'turbojet';
prop.number = 2; % number of engines

% Sea level static power setting thrust availale values
prop.max = 7650; % lb
prop.military = 5550; % lb
prop.normal = 5100; % lb

% Takeoff constraints
prop.start_constraint = 35; % lb/engine
prop.warmUp_constraint = 25; % lb/min/engine
prop.runUp_constraint = 85; % lb/engine



end
