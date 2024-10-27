function Io = io_inclined(x,dx,ADisk_Surface,Spacetime)

err_max = 1e-7;
err_double = 1e-10;

th0 = x(3); r0 = x(2);
zrot_old = x(2)*cos(th0);
yrot_old = x(2)*sin(x(4))*sin(th0);
xrot_old = x(2)*cos(x(4))*sin(th0);
pos_old = [xrot_old, yrot_old, zrot_old];

[x, dx, beta] = rotate2fullphi(x,dx);
[b, E, L] = impact_parameter(x,dx,Spacetime); tn = -1;
EL = [E,L];
ph = x(4); dr = dx(2);
x_old = x;

Rhorizon = ADisk_Surface(4);

Io = 0;
while ph < 6*pi
    if Vr([x(1), x(2)+(tn*dr*2), x(3), x(4)], Spacetime) >= 1/b^2
        tn=-tn;
        x = x_old;
    end
    php1 = integr_rk4(x,dr,[b, tn],Spacetime);

    phh1 = integr_rk4(x,dr/2,[b, tn],Spacetime);
    phh2 = integr_rk4([x(1), x(2)+(tn*dr/2), x(3), phh1],dr/2,[b, tn],Spacetime);

    rh2 = x(2) + (tn*dr);

    err = abs((php1-phh2)/phh2);

    if err > err_max
        dr = dr/2;
    else
        x_old = x;
        x(2) = rh2; x(4) = phh2;

        
        r = x(2);   r_old = x_old(2);
        ph = x(4);
        
        xpos = r*cos(ph);
        ypos = r*sin(ph);
        
        [xrot, yrot, zrot]        = rotate2true([xpos, ypos, 0], [th0, beta]);
        pos = [xrot, yrot, zrot];

        Io = Io + detect_accretion_inclined([r, r_old], pos, pos_old, dr, ADisk_Surface, EL, Spacetime);
        pos_old = pos;
        

        if err > err_double
            dr = dr/2;
        else
            dr = dr*2;
        end

        if r>r0
            break
        end
    
        if r<Rhorizon
            break
        end
    end
end