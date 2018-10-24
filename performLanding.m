function  [Wf, hf, Vf, Treq, Sreq, alpha, sB] =...
    performLanding(S, WTO, Wi, Vi, power, hf, input)

% Aerodynamic parameters
aero = getAeroData();
CLmax = aero.CLmax;
CD0 = aero.CD0;
CDR = aero.CDR;
K1 = aero.K1;
K2 = aero.K2; 

% Input parameters
mu = input.land.mu_L;
k_TD = input.land.k_TD;

% Standard parameters
val = getStdValues();
g0 = val.g0;
% To reach landing height, descend to landing alt, and descent is a weight
% fraction value of 1.0
landingWf_Wi = val.land;

% Calculate total weight fraction
Wf = landingWf_Wi * Wi;

% Required computed parameters
Vstall = calcVstall(S, Wi, Vi, hf);
VTD = k_TD*Vstall;

[~,~,~,rho,~,~] = atmModel(Vi, hf);
alpha = calcThrustLapse(power, Vi, hf);
beta = Wf/WTO;
   % Calculate dynamic pressure
q = (1/2)*rho*(mean([VTD, 0])^2);
CD = CD0 + K1*(CLmax^2) + K2*CLmax;

% Calculate area required and required thrust is zero
    % L = W 
Sreq = (beta*WTO)/(q*CLmax);
epsilonL = (CD + CDR - mu*CLmax); 
Treq = 0;

% Calculate ground roll distance
sB = -(beta*(WTO/S))/(rho*g0*epsilonL)*...
    log(1 + (-1*epsilonL/((mu)*(CLmax/(k_TD^2)))));

Vf = 0;

end
