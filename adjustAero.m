function [CD0, K1] = adjustAero(M0, CD0, K1)

% CD0 from slide 51 in lecture 04B
if M0 < 0.75
    CD0 = CD0;
else
    m = (0.017 - 0.035)/(0.75 - 1.2);
    b = CD0 - m*0.75;
    if M0 < 1.2
        CD0 = m*M0 + b;  
    else
        CD0 = m*1.2 + b; 
    end
end

% K1 from slide 50 in lecture 04B
if M0 < 0.85
    K1 = K1;
else
   m = (0.14 - 0.2)/(0.85 - 1.35);
    b = K1 - m*0.85;
    K1 = m*M0 + b;  
    if M0 > 1.35
        m = (0.2 - 0.54)/(1.35 - 2.0);
        b = K1 - m*1.35;
        K1 = m*M0 + b;   
    end
end 