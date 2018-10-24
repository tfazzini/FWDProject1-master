function [val] = getStdValues()

val.g0 = 32.1740; % ft/s^2
val.rho_sea_level = 0.002378; % slugs/ft^3
val.gam = 1.4;
val.R = 1716; % fl-lb/slug-R
val.Pstd = 2116.2; % psf
val.Tstd_R = 518.67; % R
val.Tstd_F = 59; % degrees F
val.k = -0.0000068756; % 1/ft
val.astd = 1116.4; % fps
val.kts_to_fts = 1.68781; %fts/kts

% Fuel Fractions
val.start = 0.995;
val.taxi = 0.99;
val.land = 0.995;

end
