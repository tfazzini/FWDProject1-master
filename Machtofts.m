function v_fts = Machtofts(alt,vel_Mach)

val = getStdValues();

gam = val.gam;
R = val.R; % ftlb/slugR
Pstd = val.Pstd; % psf
Tstd = val.Tstd_R; % R
k = val.k; % 1/ft

if alt <= 36089
    T = Tstd*(1+k*alt);
    P = Pstd*(1+k*alt)^5.2561;
elseif alt > 36089 && alt <= 65617
    T = Tstd*(1+k*36089);
    P = Pstd*0.223361*exp(-(alt-36089)/20806);
elseif alt > 65617 && alt <= 104987
    T = Tstd*(0.682457+alt/945374);
    P = Pstd*(0.988626+alt/652600)^-34.16320;
elseif alt > 104987 && alt <= 154199 
    T = Tstd*(0.482561+alt/337634);
    P = Pstd*(0.898309+alt/577922)^12.20114;
end

Mach_gen = sqrt(gam*R*T);

v_fts = vel_Mach*Mach_gen;

end