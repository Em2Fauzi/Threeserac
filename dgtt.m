function dA = dgtt(r,S)

dA = (-S.gtt([0, r+1e-8, 0, 0]) - (-S.gtt([0, r-1e-8, 0, 0]))) / (2e-8);