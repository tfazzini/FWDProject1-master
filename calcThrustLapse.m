function [alpha] = calcThrustLapse(power, V, alt)

% Propulsion parameters
prop = getPropData();
engineType = prop.type;
[Mach,d_0,theta_0,~,~,~, sigma] = atmModel(V,alt);

% Checking if afterburner used
if strcmp(power, 'normal') == 1 || strcmp(power, 'military') == 1
    burner = false;
else 
    burner = true;
end

% Calculating alpha based on engine type
if strcmp(engineType, 'turbojet') == 1
    % Checking whether afterburners used
    if burner == true
        alpha1 = d_0*(1-0.3*(theta_0-1)-0.1*sqrt(Mach));
%         alpha2 = (0.952 + (0.3*(Mach - 0.4)^2)) * sigma^0.7;
%         alpha = max(alpha1,alpha2);
        alpha = alpha1;
    else
        alpha1 = 0.8*d_0*(1-0.16*sqrt(Mach));
%         alpha2 = 0.76*(0.907 + 0.262*(abs(Mach-0.5)^1.5))*sigma^0.7;
%         alpha = max(alpha1,alpha2);
        alpha = alpha1;
    end   
else 
if strcmp(engineType, 'turbofan_low') == 1
    if burner == true
        alpha = d_0;
    else
        alpha = 0.6*d_0;
    end 
else 
if  strcmp(engineType, 'turbofan_high') == 1 
    alpha = (0.568 + (0.25*(1.2 - Mach)^3)) * sigma^0.6;
else
if  strcmp(engineType, 'turboprop') == 1 
    if Mach < 0.1
        alpha = sqrt(sigma);
    else
        alpha = (0.12/(Mach+0.02))*sqrt(sigma);
    end
else
    error('Engine type specificied not supported.')
end
end 
end
end

end