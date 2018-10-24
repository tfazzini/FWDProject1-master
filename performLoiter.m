function [Wf, hf, Vf, Treq, Sreq, alpha] =...
    performLoiter(S, WTO, Wi, power, hf, Vf, time)

BC = false;
if strcmp(hf,'BCA') == 1 || strcmp(Vf,'BCM') == 1
    [hf, Vf, CL, CD] = calcBCAandBCM(S, WTO, Wi);
    BC = true;
end

if strcmp(Vf,'max_endurance') == 1
    Vf = calcMaxEnduranceSpeed(hf);
end

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
if BC == false
    LD = aero.LDmax;
    CD = Wi/(q*S);
    CL = LD*CD;
end

% Calculate weight fraction
Wf_Wi = exp(-TSFC*(sqrt(4*CD0*K1)+K2)*time);

Wf = Wf_Wi * Wi;

% Calculate thurst and wing area required
Sreq = (beta*WTO)/(q*CL);
Treq = CD*q*Sreq;

end