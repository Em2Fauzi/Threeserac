function [x_rotate, dx_rotate, beta] = rotate2fullphi(x, dx)

if dx(4)>=0
    beta = atan(dx(3)/dx(4));
else
    beta = atan(dx(3)/dx(4))-pi;
end
dphi        = sqrt((dx(3)^2) + (dx(4)^2));

x_rotate    = [x(1), x(2), 0, 0];
dx_rotate   = [dx(1), dx(2), 0, dphi];
