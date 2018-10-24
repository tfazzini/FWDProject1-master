function [Wf, hf, Vf, Treq, Sreq, alpha, time] =...
    performInstantaneousTurn(S, WTO, Wi, Vf, hf, power, n)

% Required computed paraeters
[~,~,~,rho,~,M0] = atmModel(Vf, hf);
TSFC = calcTSFC(power, Vf, hf);
alpha = calcThrustLapse(power, Vf, hf);
beta = Wi/WTO;

% Aerodynamic paraeters
aero = getAeroData();
CD0 = aero.CD0;
K1 = aero.K1;
K2 = aero.K2;
CLmax = aero.CLmax;
[CD0, K1] = adjustAero(M0, CD0, K1);

% Required velocity
V = sqrt((2*n*Wi)/(rho*S*CLmax));

q = (1/2)*rho*(V^2);
CLmax = Wi/(q*S);
CD = CD0 + K1*(CLmax^2) + K2*CLmax;

% Calculating weight fraction
val = getStdValues();
g0 = val.g0;
time = (2*pi*V)/(g0*sqrt((n^2) - 1));

Wf_Wi = exp(-TSFC*((n*CD)/CLmax)*time);

Wf = Wf_Wi * Wi;

% Calculate thurst and wing area required
Sreq = (beta*WTO)/(q*CLmax);
Treq = CD*q*Sreq;

end