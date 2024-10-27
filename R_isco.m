function R = R_isco(r_guess,S)

A = @(r) -S.gtt([0,r,0,0]);
dA = @(r) (A(r+0.00001) - A(r-0.00001))/(0.00002);
ddA = @(r) (dA(r+0.00001) - dA(r-0.00001))/(0.00002);

root_isco = @(r) (3*A(r)*dA(r)) - (2*r*dA(r)^2) + (r*A(r)*ddA(r));

R = fzero(root_isco,r_guess,optimset('Display','off'));