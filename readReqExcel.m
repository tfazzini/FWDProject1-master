function reqs = readReqExcel(filename)

fullReqs = readtable(filename);

kts_to_fts = 1.68781; %fts/kts

reqs.general.size = height(fullReqs);

for i = 1:height(fullReqs)
    reqCell = fullReqs{i,1};
    reqString = reqCell{1};
    
    caseCell = fullReqs{i,2};
    caseString = caseCell{1};
    
    reqs.general.req{i} = reqString;
    reqs.general.case{i} = caseString;
    
    engine = fullReqs{i,3}; %String
    
    %Convert burner into logical
    burner = fullReqs{i,4}; %0 or 1
    if strcmp(burner,'no') == 1
        burner = false;
    elseif strcmp(burner, 'yes') == 1
        burner = true;
    end
    
    alt = fullReqs{i,5}; %ft
    
    vel = fullReqs{i,6}*kts_to_fts; %ft/sec
    
    %Convert Mach to ft/sec if velocity given in Mach
    vel_Mach = fullReqs{i,7}; %Mach
    if vel_Mach > 0
        vel = Machtofts(alt,vel_Mach);
    end
    
    T0_SL = fullReqs{i,8}; %Fahrenheit
    B = fullReqs{i,9}; %Estimated
    RoCMax = fullReqs{i,10}; %ft/min
    n = fullReqs{i,11}; %g's
    rad_turn = fullReqs{i,12}; %ft
    if n == 0
        n = NaN;
    elseif rad_turn == 0
        rad_turn = NaN;
    end
    
    V_init = fullReqs{i,13}*kts_to_fts; %ft/sec
    
    %Convert Mach to ft/sec
    V_initMach = fullReqs{i,14};    
    if V_initMach > 0
        V_init = Machtofts(alt,V_initMach);
    end
    V_final = fullReqs{i,15}*kts_to_fts; %ft/sec
    
    %Convert Mach to ft/sec
    V_finalMach = fullReqs{i,16};
    if V_finalMach > 0
        V_final = Machtofts(alt,V_finalMach);
    end
    
    t_accel = fullReqs{i,17}; %sec
    k_TO = fullReqs{i,18}; %TO velocity safety factor
    s_Ground = fullReqs{i,19}; %TO ground rollft
    s_TOTot = fullReqs{i,20}; %TO total distance ft
    if s_Ground == 0
        s_Ground = NaN;
    elseif s_TOTot == 0
        s_TOTot = NaN;
    end
    
    mu_runway = fullReqs{i,21}; %Runway friction coefficient
    t_rotate = fullReqs{i,22}; %sec
    theta_climb = fullReqs{i,23}; %deg
    if theta_climb == 0
        theta_climb = NaN;
    end
    h_obs = fullReqs{i,24}; %ft
    s_LandRoll = fullReqs{i,25}; %ft
    s_LandTot = fullReqs{i,26}; %ft
    if s_LandRoll == 0
        s_LandRoll = NaN;
    elseif s_LandTot == 0
        s_LandTot = NaN;
    end
    
    k_TD = fullReqs{i,27}; %TD velocity safety factor
    k_obs = fullReqs{i,28}; %Obstacle velocity safety factor
    t_FR = fullReqs{i,29}; %sec
    thrustRev = fullReqs{i,30}; %Thrust Reversed
    
    switch reqString
        case 'stall'
            if strcmp(caseString,'required') == 1
                reqs.stall.required.T0 = T0_SL;
                reqs.stall.required.engine = engine{1};
                reqs.stall.required.burner = burner;
                reqs.stall.required.alt = alt; %ft
                reqs.stall.required.vel = vel; %ft/s
            elseif strcmp(caseString,'desired') == 1
                reqs.stall.desired.T0 = T0_SL;
                reqs.stall.desired.engine = engine{1};
                reqs.stall.desired.burner = burner;
                reqs.stall.desired.alt = alt; %ft
                reqs.stall.desired.vel = vel; %ft/s
            end
        case 'takeoff'
            if strcmp(caseString,'required') == 1
                reqs.takeoff.required.T0 = T0_SL;
                reqs.takeoff.required.engine = engine{1};
                reqs.takeoff.required.burner = burner;
                reqs.takeoff.required.B = B;
                reqs.takeoff.required.alt = alt;
                reqs.takeoff.required.mu_TO = mu_runway;
                reqs.takeoff.required.t_accel = t_accel;
                reqs.takeoff.required.t_rotate = t_rotate;
                reqs.takeoff.required.angle_climb = theta_climb;
                reqs.takeoff.required.RoC = RoCMax;
                reqs.takeoff.required.h_obs = h_obs;
                reqs.takeoff.required.sTO = s_TOTot;
                reqs.takeoff.required.sRoll = s_Ground;
                reqs.takeoff.required.k_TO = k_TO;
            elseif strcmp(caseString,'desired') == 1
                reqs.takeoff.desired.T0 = T0_SL;
                reqs.takeoff.desired.engine = engine{1};
                reqs.takeoff.desired.burner = burner;
                reqs.takeoff.desired.B = B;
                reqs.takeoff.desired.alt = alt;
                reqs.takeoff.desired.mu_TO = mu_runway;
                reqs.takeoff.desired.t_accel = t_accel;
                reqs.takeoff.desired.t_rotate = t_rotate;
                reqs.takeoff.desired.angle_climb = theta_climb;
                reqs.takeoff.desired.RoC = RoCMax;
                reqs.takeoff.desired.h_obs = h_obs;
                reqs.takeoff.desired.sTO = s_TOTot;
                reqs.takeoff.desired.sRoll = s_Ground;
                reqs.takeoff.desired.k_TO = k_TO;
            end
        case 'horizontal_acc'
            if strcmp(caseString,'required') == 1
                reqs.accel.required.T0 = T0_SL;
                reqs.accel.required.engine = engine{1};
                reqs.accel.required.burner = burner;
                reqs.accel.required.B = B;
                reqs.accel.required.alt = alt;
                reqs.accel.required.V_final = V_final;
                reqs.accel.required.V_init = V_init;
                reqs.accel.required.t_accel = t_accel;
            elseif strcmp(caseString,'desired') == 1
                reqs.accel.desired.T0 = T0_SL;
                reqs.accel.desired.engine = engine{1};
                reqs.accel.desired.burner = burner;
                reqs.accel.desired.B = B;
                reqs.accel.desired.alt = alt;
                reqs.accel.desired.V_final = V_final;
                reqs.accel.desired.V_init = V_init;
                reqs.accel.desired.t_accel = t_accel;
            end
        case 'climb'
            if strcmp(caseString,'required') == 1
                reqs.climb.required.T0 = T0_SL;
                reqs.climb.required.engine = engine{1};
                reqs.climb.required.burner = burner;
                reqs.climb.required.B = B;
                reqs.climb.required.alt = alt;
                reqs.climb.required.vel = vel;
                reqs.climb.required.RoC = RoCMax;
            elseif strcmp(caseString,'desired') == 1
                reqs.climb.desired.T0 = T0_SL;
                reqs.climb.desired.engine = engine{1};
                reqs.climb.desired.burner = burner;
                reqs.climb.desired.B = B;
                reqs.climb.desired.alt = alt;
                reqs.climb.desired.vel = vel;
                reqs.climb.desired.RoC = RoCMax;
            end
        case 'cruise'
            if strcmp(caseString,'required') == 1
                reqs.cruise.required.T0 = T0_SL;
                reqs.cruise.required.engine = engine{1};
                reqs.cruise.required.burner = burner;
                reqs.cruise.required.B = B;
                reqs.cruise.required.alt = alt;
                reqs.cruise.required.vel = vel;
            elseif strcmp(caseString,'desired') == 1
                reqs.cruise.desired.T0 = T0_SL;
                reqs.cruise.desired.engine = engine{1};
                reqs.cruise.desired.burner = burner;
                reqs.cruise.desired.B = B;
                reqs.cruise.desired.alt = alt;
                reqs.cruise.desired.vel = vel;
            end
        case 'dash'
            if strcmp(caseString,'required') == 1
                reqs.dash.required.T0 = T0_SL;
                reqs.dash.required.engine = engine{1};
                reqs.dash.required.burner = burner;
                reqs.dash.required.B = B;
                reqs.dash.required.alt = alt;
                reqs.dash.required.vel = vel;
            elseif strcmp(caseString,'desired') == 1
                reqs.dash.desired.T0 = T0_SL;
                reqs.dash.desired.engine = engine{1};
                reqs.dash.desired.burner = burner;
                reqs.dash.desired.B = B;
                reqs.dash.desired.alt = alt;
                reqs.dash.desired.vel = vel;
            end
        case 'turn'
            if strcmp(caseString,'required') == 1
                reqs.turn.required.T0 = T0_SL;
                reqs.turn.required.engine = engine{1};
                reqs.turn.required.burner = burner;
                reqs.turn.required.B = B;
                reqs.turn.required.alt = alt;
                reqs.turn.required.vel = vel;
                reqs.turn.required.n = n;
                reqs.turn.required.rad_turn = rad_turn;
            elseif strcmp(caseString,'desired') == 1
                reqs.turn.desired.T0 = T0_SL;
                reqs.turn.desired.engine = engine{1};
                reqs.turn.desired.burner = burner;
                reqs.turn.desired.B = B;
                reqs.turn.desired.alt = alt;
                reqs.turn.desired.vel = vel;
                reqs.turn.desired.n = n;
                reqs.turn.desired.rad_turn = rad_turn;
            end
        case 'land'
            if strcmp(caseString,'required') == 1
                reqs.land.required.T0 = T0_SL;
                reqs.land.required.engine = engine{1};
                reqs.land.required.burner = burner;
                reqs.land.required.B = B;
                reqs.land.required.alt = alt;
                reqs.land.required.mu_Land = mu_runway;
                reqs.land.required.s_Roll = s_LandRoll;
                reqs.land.required.s_LandTot = s_LandTot;
                reqs.land.required.k_TD = k_TD;
                reqs.land.required.k_obs = k_obs;
                reqs.land.required.h_obs = h_obs;
                reqs.land.required.t_FR = t_FR;
                reqs.land.required.thrustRev = thrustRev;
            elseif strcmp(caseString,'desired') == 1
                reqs.land.desired.T0 = T0_SL;
                reqs.land.desired.engine = engine{1};
                reqs.land.desired.burner = burner;
                reqs.land.desired.B = B;
                reqs.land.desired.alt = alt;
                reqs.land.desired.mu_Land = mu_runway;
                reqs.land.desired.s_Roll = s_LandRoll;
                reqs.land.desired.s_LandTot = s_LandTot;
                reqs.land.desired.k_TD = k_TD;
                reqs.land.desired.k_obs = k_obs;
                reqs.land.desired.h_obs = h_obs;
                reqs.land.desired.t_FR = t_FR;
                reqs.land.desired.thrustRev = thrustRev;
            end
        case 'ceiling'
            if strcmp(caseString,'required') == 1
                reqs.ceil.required.T0 = T0_SL;
                reqs.ceil.required.engine = engine{1};
                reqs.ceil.required.burner = burner;
                reqs.ceil.required.B = B;
                reqs.ceil.required.alt = alt;
                reqs.ceil.required.vel = vel;
                reqs.ceil.required.RoC = RoCMax;
            elseif strcmp(caseString,'desired') == 1
                reqs.ceil.desired.T0 = T0_SL;
                reqs.ceil.desired.engine = engine{1};
                reqs.ceil.desired.burner = burner;
                reqs.ceil.desired.B = B;
                reqs.ceil.desired.alt = alt;
                reqs.ceil.desired.vel = vel;
                reqs.ceil.desired.RoC = RoCMax;
            end
    end
end