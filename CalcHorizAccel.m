function horiz_accel = CalcHorizAccel(engine,burner,K1,K2,WS,CD0,g0,V_final,V_init,t_accel,alt_accel,B_accel,T0)

V_accel = V_final;

if engine == 'turbojet'
    a_accel = T_lap_jet(burner,V_accel,alt_accel,T0);
elseif engine == 'turbofan'
    a_accel = T_lap_lowfan(burner,V_accel,alt_accel,T0);
end

accel = 1/g0*((V_final-V_init)/t_accel);

[~,~,~,rho_accel] = atmosphericModel(V_accel,alt_accel,T0);

q = 1/2*rho_accel*V_accel^2;

horiz_accel = B_accel/a_accel*(K1*B_accel/q*WS+K2+CD0/(B_accel/q*WS)+accel);