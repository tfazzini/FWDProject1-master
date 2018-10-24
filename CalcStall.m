function stallWS = CalcStall(alt_stall,CLmax,Vstall,T0)

% L = 1/2*rho*V^2*S*CL
% Vstall = sqrt(2/(rho*CLmax)*W/S)

[~,~,~,rho_stall] = atmosphericModel(Vstall,alt_stall,T0);

stallWS = 1/2*rho_stall*Vstall^2*CLmax;