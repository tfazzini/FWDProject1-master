function [TSFC, radicalTheta, C1, C2] = calcTSFC(power, V, alt)

[M,~,~,~,T,~] = atmModel(V, alt);

% Standard parameters
val = getStdValues();
Tstd = val.Tstd_R;

% Propulsion parameters
prop = getPropData();

% Calculating input parameters to the TSFC equations
theta = T/Tstd;
radicalTheta = sqrt(theta);

% Checking type of engine for specific TSFC equations
engineType = prop.type;
if strcmp(engineType, 'turbojet') == 1 
    if strcmp(power, 'max') == 1
        C1 = 1.5/3600;
        C2 = 0.23/3600;
    else
%         if M < 1.0
%             TSFC = 1.45*radicalTheta/3600;
%         else
%             TSFC = 1.65*radicalTheta/3600;
%         end
        C1 = 1.1/3600;
        C2 = 0.3/3600;
    end    
else
if strcmp(engineType, 'turbofan_low') == 1 
    if strcmp(power, 'max') == 1     
%         TSFC = 2.0*radicalTheta/3600;
        C1 = 0.9/3600;
        C2 = 0.3/3600;
    else
%         if M < 1.0
%             TSFC = 1.35*radicalTheta/3600;
%         else
%             TSFC = 1.45*radicalTheta/3600;
%         end
        C1 = 1.6/3600;
        C2 = 0.27/3600;
    end   
else
if  strcmp(engineType, 'turbofan_high') == 1 
%     if M < 0.9
%         TSFC = 1.0/3600;
%     end
    C1 = 0.45/3600;
    C2 = 0.54/3600;
else
if  strcmp(engineType, 'turboprop') == 1 
%     TSFC = 0.6*radicalTheta/3600;
    C1 = 0.18/3600;
    C2 = 0.8/3600;
else
    error('Engine type specificied not supported.')
end
end 
end
end

TSFC = (C1+C2*M)*radicalTheta;

% C1 = C1 / 3600;
% C2 = C2 / 3600;

end 