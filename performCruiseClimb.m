function [Wf, hf, Vf, Treq, Sreq, alpha] =...
    performCruiseClimb(T_SL, S, WTO, Wi, hi, power, Vf, hf)

% Perform climb at constant speed
[Wf, hf, Vf, Treq, Sreq, alpha] =...
    performClimb(T_SL, S, WTO, Wi, Vf, hi, power, hf, Vf);
    
end