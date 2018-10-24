function TO_Excess = CalcExcessTO(engine,burner,WS,B_TO,alt_TO,roll_TO,k_TO,g0,CLmax,T0)

[~,~,~,rho_TO] = atmosphericModel(0,alt_TO,T0);

V_TO = k_TO*sqrt((2*B_TO*WS/(rho_TO*CLmax)));

if engine == 'turbojet'
    a_TO = T_lap_jet(burner,V_TO,alt_TO,T0);
elseif engine == 'turbofan'
    a_TO = T_lap_lowfan(burner,V_TO,alt_TO,T0);
end

TO_Excess = B_TO^2./a_TO*k_TO^2./(roll_TO.*rho_TO*g0.*CLmax).*WS;