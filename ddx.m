function dphdr = ddx(x,b,S)
%---!!DESCRIPTION!!---%

%   The differential equation,
%   dph/dr = r^2 * h(r) * sqrt(...)

%---!!---%

dphdr = 1/(S.hr(x)*sqrt( ( (1/b^2) - Vr(x,S) ) / (-S.gtt(x)*S.grr(x))));
    
