function Io = detect_accretion_inclined(r, pos, pos_old, dr, param, EL, S)

x = pos(1); y = pos(2); z = pos(3);
x_old = pos_old(1); y_old = pos_old(2); z_old = pos_old(3);
E = EL(1); L = EL(2);

if z*z_old< 0
    r_det = r(2) - (z_old * ( (r(1) - r(2)) / (z - z_old) ) );

    thet_rot = acos(z/r_det);
    dphi_rot = (-((y/(y^2 + x^2))*(x-x_old)) + ((x/(y^2 + x^2))*(y-y_old)))/dr;
    
    ut = real(sqrt(2)/sqrt((-2*S.gtt([0,r_det,0,0])) - (dgtt(r_det,S)*r_det)));
    uphi = real(sqrt(dgtt(r_det,S))/sqrt((-2*S.gtt([0,r_det,0,0])*r_det) - (dgtt(r_det,S)*r_det^2)));

    dphidtau = dphi_rot*drdtau(r_det,E,L,S)*(r_det^2)*(sin(thet_rot)^2);

    g = 1/(ut - (dphidtau*uphi/E));
    
    Io = intensity_profile(r_det,param)*g^4;
    if isinf(Io)
        Io = 0;
    end
else
    Io = 0;
end