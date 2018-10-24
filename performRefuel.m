function [Wf, hf, Vf, Treq, Sreq, alpha] =...
    performRefuel(S, WTO, Wi, power, Vf, hf, time)

s = Vf*time;

% Perform cruise to refuel
[Wf, hf, Vf, Treq, Sreq, alpha] =...
    performCruise(S, WTO, Wi, power, Vf, hf, s);

end