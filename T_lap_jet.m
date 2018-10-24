function a = T_lap_jet(burner,V,alt,T0)

[Mach,d_0,theta_0] = atmosphericModel(V,alt,T0);
    
if burner == true
    a = d_0*(1-0.3*(theta_0-1)-0.1*sqrt(Mach));
elseif burner == false
    a = 0.6*d_0*(1-0.16*sqrt(Mach));
    
end