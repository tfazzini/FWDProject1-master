function const_turn = CalcConstTurn(engine,burner,K1,K2,WS,CD0,g0,radius_turn,alt_turn,V_turn,n_turn,B_turn,T0)

if engine == 'turbojet'
    a_turn = T_lap_jet(burner,V_turn,alt_turn,T0);
elseif engine == 'turbofan'
    a_turn = T_lap_lowfan(burner,V_turn,alt_turn,T0);
end

if n_turn == 0
    n_turn = sqrt(1+V_turn^2/(g0*radius_turn));
end

[~,~,~,rho_turn] = atmosphericModel(V_turn,alt_turn,T0);

q = 1/2*rho_turn*V_turn^2;

const_turn = B_turn/a_turn*(K1*n_turn^2*B_turn/q*WS+K2*n_turn+CD0/(B_turn/q*WS));