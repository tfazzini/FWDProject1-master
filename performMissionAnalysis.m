function [WTO, T_SL, S, data, message] =...
    performMissionAnalysis(TW, WS, WTO, input)

% Get input constraints
fuelReservePercent = input.land.fuelReservePercent;
fuelReserveSpeed = input.land.fuelReserveSpeed;
fuelReserveHeight = input.land.fuelReserveHeight;
fuelReserveTime = input.land.fuelReserveSpeed;
TO_length = input.takeoff.length;
L_length = input.land.length;
startFuel = input.takeoff.startFuel; 
warmupFuel = input.takeoff.warmupFuel; 
runUpFuel = input.takeoff.runUpFuel; 

% Propulsion parameters
prop = getPropData;
numEng = prop.number;

% Converge on a takeoff weight
tolerance = 1;
delF = tolerance + 1;
while abs(delF) > tolerance
    T_SL = TW * WTO;
    S = WTO/WS;
    
    % Perform segmented mission analysis stepping through all segments
    [data, WFr] = performMissionAnalysisSegments(T_SL, S, WTO, input);    
    
    % Get weight breakdown
    WP = input.WP;
    WC = input.WC;
    WE = calcEmptyWeight(WTO, input);
    WFa = WTO - WP - WC - WE;

    % Check fuel reserve constraints
    if fuelReservePercent > 0
        WFreserves = WFa * 0.1;
        WFr = WFr - WFreserves;
        if fuelReserveTime > 0
            if fuelReserveSpeed == 'max_endurance'
                V = calcMaxEnduranceSpeed(fuelReserveHeight);
            else
                V = fuelReserveSpeed;
            end 
            s = V*fuelReserveTime;
            Wstart = WTO - WFr;
            [Wf,~,~,~,~,~] =...
                performCruise(S, WTO, Wstart, 'normal',...
                V, fuelReserveHeight, s);
            Wburned = Wstart - Wf;
            WFr = WFr - Wburned;
        end
    else
        if fuelReserveTime > 0
            if fuelReserveSpeed == 'max_endurance'
                V = calcMaxEnduranceSpeed(fuelReserveHeight);
            else
                V = fuelReserveSpeed;
            end 
            s = V*fuelReserveTime;
            Wstart = WTO - WFr;
            [Wf,~,~,~,~,~] =...
                performCruise(S, WTO, Wstart, 'normal',...
                V, fuelReserveHeight, s);
            Wburned = Wstart - Wf;
            WFr = WFr - Wburned;
        end
    end
            
    delF = WFa - WFr;
    if delF > tolerance
        WTO = WTO - delF;
    end            
end
    
% Check takeoff and landing length constraints
if data.sB > L_length
    mLL = {'Landing distance requirement exceeded.'};
else
    mLL = {'Landing distance requirement met.'};
end
if data.sTO > TO_length
    mLT = {'Takeoff distance requirement exceeded.'};
else
    mLT = {'Takeoff distance requirement met.'};
end

% Check thrust required constraints
alpha = data.alpha;
Ta = T_SL.*alpha;
Treq = data.Treq;
Sreq = data.Sreq;

if sum(Treq > Ta) > 1
    mTS = {'Thrust required exceeds thrust available based on the value of the thrust lapse coefficient.'};
    if sum(Sreq > S) > 1
        mTS = {'Thrust required exceeds thrust available based on the value of the thrust lapse coefficient, and the required wing area exceeds the availale wing area.'};
    end
else
    mTS = {'Thrust and wing area available meet requirements'};
    if sum(Sreq > S) > 1
        mTS = {'Required wing area exceeds available wing area.'};
    end
end

if startFuel > 0
    if data.startFuel > startFuel/numEng
        mSF = {'Start fuel requirements exceeded.'};
    else 
        mSF = {'Start fuel requirements met.'};
    end
    if data.fuelBurnedPerMin > warmupFuel/numEng
        mWF = {'Warmup fuel requiremented exceeded.'};
    else
        mWF = {'Warmup fuel requirements met.'};
    end
    if data.runUpFuel > runUpFuel/numEng
        mRF = {'Run up fuel requiremented exceeded.'};
    else
        mRF = {'Run up fuel requirements met.'};
    end 
    message = [mLL; mLT; mSF; mWF; mRF; mTS];
else
    message = [mLL; mLT; mTS];
end

end

