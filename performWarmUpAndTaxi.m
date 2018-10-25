function [Wf_Wi, hf, Vf, Treq, Sreq, alpha, fuelBurnedPerMin] =...
    performWarmUpAndTaxi(T_SL, WTO, Wi, Vi, hi, power, warmupTime,...
    groundTime)

% Warm-up
TSFC = calcTSFC(power, Vi, hi);
alpha = calcThrustLapse(power, Vi, hi);
beta = Wi/WTO;

Wf_Wi_warmup = 1 - TSFC*(alpha/beta)*(T_SL/WTO)*warmupTime;

% Taxi
val = getStdValues();
Wf_Wi_taxi = val.taxi;

Wf_Wi = Wf_Wi_taxi * Wf_Wi_warmup;
Wf = Wi*Wf_Wi;
fuelBurnedPerMin = ((Wi - Wf)/groundTime)*60;

hf = hi;
Vf = Vi;
Treq = 0;
Sreq = 0;

end