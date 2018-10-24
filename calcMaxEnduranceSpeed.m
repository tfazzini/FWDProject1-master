function [V] = calcMaxEnduranceSpeed(alt, aero)

Mcrit = aero.Mcrit;
val = getStdValues();
R = val.R;
gam = val.gam;

[~, ~, ~, ~, T, ~] = atmModel(0, alt);

a = sqrt(gam*R*T);

V = Mcrit*a;

end 