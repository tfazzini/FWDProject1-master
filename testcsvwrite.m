clear
clc

% fid = fopen('Test.csv','w');
% nameVector = {'Requirement','Required_or_Desired','Engine_Type','Afterburner','Altitude_ft','Velocity_kts','Velocity_Mach','T0_SL','Estimated_B','Climb_Rate_Max_fpm','Load_Factor','Turn_Radius','V_Initial_kts','V_Initial_Mach','V_Final_kts','V_Final_Mach','Time_accel_sec','k_TO','Takeoff_Ground_Roll_ft','Takeoff_Total_Distance_ft','Runway_Friction_Coefficient','Time_rotate_sec','Angle_of_Climb_deg','Height_Obstacle_ft','Distance_Landing_Roll_ft','Distance_Total_Landing_ft','k_TD','k_obs','Time_Free_Roll_sec','Thrust_Rev_Perc_Thrust'};
% writeVector = {'Yes' 'Test' 'Test' 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0};
% % T = cell2table(writeVector,'VariableNames',nameVector);
% % writetable(T,'Test.csv');
% fprintf(fid,'%s,',nameVector{1,:});
% fprintf(fid,'\n');
% fclose(fid);

fid = fopen('Test.csv','a');
writeVector = {'Yes' 'Test' 'Test' 0 NaN 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0};
fprintf(fid,'%s,%s,%s,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f\n',writeVector{1,:});
fclose(fid);

% fid = fopen('Test.csv','w');
% csvwrite('Test.csv',nameVector);
% fclose(fid);