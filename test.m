%% Testing performMissionAnalysis

TW = 0.42;
WS = 50;
WTO = 16000;
    T_SL = TW * WTO;
    S = WTO/WS;
 input = getInput();


[WTO, T_SL, S, data, message] =...
    performMissionAnalysis(TW, WS, WTO, input)