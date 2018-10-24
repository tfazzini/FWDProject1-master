function [alt_BCA, V_BCM, CL, CD] = calcBCAandBCM(S, WTO, Wi)

% Aerodynamic parameters
aero = getAeroData();
Mcrit = aero.Mcrit;
CD0 = aero.CD0;
K1 = aero.K1;
K2 = aero.K2;
[CD0, K1] = adjustAero(Mcrit, CD0, K1);

% Standard parameters
val = getStdValues();
Pstd = val.Pstd;
Tstd = val.Tstd_R;
gamma = val.gam;
R = val.R;
k = val.k;

% Calculating best cruise altitude
beta = Wi/WTO;
delta = (2*beta)/(gamma*Pstd*(Mcrit^2))*(1/sqrt(CD0/K1))*(WTO/S);

alt = calcAltFromDelta(delta);
alt_BCA = alt;

if alt <= 36089
    T = Tstd*(1+k*alt);
elseif alt > 36089 && alt <= 65617
    T = Tstd*(1+k*36089);
elseif alt > 65617 && alt <= 104987
    T = Tstd*(0.682457+alt/945374);
elseif alt > 104987 && alt <= 154199 
    T = Tstd*(0.482561+alt/337634);
else 
    x = 5;
end

a = sqrt(gamma*T*R);

CL = sqrt(CD0/K1);
CD = 2*CD0 + K2*CL;

V_BCM = Mcrit*a; % ft/s

end

