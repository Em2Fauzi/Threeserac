function [b,E,L] = impact_parameter(x,dx,S)

E = sqrt(-S.gtt(x) * ( (S.grr(x)*dx(2)^2) + (S.hr(x)*(dx(4)^2)) ) );
L = dx(4)*x(2)^2;

b = L/E;