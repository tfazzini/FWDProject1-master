function ceil = CalcCeil(engine,burner,K1,K2,WS,CD0,alt_ceil,climb_rate_ceil,V_ceil,B_ceil,T0);

if engine == 'turbojet'
    a_ceil = T_lap_jet(burner,V_ceil,alt_ceil,T0);
elseif engine == 'turbofan'
    a_ceil = T_lap_lowfan(burner,V_ceil,alt_ceil,T0);
end

climb_rate_ceil = climb_rate_ceil/60;

[~,~,~,rho_ceil] = atmosphericModel(V_ceil,alt_ceil,T0);

q = 1/2*rho_ceil*V_ceil^2;

ceil = B_ceil/a_ceil*(K1*B_ceil/q*WS+K2+CD0/(B_ceil/q*WS)+1/V_ceil*climb_rate_ceil);