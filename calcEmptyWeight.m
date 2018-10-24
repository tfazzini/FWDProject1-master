function [WE] = calcEmptyWeight(WTO, input)

% Get input strct
type = input.type;

% Get weight breakdown
if strcmp(type,'fighter')
    WE = WTO * 2.34 * (WTO^-0.13);
else
    if strcmp(type,'cargo')
        WE = WTO * 1.26 * (WTO^-0.08);
    else
        if strcmp(type,'passenger')
            WE = WTO * 1.02 * (WTO^-0.06);
        else
            if strcmp(type,'twin_turboprop')
                WE = WTO * 0.96 * (WTO^-0.05); 
            else
                error('Aircraft type not supported for empty weight fraction.')
            end
        end
    end
end

end