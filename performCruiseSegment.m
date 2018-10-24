function [Wf_Wi, Treq, Sreq, alpha] =...
    performCruiseSegment(S, WTO, Wi, power, Vf, hf, s, BC)

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
[CD0, K1] = adjustAero(M0, CD0, K1);

q = (1/2)*rho*(Vf^2);
if BC == true
    [~,~,CL,CD] = calcBCAandBCM(S, WTO, Wi);
else
    LD = 0.866*aero.LDmax;
    CD = Wi/(q*S);
    CL = LD*CD;
end

% Calculating weight fraction
Wf_Wi = exp(-(TSFC/Vf)*(CD/CL)*s);

% Calculate thurst and wing area required
Sreq = (beta*WTO)/(q*CL);
Treq = CD*q*Sreq;

end