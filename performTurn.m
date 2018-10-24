function [Wf, hf, Vf, Treq, Sreq, alpha] =...
    performTurn(S, WTO, Wi, Vf, hf, power, n, time)

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
LD = aero.LDmax;
[CD0, K1] = adjustAero(M0, CD0, K1);

q = (1/2)*rho*(Vf^2);
a = K1;
b = K2;
c = -((Wi/(q*S*LD)) - CD0);
CL = max(roots([a b c]));
if isreal(CL) == 0
    CL = Wi/(q*S);
end
CD = CD0 + K1*(CL^2) + K2*CL;

% Calculating weight fraction
Wf_Wi = exp(-TSFC*((n*CD)/CL)*time);

Wf = Wf_Wi * Wi;

% Calculate thurst and wing area required
Sreq = (beta*WTO)/(q*CL);
Treq = CD*q*Sreq;
hf = hf;
Vf = Vf;

end