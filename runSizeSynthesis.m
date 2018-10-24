function [] = runSizeSynthesis(reqs,aero)

%Need to be able to feed current TW and WS into function

%Run constraint analysis
    [TW,WS] = performConstraintAnalysis(reqs,aero);