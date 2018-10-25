function [Wf, hf, Vf, Treq, Sreq, alpha] =...
    performCruise(S, WTO, Wi, power, Vf, hf, s)

Wstart = Wi;
% 
% CL = W/(1/2*rho*V^2*S);



BC = false;
if strcmp(hf,'BCA') == 1 || strcmp(Vf,'BCM') == 1
    [hf, Vf,~,~] = calcBCAandBCM(S, WTO, Wi);
    BC = true;
end

if strcmp(Vf,'max_endurance')
    Vf = calcMaxEnduranceSpeed(hf);
end 

% Breaking up into segments based on 100000 ft distance traveled
separation = 1000;
if s > separation
     s_vec = (0:separation:s);
    if s ~= s_vec(end)
        s_vec = [s_vec, s];
    end
    n = length(s_vec);
    % Loop through mission segments
    [Wf_Wi, Treq, Sreq, alpha] = deal(zeros(n-1,1));
    for i = 1:n-1
        dist = s_vec(i+1) - s_vec(i);
        [Wf_Wi_tmp, Treq_tmp, Sreq_tmp, alpha_tmp] =...
            performCruiseSegment(S, WTO, Wi, power, Vf, hf, dist, BC);
        Wf_Wi(i) = Wf_Wi_tmp;
        Treq(i) = Treq_tmp;
        Sreq(i) = Sreq_tmp;
        alpha(i) = alpha_tmp;
        Wi = Wf_Wi_tmp * Wi;
    end
    Wf_Wi = prod(Wf_Wi);
    Wf = Wf_Wi * Wstart;
    [Treq, index] = max(Treq);
    Sreq = max(Sreq);
    alpha = alpha(index);
else
    [Wf_Wi, Treq, Sreq, alpha] =...
            performCruiseSegment(S, WTO, Wi, power, Vf, hf, s, BC);
    Wf = Wf_Wi * Wstart;
        
end 

end