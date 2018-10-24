function [Vstall] = calcVstall(S, W, V, alt)

% Aerodynamic parameters
aero = getAeroData();
CLmax = aero.CLmax;

[~,~,~,rho,~] = atmModel(V, alt);

% Assume L = W
Vstall = sqrt((2*W)/(CLmax*rho*S));

end