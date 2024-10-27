function phone = integr_rk4(x,dx,bt,S)
%---!!DESCRIPTION!!---%

%   Numerical integrator, using 4th order Runge-Kutta method

%---!!---%

k1 = dx*ddx([0, x(2), 0, 0],bt(1),S);
k2 = dx*ddx([0, x(2)+(bt(2)*dx)/2, 0, 0],bt(1),S);
k3 = dx*ddx([0, x(2)+(bt(2)*dx)/2, 0, 0],bt(1),S);
k4 = dx*ddx([0, x(2)+(bt(2)*dx), 0, 0],bt(1),S);

phone= x(4) + ((k1 + 2*k2 + 2*k3 + k4)/6);