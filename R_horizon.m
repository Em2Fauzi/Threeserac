function R = R_horizon(r_guess,S);

B = @(r) 1/S.grr([0,r,0,0]);

R = fzero(B,r_guess,optimset('Display','off'));
if or(isnan(R),R<0)
    R = -1e-5;
end