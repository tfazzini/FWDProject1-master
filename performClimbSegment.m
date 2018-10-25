function [Wf_Wi, Treq, Sreq, alpha] =...
    performClimbSegment(T_SL, S, WTO, Wi, Vi, hi, power, hf, Vf, BC)

% Required computed paraeters
val = getStdValues();
g0 = val.g0;
gamma = val.gam;
Pstd = val.Pstd;
astd = val.astd;
deltah = hf - hi;
deltaV2 = Vf^2 - Vi^2;
dV2g = deltaV2/(2*g0);
avgV = mean([Vi, Vf]);
avgh = mean([hi, hf]);
[M,~,~,rho,~,M0,~] = atmModel(avgV, avgh);
[TSFC,~,C1,C2]  = calcTSFC(power, avgV, avgh);
alpha = calcThrustLapse(power, avgV, avgh);
beta = Wi/WTO;

% Aerodynamic paraeters
aero = getAeroData();
CD0 = aero.CD0;
K1 = aero.K1;
K2 = aero.K2;
[CD0, K1] = adjustAero(M0, CD0, K1);

q = (1/2)*rho*(avgV^2);
% if BC == true
%     [~,~,CL,CD] = calcBCAandBCM(S, WTO, Wi);
% else
%     LD = aero.LDmax;
%     CD = Wi/(q*S);
%     CL = LD*CD;
delta = calcDeltaFromAlt(avgh);
CL = (2*beta*(WTO/S))/(gamma*Pstd*delta*(M^2));
CD = (K1*CL^2) + (K2*CL) + CD0;
% end

% Calculating weight fraction
u = (CD/CL)*(beta/alpha)*(WTO/T_SL);
% if u > 1
%     x = 5
% end

Wf_Wi = exp(-(((C1/M)+C2)/astd)*((deltah + dV2g)/(1 - u)));
%Wf_Wi = exp(-(TSFC/avgV)*((deltah + dV2g)/(1 - u)));

% Calculate thurst and wing area required
Sreq = (beta*WTO)/(q*CL);
Treq = CD*q*Sreq;

end