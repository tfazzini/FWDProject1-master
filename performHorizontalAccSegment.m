function [Wf_Wi, Vf, Treq, Sreq, alpha] =...
    performHorizontalAccSegment(T_SL, S, WTO, Wi, Vi, hi, power, Vf, BC)

% Required computed paraeters
val = getStdValues();
g0 = val.g0;
deltaV2 = Vf^2 - Vi^2;
dV2g = deltaV2/(2*g0);
avgV = mean([Vi, Vf]);
[~,~,~,rho,~,M0] = atmModel(avgV, hi);
TSFC = calcTSFC(power, avgV, hi);
alpha = calcThrustLapse(power, avgV, hi);
beta = Wi/WTO;

% Aerodynamic paraeters
aero = getAeroData();
CD0 = aero.CD0;
K1 = aero.K1;
K2 = aero.K2;
[CD0, K1] = adjustAero(M0, CD0, K1);

q = (1/2)*rho*(avgV^2);
if BC == true
    [~,~,CL,CD] = calcBCAandBCM(S, WTO, Wi);
else
    LD = 0.866*aero.LDmax;
    CD = Wi/(q*S);
    CL = LD*CD;
end

% Calculating weight fraction
u = (CD/CL)*(beta/alpha)*(WTO/T_SL);

Wf_Wi = exp(-(TSFC/avgV)*(dV2g/(1 - u)));

% Calculate thurst and wing area required
Sreq = (beta*WTO)/(q*CL);
Treq = CD*q*Sreq;

end