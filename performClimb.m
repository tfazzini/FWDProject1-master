function [Wf, hf, Vf, Treq, Sreq, alpha] =...
    performClimb(T_SL, S, WTO, Wi, Vi, hi, power, hf, Vf)

BC = false;
% if strcmp(hf,'BCA') == 1 || strcmp(Vf,'BCM') == 1
%     [hf, Vf,~,~] = calcBCAandBCM(S, WTO, Wi);
%     BC = true;
% end

Wstart = Wi;

% Required computed parameters
val = getStdValues();
g0 = val.g0;

% Breaking up into segments based on 1000 ft height change
separation = 1000;
deltah = hf - hi;
deltaV = Vf - Vi;
dV2g = (Vf^2 - Vi^2)/(2*g0);
ze = deltah + dV2g;
if abs(ze) > separation
    n_true = abs(ze)/separation;
    delh_seg = deltah/n_true;
    h_vec = hi:delh_seg:hf;
    if h_vec(end) > hf
        h_vec = h_vec(1:end-1);
        if h_vec(end) < hf
            h_vec(end+1) = hf;
        end 
    else
        if h_vec(end) < hf
            h_vec(end+1) = hf;
        end         
    end 
    n = length(h_vec);
    if deltaV ~= 0
        V_vec = zeros(n,1);
        V_vec(1) = Vi;
        V_vec(end) = Vf;
        if Vi < Vf
            for i = 2:n-1
                V_vec(i) = sqrt(V_vec(i-1)^2 + (separation-delh_seg)*2*g0);
            end 
        else
            for i = 2:n-1
                V_vec(i) = sqrt(V_vec(i-1)^2 - (separation-delh_seg)*2*g0);
            end 
        end 
    else
        V_vec = repmat(Vi, 1, n);
    end 
    
    % Loop through mission segments
    [Wf_Wi, Treq, Sreq, alpha] = deal(zeros(n-1,1));
    for i = 1:n-1
        [Wf_Wi_tmp,Treq_tmp,Sreq_tmp,alpha_tmp] =...
            performClimbSegment(T_SL, S, WTO, Wi, V_vec(i), h_vec(i),...
            power, h_vec(i+1), V_vec(i+1), BC);
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
        performClimbSegment(T_SL, S, WTO, Wi, Vi, hi, power, hf, Vf, BC);
    Wf = Wf_Wi * Wstart;
        
end 

end