function [Wf, hf, Vf, Treq, Sreq, alpha] =...
    performDescend(S, WTO, Wi, power, hf, Vf)

% Required computed paraeters
[~,~,~,rho,~,M0] = atmModel(Vf, hf);
alpha = calcThrustLapse(power, Vf, hf);
beta = Wi/WTO;

% Aerodynamic paraeters
aero = getAeroData();
CD0 = aero.CD0;
K1 = aero.K1;
K2 = aero.K2;
[CD0, K1] = adjustAero(M0, CD0, K1);

q = (1/2)*rho*(Vf^2);
LD = aero.LDmax;
a = K1;
b = K2;
c = -((Wi/(q*S*LD)) - CD0);
CL = max(roots([a b c]));
if isreal(CL) == 0
    CL = Wi/(q*S);
end
CD = CD0 + K1*(CL^2) + K2*CL;

% Calculating weight fraction
Wf = Wi;
% Calculate thurst and wing area required
Sreq = (beta*WTO)/(q*CL);
Treq = CD*q*Sreq;

end