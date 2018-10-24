function [Wf, hf, Vf, Treq, Sreq, alpha, startFuel, fuelBurnedPerMin,...
    runUpFuel, sTO] = performTakeoff(T_SL, WTO, S, hi, Vi, power, input)

% Takeoff input
h_obs = input.takeoff.h_obs;
warmupTime = input.takeoff.warmupTime;
groundTime = input.takeoff.groundTime;
rotateTime = input.takeoff.rotateTime;

% Calculate the different segments 
[Treq, Sreq, alpha] = deal([]);

% Start
val = getStdValues();
Wf_Wi = val.start;
Wi = Wf_Wi*WTO;
startFuel = WTO - Wi;

% Warmup and taxi
[Wf_Wi_tmp,~,~,~,~,alpha_tmp,fuelBurnedPerMin] =...
    performWarmUpAndTaxi(T_SL, WTO, Wi, Vi, hi, power, warmupTime,...
    groundTime);
Wf_Wi = [Wf_Wi; Wf_Wi_tmp];
alpha = [alpha; alpha_tmp];
Wi = Wf_Wi_tmp*Wi;

% Takeoff acceleration
[Wf_Wi_tmp,~,Vi,Treq_tmp,Sreq_tmp,alpha_tmp,runUpFuel,sG] =...
    performTakeoffAcceleration(T_SL, S, WTO, Wi, Vi, hi, power, input);
Wf_Wi = [Wf_Wi; Wf_Wi_tmp];
Treq = [Treq; Treq_tmp];
alpha = [alpha; alpha_tmp];
Sreq = [Sreq; Sreq_tmp];
Wi = Wf_Wi_tmp*Wi;

% Takeoff rotation
[Wf_Wi_tmp,hf,Vf,Treq_tmp,Sreq_tmp,alpha_tmp,sTR,theta] =...
    performTakeoffRotation(T_SL, S, WTO, Wi, Vi, hi, power, rotateTime,...
    input);
Wf_Wi = [Wf_Wi; Wf_Wi_tmp];
Treq = [Treq; Treq_tmp];
alpha = [alpha; alpha_tmp];
Sreq = [Sreq; Sreq_tmp];
Wi = Wf_Wi_tmp*Wi;

% Check if there is an obstacle to clear and calculate if so
if h_obs > hf
    % Takeoff clear obstacle
    [Wf_Wi_tmp,hf,Vf,Treq_tmp,Sreq_tmp,alpha_tmp,sCL] =...
    performTakeoffClearObstacle(T_SL, WTO, Wi, Vi, hi, power, theta,...
    input);
    Wf_Wi = [Wf_Wi; Wf_Wi_tmp];
    Treq = [Treq; Treq_tmp];
    Sreq = [Sreq; Sreq_tmp];
    alpha = [alpha; alpha_tmp];

    % Total takeoff distance
    sTO = sG + sTR + sCL;
else 
    % Total takeoff distance
    sTO = sG + sTR;
end

Wf_Wi_final = prod(Wf_Wi);
Wf = Wf_Wi_final * WTO;
[Treq, index] = max(Treq);
Sreq = max(Sreq);
alpha = alpha(index);

end