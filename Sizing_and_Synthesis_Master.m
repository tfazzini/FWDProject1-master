%% Aircraft Design Project 1 - Aircraft Sizing and Synthesis Tool
% Sam Corrado and Nathan Crane
% Submitted 10/26/2018
clear;
clc;

%% Get Aero Values
aerofile = 'AerodynamicInput.csv';
aero = readAeroExcel(aerofile);

% OR getAeroData.m

%% Get Requirement Values
reqfile = 'Requirements.csv';
reqs = readReqExcel(reqfile);

%% Constraint Analysis
%Get W/S and T/W

[WS,TW] = performConstraintAnalysis(reqs,aero);

%% Mission Analysis

%% Mission Analysis

% % 
% % Initialize the convergence indicator to false
% % convergence = 0;
% % while convergence == 0
% %     Perform mission analysis
% %     [data] = performMissionAnalysis(missionInput,aeroInput,propInput,TS,WS,WTO);
% % 
% %     Check constraint analysis with updated weight fractions
% %     betas = vertcat(1,data.Wf_Wi(1:end-1));
% %     [constraints] = constraintAnalysis(aeroInput,propInput,missionInput,...
% %         TS,WS,WTO,betas);
% %     
% %     If the constraint analysis is satisfied
% %     if c_const == 1    
% %     Check the takeoff requirements
% %     %% Check the warm-up, taxi and stuff requiremnts here
% %     Check the landing requirements    
% %         Check type of requirement
% %         percentResReq = missionInput.fuel_reserve_percent(end); % percent
% %         timeResReq = missionInput.fuel_reserve_min(end); % min
% %         heightResReq = missionInput.height_reserve_ft(end); % ft
% %         speedConditionResReq = missionInput.speed_reserve_fps(end); % fps
% %         If requirement is percent fuel and is specified to perform at a
% %         certain flight condition
% %         if isnan(percentResReq) == 0 && isnan(timeResReq) == 0 &&...
% %                 isnan(heightResReq) == 0 &&...
% %                 isnan(speedConditionResReq) == 0
% %             [WTOnew1,d1,a] = checkPercentFuelReserve(data,percentResReq);
% %             [WTOnew2,d2,b] = checkReservePerformance(aeroInput,...
% %                 propInput, timeResReq,heightResReq,speedConditionResReq);
% %             if a + b == 2
% %                 WTOnew = data.W_i(1);
% %                 disp = 'Fuel reserve requirements met';
% %                 c = 1;
% %             else 
% %             if a + b < 0
% %                 WTOnew = max(WTOnew1,WTOnew2);
% %                 disp = 'Fuel reserve requirements not met, increased WTO';
% %                 c = 0;
% %             end 
% %             end 
% %         else       
% %         If requirement is percent fuel
% %         if isnan(percentResReq) == 0
% %             [WTOnew,disp,c] = checkPercentFuelReserve(data,percentResReq);
% %         else 
% %         If requirement is specified to perform at a certain flight
% %         condition
% %         if isnan(timeResReq) == 0 && isnan(heightResReq) == 0 &&...
% %                 isnan(speedConditionResReq) == 0
% %             [WTOnew,disp,c] = checkReservePerformance(aeroInput,...
% %                 propInput,timeResReq,heightResReq,speedConditionResReq);
% %         else
% %         If no requirement for fuel reserve is specified
% %             disp = 'No fuel reserve requirement specified';
% %             c = 1;
% %         end
% %         end
% %         end
% %     end
% %     
% % end 
% % 
% % 
% % % Constant Speed Climb
% % 
% % % Horizontal Acceleration
% % 
% % % Climb and Acceleration
% % 
% % % Takeoff Acceleration
% % 
% % % Constant Altitude/Speed Cruise
% % 
% % % Constant Altitude/Speed Turn
% % 
% % % Best Cruise Mach Number and Altitude
% % 
% % % Loiter
% % 
% % % Warm-Up
% % 
% % % Takeoff Rotation
% % 
% % % Constant Energy Height Maneuver
% % 
% % % Aerial Refueling
% % 
