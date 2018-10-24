function [Mach, d_0, theta_0, rho, T, M0, sigma] = atmModel(V, alt)

val = getStdValues();
gam = val.gam;
R = val.R; % ftlb/slugR
Pstd = val.Pstd; % psf
Tstd = val.Tstd_R; % R
k = val.k; % 1/ft
astd = val.astd; % fps

aero = getAeroData();
T0 = aero.T0;

if alt <= 36089
    T = Tstd*(1+k*alt);
    P = Pstd*(1+k*alt)^5.2561;
    sigma = (1-(alt/145442))^4.2561;
elseif alt > 36089 && alt <= 65617
    T = Tstd*(1+k*36089);
    P = Pstd*0.223361*exp(-(alt-36089)/20806);
    sigma = 0.297076*exp(-(alt - 36089)/20806);
elseif alt > 65617 && alt <= 104987
    T = Tstd*(0.682457+alt/945374);
    P = Pstd*(0.988626+alt/652600)^-34.16320;
    sigma = (0.978261+(alt/659515))^35.16320;
elseif alt > 104987 && alt <= 154199 
    T = Tstd*(0.482561+alt/337634);
    P = Pstd*(0.898309+alt/577922)^12.20114;
    sigma = (0.857003+(alt/190115))^13.20114;

end

rho = 1.233*(1-0.0000068758*alt)^(5.2561)/(T+((T0+459.67)-Tstd));

Mach_gen = sqrt(gam*R*T);

Mach = V/Mach_gen;

d_0 = P/Pstd * (1 + (((gam - 1)/2) *Mach^2))^(gam/(gam-1));

theta_0 = (T/Tstd) * (1 + (((gam - 1)/2) *Mach^2));

M0 = V/astd;

end 