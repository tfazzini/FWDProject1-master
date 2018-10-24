function land = CalcLanding(thrustRev,engine,burner,alt_land,s_Roll,s_TotLand,CD0,K1,K2,TW,WS,B_land,CDR,mu_land,CLmax,k_TD,k_obs,g0,t_FR,h_obs,T0)

[~,~,~,rho_land] = atmosphericModel(0,alt_land,T0);

V_app = k_obs*sqrt((2*B_land*WS)/(rho_land*CLmax));

if thrustRev == 0
    a_land = 0;
else
    a_land = -thrustRev/100;
end

    Spiral_land = (CD0+K1*CLmax+K2*CLmax^2+CDR-mu_land*CLmax);

%a_land is negative to account for thrust reversers
s_B = B_land*WS/(rho_land*g0*(Spiral_land))*log(1+Spiral_land/(((-a_land/B_land)*TW+mu_land)*CLmax/(k_TD^2)));

s_A = 2*B_land*WS/(rho_land*g0*(CD0+K1*CLmax+K2*CLmax^2+CDR))*((k_obs^2-k_TD^2)/(k_obs^2+k_TD^2))+...
    CLmax*2*h_obs/((CD0+K1*CLmax+K2*CLmax^2+CDR)*(k_obs^2+k_TD^2));

s_FR = t_FR*k_TD*sqrt((2*B_land*WS)/(rho_land*CLmax));

s_total = s_B + s_A + s_FR;

if a_land == 0
    if s_Roll > 0 && isnan(s_TotLand) == 1
        land = solve(s_B + s_FR == s_Roll, WS);
    elseif s_Roll > 0 && isnan(s_TotLand) == 0
        land = solve(s_B + s_FR == s_Roll, s_total == s_TotLand, WS);
    else
        land = sove(s_total == s_TotLand, WS);
    end
else
    if s_Roll > 0 && isnan(s_TotLand) == 1
        land = solve(s_B + s_FR == s_Roll, TW);
    elseif s_Roll > 0 && isnan(s_TotLand) == 0
        land = solve(s_B + s_FR == s_Roll, s_total == s_TotLand, TW);
    else
        land = sove(s_total == s_TotLand, TW);
    end
end

