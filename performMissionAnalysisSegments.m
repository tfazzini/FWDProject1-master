function [data, WFr] = performMissionAnalysisSegments(T_SL, S, WTO,...
    input)

alt_TO = input.takeoff.alt;
alt_L = input.land.alt;
    
% Mission breakdown
phase = input.phase;
N = length(phase);

% Creating structure with all desired results of mission analysis loop
data = struct('h',zeros(N,1),...
    'V',zeros(N,1),...
    'W',zeros(N,1),...
    'Treq',zeros(N,1),....
    'Sreq',zeros(N,1),...
    'alpha',zeros(N,1),...
    'startFuel',0,...
    'fuelBurnedPerMin',0,...
    'runUpFuel',0,...
    'sTO',0,...
    'sB',0);

% Looping through mission segments
for i = 1:N
    % Reading input for each segment
    if iscell(input.h)
        hf = input.h{i};
        [~,status] = str2num(hf);
        if status == 1
            hf = str2double(hf);
            if i > i && isnan(hf)
                hf = data.h(i-1);
            end
        end
    else
        hf = input.h(i);
            if i > 1 && isnan(hf)
                hf = data.h(i-1);
            end        
    end
    if iscell(input.V)
        Vf = input.V{i};
        [~,status] = str2num(Vf);
        if status == 1
            Vf = str2double(Vf);
            if i > 1 && isnan(Vf)
                Vf = data.V(i-1);
            end
        end
    else 
        Vf = input.V(i);
            if i > 1 && isnan(Vf)
                Vf = data.V(i-1);
            end        
    end 
    if iscell(input.s)
        s = input.s{i};
        [~,status] = str2num(s);
        if status == 1
            s = str2double(s);
        end
    else
        s = input.s(i);
    end
    if iscell(input.t)
        time = input.t{i};
        [~,status] = str2num(time);
        if status == 1
            time = str2double(time);
        end
    else
        time = input.t(i);
    end
    power = input.power{i};
    
    % Performing mission analysis for each segment depending on given
    % flight condition
    if strcmp(char(phase(i)),'takeoff') == 1
        hi = alt_TO;
        Vi = 0;  
        Wi = WTO;
        [Wf, hf, Vf, Treq, Sreq, alpha, startFuel, fuelBurnedPerMin,...
            runUpFuel, sTO] = performTakeoff(T_SL, WTO, S, hi, Vi,...
            power, input);
        data.startFuel = startFuel;
        data.fuelBurnedPerMin = fuelBurnedPerMin;
        data.runUpFuel = runUpFuel;
        data.sTO = sTO;
    else
    if strcmp(char(phase(i)),'horizontal_acc') == 1
        Wi = data.W(i-1); 
        Vi = data.V(i-1); 
        power = input.power{i}; 
        [Wf, hf, Vf, Treq, Sreq, alpha] =...
            performHorizontalAcc(T_SL, S, WTO, Wi, Vi, power, hf, Vf);
    else
    if strcmp(char(phase(i)),'climb') == 1
        Wi = data.W(i-1);
        hi = data.h(i-1);
        Vi = data.V(i-1); 
        [Wf, hf, Vf, Treq, Sreq, alpha] =...
            performClimb(T_SL, S, WTO, Wi, Vi, hi, power, hf, Vf);
    else
    if strcmp(char(phase(i)),'descend') == 1
        Wi = data.W(i-1);
        [Wf, hf, Vf, Treq, Sreq, alpha] =...
            performDescend(S, WTO, Wi, power, hf, Vf);
    else    
    if strcmp(char(phase(i)),'cruise_climb') == 1
        Wi = data.W(i-1);
        hi = data.h(i-1);
        [Wf, hf, Vf, Treq, Sreq, alpha] =...
            performCruiseClimb(T_SL, S, WTO, Wi, hi, power, Vf, hf);
    else 
    if strcmp(char(phase(i)),'loiter') == 1
        Wi = data.W(i-1);
        [Wf, hf, Vf, Treq, Sreq, alpha] =...
            performLoiter(S, WTO, Wi, power, hf, Vf, time);
    else
    if strcmp(char(phase(i)),'cruise') == 1
        Wi = data.W(i-1);
        [Wf, hf, Vf, Treq, Sreq, alpha] =...
            performCruise(S, WTO, Wi, power, Vf, hf, s);
    else
    if strcmp(char(phase(i)),'combat') == 1
        Wi = data.W(i-1);
        [Wf, hf, Vf, Treq, Sreq, alpha] =...
            performCombat(S, WTO, Wi, power, hf, Vf, time, input);
    else      
    if strcmp(char(phase(i)),'land') == 1
        Wi = data.W(i-1);
        Vi = data.V(i-1); 
        hf = alt_L;
        [Wf, hf, Vf, Treq, Sreq, alpha, sB] =...
            performLanding(S, WTO, Wi, Vi, power, hf, input);
        data.sB = sB;
    else
    if strcmp(char(phase(i)),'air_refuel') == 1
        Wi = data.W(i-1);
        [Wf, hf, Vf, Treq, Sreq, alpha] =...
            performRefuel(S, WTO, Wi, power, Vf, hf, time);
    else  
       error('Invalid mission segment name.')
    end
    end
    end
    end
    end
    end
    end
    end
    end
    end 
    % Saving segment values to data structure
    data.W(i) = Wf;
    data.h(i) = hf;
    data.V(i) = Vf;
    data.Treq(i) = Treq;
    data.Sreq(i) = Sreq;
    data.alpha(i) = alpha;
end

% Calculate required fuel
WFr = WTO - data.W(end);

end
