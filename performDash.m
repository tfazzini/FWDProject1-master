function [Wf, hf, Vf, Treq, Sreq, alpha] =...
    performDash(S, WTO, Wi, power, hf, Mach, time)

% Calculate what final velocity would be at the current altitude
val = getStdValues();
gam = val.gam;
R = val.R; % ftlb/slugR
[~,~,~,~,T,~] = atmModel(0, hf);

a = sqrt(gam*R*T);
Vf = Mach*a;
s = Vf*time;

% Perform climb at constant speed
[Wf, hf, Vf, Treq, Sreq, alpha] =...
    performCruise(S, WTO, Wi, power, Vf, hf, s);

end