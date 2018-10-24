% Function checks to ensure the percent fuel reserve requirement is met, if
% the requirement is not met, a new value for WTO is returned

function [WTOnew, disp, c] = checkReservePercent(data, percentReserveReq)

WTO = data.W_i(1);
Wf = data.W_f(end);
percentReserve = (Wf/WTO) * 100;
if percentReserve < percentReserveReq
    WTOnew = WTO + ((percentReserveReq*WTO - Wf)/(1 - percentReserveReq));
    disp = 'Percent reserve fuel not satisfied, increased fuel weight';
    c = 0;
else
    WTOnew = WTO;
    disp = 'Percent reserve fuel satisfied';
    c = 1;
end

end 