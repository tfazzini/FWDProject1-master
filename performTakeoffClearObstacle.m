function [Wf_Wi, hf, Vf, Treq, Sreq, alpha, sCL] =...
    performTakeoffClearObstacle(T_SL, WTO, Wi, Vi, hi, power, theta, input)
 
% Aerodynamic paraeters
aero = getAeroData();
CLmax = aero.CLmax;
CD0 = aero.CD0;
K1 = aero.K1;
K2 = aero.K2;

% Input parameters
ROCmax = input.takeoff.ROCmax;
h_obs = input.takeoff.h_obs;

% Required computed parameters
val = getStdValues();
g0 = val.g0;

% Calculate the clearing distance
sCL = (h_obs - hi)/tan(theta);

% Calculate the final velocity, Vclimb, assuming Vclimb is when 
% CL = 0.8CLmax, and then if there is a maximum ROC, check to ensure 
% the calcuated ROC is less than ROCmax, and if not, adjust Vclimb
[~,~,~,rho,~,~,~] = atmModel(Vi, hi);
[TSFC,~,~,~] = calcTSFC(power, Vi, hi);
alpha = calcThrustLapse(power, Vi, hi);
beta = Wi/WTO;

q = (1/2)*rho*(Vi^2);
CL = 0.8*CLmax;
CD = CD0 + K2*CL + K1*(CL^2);

% Calculate thrust and wing area required
Sreq = (beta*WTO)/(q*CL);
Treq = CD*q*Sreq;

Vclimb = sqrt((2*Wi)/(0.8*CLmax*rho*S));  
if ROCmax > 0
    ROC = Vclimb*sin(theta_obs);
    if ROC > ROCmax
        Vclimb = ROCmax/sin(theta_obs);
    end
end 

hf = h_obs;
Vf = Vclimb;
deltah = hf - hi;
deltaV = Vf - Vi;
dV2g = (deltaV^2)/(2*g0);
avgV = mean([Vf, Vi]);

% Calculating weight fraction
u = (CD/CL)*(beta/alpha)*(WTO/T_SL);

Wf_Wi = exp(-(TSFC/avgV)*((deltah + dV2g)/(1 - u)));

end
