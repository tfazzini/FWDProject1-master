function ceil = CalcCeil(engine,burner,K1,K2,WS,CD0,alt_serv,climb_rate_serv,V_serv,B_serv);

if engine == 'turbojet'
    a_serv = T_lap_jet(burner,V_serv,alt_serv,T0);
elseif engine == 'turbofan'
    a_serv = T_lap_lowfan(burner,V_serv,alt_serv,T0);
end

climb_rate_serv = climb_rate_serv/60;

rho_serv = 0.002378*(1-0.0000068756*alt_serv)^4.2561;

q = 1/2*rho_serv*V_serv^2;

ceil = B_serv/a_serv*(K1*B_serv/q*WS+K2+CD0/(B_serv/q*WS)+1/V_serv*climb_rate_serv);