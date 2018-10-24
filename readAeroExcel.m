function aero = readAeroExcel(filename)

fullAero = readtable(filename);

for i = 1:height(fullAero)
    aeroCell = fullAero{i,1};
    aeroString = aeroCell{1};
    
    switch aeroString
        case 'CLmax'
            aero.CLmax = fullAero{i,3};
        case 'CLalpha'
            aero.CLalpha = fullAero{i,3};
        case 'CL0'
            aero.CL0 = fullAero{i,3};
        case 'CD0'
            aero.CD0 = fullAero{i,3};
        case 'CDR_TO'
            aero.CDR_TO = fullAero{i,3};
        case 'CDR_Land'
            aero.CDR_Land = fullAero{i,3};
        case 'Interference Drag Coefficient'
            aero.K2 = fullAero{i,3};
        case 'Aspect Ratio'
            aero.AR = fullAero{i,3};
        case 'Oswalds Efficiency'
            aero.e = fullAero{i,3};
        case 'Quarter Chord Sweep'
            aero.swpc4 = fullAero{i,3};
    end
end

aero.K1 = 1/(pi*aero.AR*aero.e);