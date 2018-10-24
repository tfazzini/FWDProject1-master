function a = T_lap_lowfan(burner,V,alt,T0)

[Mach,d_0,theta_0] = atmosphericModel(V,alt,T0);
    
if burner == true
    a = d_0;
elseif burner == false
    a = 0.6*d_0;
    
end