function Io = io_axial(x,dx,ADisk_Surface,Spacetime)

err_max = 1e-7;
err_double = 1e-10;

b = impact_parameter(x,dx,Spacetime); tn = -1;
r = x(2); ph = x(4); r0 = x(2); dr = dx(2);
r_old = r;
Rhorizon = ADisk_Surface(4);

Io = 0;
while ph < 6*pi
    if Vr([x(1), x(2)+(tn*dr*2), x(3), x(4)], Spacetime) >= 1/b^2
        tn=-tn;
        r = r_old;
    end
    r_old = r;

    php1 = integr_rk4([0,r,0,ph],dr,[b, tn], Spacetime);

    phh1 = integr_rk4([0,r,0,ph],dr/2,[b, tn], Spacetime);
    phh2 = integr_rk4([0, r+(tn*dr/2), 0, phh1],dr/2,[b, tn], Spacetime);

    rh2 = r + (tn*dr);
    
    err = abs((php1-phh2)/phh2);

    if err > err_max
        dr = dr/2;
    else
        x_old = x;
        x(2) = rh2; x(4) = phh2;
        r = x(2); ph = x(4);

        if err > err_double
            dr = dr/2;
        else
            dr = dr*2;
        end
        Io = Io + detect_accretion_axial(x,x_old,ADisk_Surface,Spacetime);

        if r<Rhorizon
            break
        end
    
        if r>r0
            break
        end
    end
end