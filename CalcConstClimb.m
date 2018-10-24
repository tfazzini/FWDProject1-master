function const_climb = CalcConstClimb(engine,burner,K1,K2,WS,CD0,alt_climb,climb_rate,V_climb,B_climb,T0)

if engine == 'turbojet'
    a_climb = T_lap_jet(burner,V_climb,alt_climb,T0);
elseif engine == 'turbofan'
    a_climb = T_lap_lowfan(burner,V_climb,alt_climb,T0);
end

climb_rate = climb_rate/60; %ft/sec

[~,~,~,rho_climb] = atmosphericModel(V_climb,alt_climb,T0);

q = 1/2*rho_climb*V_climb^2;

const_climb = B_climb/a_climb*(K1*B_climb/q*WS+K2+CD0/(B_climb/q*WS)+1/V_climb*climb_rate);