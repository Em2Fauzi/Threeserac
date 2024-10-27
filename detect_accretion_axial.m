function Io = detect_accretion_axial(x,x_old,param,S)

r = x(2); ph = x(4); 
r_old = x_old(2); ph_old = x_old(4);

xpos = r*cos(ph); xpos_old = r_old*cos(ph_old);

if xpos*xpos_old < 0
    r_det = r_old - (xpos_old*((r - r_old)/(xpos-xpos_old)));

    g = sqrt(-S.gtt([0, r_det, 0, 0]));
    
    Io = intensity_profile(r_det,param)*g^4;
    if isinf(Io)
        Io = 0;
    end
else
    Io = 0;
end