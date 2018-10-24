function const_cruise = CalcConstCruise(engine,burner,K1,K2,WS,CD0,alt_cruise,V_cruise,B_cruise,T0)
    
if engine == 'turbojet'
    a_cruise = T_lap_jet(burner,V_cruise,alt_cruise,T0);
elseif engine == 'turbofan'
    a_cruise = T_lap_lowfan(burner,V_cruise,alt_cruise,T0);
end

[~,~,~,rho_cruise] = atmosphericModel(V_cruise,alt_cruise,T0);

q = 1/2*rho_cruise*V_cruise^2;

const_cruise = B_cruise/a_cruise*(K1*B_cruise/q*WS+K2+CD0/((B_cruise/q)*WS));