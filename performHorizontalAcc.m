function [Wf, hf, Vf, Treq, Sreq, alpha] =...
    performHorizontalAcc(T_SL, S, WTO, Wi, Vi, power, hf, Vf)

BC = false;
if strcmp(Vf,'BCM')
    [~, Vf,~,~] = calcBCAandBCM(S, WTO, Wi);
    BC = true;
end

Wstart = Wi;

% Required computed parameters
val = getStdValues();
g0 = val.g0;

% Breaking up into segments based on 1000 ft energy height change
separation = 1000;
dV2g = (Vf^2 - Vi^2)/(2*g0);
ze = dV2g;
if abs(ze) > separation
    V_vec = Vi;
    if Vi < Vf
        while V_vec(end) <= Vf
            Vnext = sqrt(Vi^2 + separation*2*g0);
            V_vec = [V_vec; Vnext];
            Vi = Vnext;
        end 
        if V_vec(end) > Vf
            V_vec = V_vec(1:end-1);
            if V_vec(end) < Vf
                V_vec(end+1) = Vf;
            end 
        end 
    else
        while V_vec(end) >= Vf  
            Vnext = sqrt(Vi^2 - separation*2*g0);
            V_vec = [V_vec; Vnext];
            Vi = Vnext;
        end             
        if V_vec(end) < Vf
            V_vec = V_vec(1:end-1);
            if V_vec(end) > Vf
                V_vec(end+1) = Vf;
            end 
        end 
    end 
    n = length(V_vec);
    % Loop through mission segments
    [Wf_Wi, Treq, alpha, Sreq] = deal(zeros(n-1,1));
    for i = 1:n-1
        [Wf_Wi_tmp,Treq_tmp,Sreq_tmp,alpha_tmp] =...
            performHorizontalAccSegment(T_SL, S, WTO, Wi, V_vec(i), hf,...
            power, V_vec(i+1), BC);
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
    [Wf_Wi,Treq,Sreq,alpha] =...
        performHorizontalAccSegment(T_SL, S, WTO, Wi, Vi, hf, power, Vf,...
        BC);
    Wf = Wf_Wi * Wi;
        
end 

end