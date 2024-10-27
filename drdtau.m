function d = drdtau(r,E,L,S)

d = sqrt((E^2 - (Vr([0,r,0,0],S)*L^2))/(-S.gtt([0,r,0,0])*S.grr([0,r,0,0])));