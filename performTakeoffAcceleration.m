function  [Wf_Wi, hf, Vf, Treq, Sreq, alpha, fuelBurned, sG] =...
    performTakeoffAcceleration(T_SL, S, WTO, Wi, Vi, hi, power, input)

% Aerodynamic parameters
aero = getAeroData();
CLmax = aero.CLmax;
CD0 = aero.CD0;
CDR = aero.CDR;
K1 = aero.K1;
K2 = aero.K2;

% Input parameters
mu = input.takeoff.mu_TO;
k_TO = input.takeoff.k_TO;

% Required computed parameters
val = getStdValues();
g0 = val.g0;
[~,~,~,rho,~,~,~] = atmModel(Vi, hi);

% Calculate takeoff velocity
Vstall = calcVstall(S, Wi, Vi, hi);
VTO = k_TO*Vstall;

% Required computed parameters
[TSFC,~,~,~] = calcTSFC(power, mean([Vi, VTO]), hi);
alpha = calcThrustLapse(power, mean([Vi, VTO]), hi);
beta = Wi/WTO;
   % Calculate dynamic pressure
q = (1/2)*rho*(VTO^2);

% Calculate thurst required to overcome drag and area required
    % L = W 
Sreq = (beta*WTO)/(q*CLmax);
    % Calculate CD at CLmax
CD = CD0 + CLmax*K2 + (CLmax^2)*K1;
epsilonTO = CD + CDR - mu*CLmax; 
    % Calculate T = D + R to determine Treq
Treq = epsilonTO*q*Sreq + mu*beta*WTO;

% Calculate ground roll distance
sG = -(beta*(WTO/S))/(rho*g0*epsilonTO)*...
    log(1 - (epsilonTO/(((alpha/beta)*(T_SL/WTO)-mu)*(CLmax/(k_TO^2)))));

% Calculate weight fraction
u = (epsilonTO*(q/beta)*(S/WTO) + mu)*(beta/alpha)*(WTO/T_SL);

Wf_Wi = exp(-(TSFC/g0)*(VTO/(1 - u)));

Wf = Wi * Wf_Wi;

fuelBurned = Wi - Wf;

hf = hi;
Vf = VTO;

end
