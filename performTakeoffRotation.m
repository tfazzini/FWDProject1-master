function [Wf_Wi, hf, Vf, Treq, Sreq, alpha, s, theta] =...
    performTakeoffRotation(T_SL, S, WTO, Wi, Vi, hi, power, rotateTime,...
    input)

% Aerodynamic paraeters
aero = getAeroData();
CLmax = aero.CLmax;
CD0 = aero.CD0;
CDR = aero.CDR;
K1 = aero.K1;
K2 = aero.K2;

% Input parameters
mu = input.takeoff.mu_TO;
k_TO = input.takeoff.k_TO;
ROCmax = input.takeoff.ROCmax;

% Required computed parameters
val = getStdValues();
g0 = val.g0;
[~,~,~,rho,~,~] = atmModel(Vi, hi);
TSFC = calcTSFC(power, Vi, hi);
alpha = calcThrustLapse(power, Vi, hi);
beta = Wi/WTO;

% Calculate takeoff velocity
% Vstall = calcVstall(S, Wi, Vi, hi);
% VTO = k_TO*Vstall;
VTO=Vi;
   % Calculate dynamic pressure
q = (1/2)*rho*(VTO^2);

% Calculate thrust required to overcome drag and area required
    % L = W 
Sreq = (beta*WTO)/(q*CLmax);
    % Calculate CD at CLmax
CD = CD0 + CLmax*K1 + (CLmax^2)*K2;
epsilonTO = CD + CDR - mu*CLmax; 
    % Calculate T = D + R to determine Treq
Treq = epsilonTO*q*Sreq + mu*beta*WTO;

if ROCmax > 0
    theta = asin((1/VTO)*ROCmax);
else 
    theta = asin((Ta - Treq)/Wi);
end
% Calculate the rotation distance
sR = rotateTime*VTO;
sTR = ((VTO^2)*sin(theta))/(g0*(0.8*(k_TO^2) - 1));
s = sR + sTR;

% Calculate weight fraction
Wf_Wi = 1 - TSFC*(alpha/beta)*(T_SL/WTO)*rotateTime;

% Calculate rotation height
hTR = ((VTO^2)*(1-cos(theta)))/(g0*(0.8*(k_TO^2) - 1));

hf = hTR;
Vf = VTO;

end
