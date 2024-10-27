function [r, ph, i] = xp1_adaptive(x,dr,bt,Spacetime,Rhorizon)

M = Spacetime.M;

b = bt(1); tn = bt(2);
r(1) = x(2); ph(1) = x(4); r0 = x(2);

err_max = 1e-7;
err_double = 1e-8;

i=1;
while ph(i) < 8*pi
    bt = [b, tn];
    if Vr([x(1), x(2)+(tn*dr*2), x(3), x(4)],Spacetime) >= 1/b^2
        tn=-tn;
    else
        php1 = integr_rk4(x,dr,bt,Spacetime);

        phh1 = integr_rk4(x,dr/2,bt,Spacetime);
        rh1 = r(i)+tn*dr/2;
        phh2 = integr_rk4([x(1), rh1, x(3), phh1],dr/2,bt,Spacetime);
        rh2 = r(i)+tn*dr;

        err = abs((php1-phh2)/phh2);

        if err > err_max
            dr = dr/2;
        else
            x(2) = rh2; x(4) = phh2;
            r(i+1) = x(2); ph(i+1) = x(4);
            i = i+1;
            if err > err_double
                dr = dr/2;
            else
                dr = dr*2;
            end
        end

    end

    break_con = or(r(i)<Rhorizon,r(i)>500);

    if break_con
        break
    end
end
