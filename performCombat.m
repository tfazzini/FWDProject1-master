function [Wf, hf, Vf, Treq, Sreq, alpha] =...
    performCombat(S, WTO, Wi, power, hf, Vf, time, input)

if strcmp(hf,'BCA') == 1 || strcmp(Vf,'BCM') == 1
    [hf, Vf,~,~] = calcBCAandBCM(S, WTO, Wi);
end

% Input parameters
n_sus = input.combat.sustain_g;
n_inst = input.combat.instant_g;
dashM = input.combat.dash;
dashTime = input.combat.dashTime;

[Treq, Sreq, alpha] = deal(zeros(4,1));

% Break up into segments
    % Perform sustained turn
    turnOneTime = time/2;
    [Wi,~,~,Treq_tmp,Sreq_tmp,alpha_tmp] =...
        performTurn(S, WTO, Wi, Vf, hf, power, n_sus, turnOneTime);
    Treq(1) = Treq_tmp; 
    Sreq(1) = Sreq_tmp; 
    alpha(1) = alpha_tmp;
    % Perform instantaneous turn
    [Wi,~,~,Treq_tmp,Sreq_tmp,alpha_tmp, turnTime] =...
        performInstantaneousTurn(S, WTO, Wi, Vf, hf, power, n_inst);   
    Treq(2) = Treq_tmp;
    Sreq(2) = Sreq_tmp; 
    alpha(2) = alpha_tmp;
    if turnOneTime + turnTime < time
        % Perform sustained turn
        turnTwoTime = time - turnOneTime - turnTime - dashTime;
        [Wi,~,~,Treq_tmp,Sreq_tmp,alpha_tmp] =...
            performTurn(S, WTO, Wi, Vf, hf, power, n_sus, turnTwoTime);    
        Treq(3) = Treq_tmp;
        Sreq(3) = Sreq_tmp; 
        alpha(3) = alpha_tmp;  
    end
    % Perform escape dash
    [Wf,~,~,Treq_tmp,Sreq_tmp,alpha_tmp] =...
        performDash(S, WTO, Wi, power, hf, dashM, dashTime);
    Treq(4) = Treq_tmp;
    Sreq(4) = Sreq_tmp; 
    alpha(4) = alpha_tmp;

[Treq, index] = max(Treq);
Sreq = max(Sreq);
alpha = alpha(index);

end