function [TO,TO_Roll] = CalcTO(engine,burner,alt_TO,sTO,sRoll,CD0,K1,K2,TW,WS,B_TO,CDR,mu_TO,CLmax,k_TO,g0,t_accelTO,t_rotate,angle_climb,RoC_TO,h_obs,T0)

%Get density
[~,~,~,rho_TO] = atmosphericModel(0,alt_TO,T0);

%Calculate stall velocitiy
V_Stall = sqrt(2*WS/(rho_TO*CLmax));

%Apply safety factor to get TO velocity
V_TO = k_TO*V_Stall;

%Get alpha values from engine models
if engine == 'turbojet'
    a_TO = T_lap_jet(burner,V_TO,alt_TO,T0);
elseif engine == 'turbofan'
    a_TO = T_lap_lowfan(burner,V_TO,alt_TO,T0);
end

%If given a rate of climb, calculate climb angle
if isnan(angle_climb) == 1
    angle_climb = 180/pi*asin(1/V_TO*RoC_TO/60);    
end 

%Calculate Dynamic Pressure
q = 1/2*rho_TO*V_TO^2;

%Define value to hold drag terms
    Spiral_TO = (CD0+K1*CLmax+K2*CLmax^2+CDR-mu_TO*CLmax);

if t_accelTO > 0
    %Calculate TO acceleration
    accel_TO = 1/g0*((V_TO)/t_accelTO);
    %Calculate T/W based off of Mattingly Equation
    TO_Roll = B_TO/a_TO*(Spiral_TO*q/B_TO*(1/WS)+mu_TO+accel_TO);
else 
    TO_Roll = 0;
end

%TO Roll Distance
s_G = -B_TO*WS/(rho_TO*g0*Spiral_TO)*log(1-Spiral_TO/(((a_TO/B_TO)*TW-mu_TO)*(CLmax/(k_TO^2))));

%TO Rotation Distance
s_R = t_rotate*k_TO*sqrt((2*B_TO)/(rho_TO*CLmax)*WS);

%TO Transition Distance
s_TR = (k_TO^2*sin(angle_climb*pi/180)*2*B_TO*WS)/(g0*(0.8*k_TO^2-1)*rho_TO*CLmax);

%Height at the end of Transition
h_trans = (k_TO^2*(1-cos(angle_climb*pi/180))*2*B_TO*WS)/(g0*(0.8*k_TO^2-1)*rho_TO*CLmax);

%Radius of climb
Rc = s_TR/sin(angle_climb*pi/180);

%Distance to Clear Obstacle
s_CL = (h_obs-h_trans)/tan(angle_climb*pi/180);

%Angle to Clear obstacle
theta_obs = acos(1-h_obs/Rc);

%Distance to clear obstacle if clear during transition
s_obs = V_TO^2*sin(theta_obs)/(g0*(0.8*k_TO^2-1));

%Calculate total TO distance based on clearing the obstacle
%If s_CL is negative, that means the obstacle was cleared in Transition
if double(subs(s_CL,WS,1)) > 0
    s_TO = s_G + s_R + s_TR + s_CL;
elseif double(subs(s_CL,WS,1)) <= 0
    s_TO = s_G + s_R + s_obs;
end

%Get TO in terms of T/W depending on the availiable inputs
if sRoll > 0 && isnan(sTO) == 1
    TO = solve(s_G + s_TR == sRoll,TW);
elseif sTO > 0 && isnan(sRoll) == 1
    TO = solve(s_TO == sTO, TW); 
elseif sTO > 0 && sRoll > 0
    TO = solve(s_TO == sTO,s_G+s_TR == sRoll,TW);
end

