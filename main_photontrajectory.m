clear all; clc; clf;

%-----------------[Configurations]-----------------


%-----------------//Global variables\\-----------------
Spacetime           = sptm_ModifiedHayward;
% Spacetime.M         = 1;

M_                   = Spacetime.M;
%-----------------\\Global variables//-----------------


%-----------------//Initial condition\\-----------------
photon_num = 10; % number of photons

r0 = linspace(500, 500, photon_num); % initial distance
ph0 = linspace(0, 0, photon_num); % initial phi position

FoV = 12*M_;

dr0 = linspace(0.01, 0.01, photon_num);
dph0 = linspace(0.03077334*dr0(1)*FoV/(r0(1)^2), 0.83176105*dr0(1)*FoV/(r0(1)^2), photon_num);


%-----------------\\Initial condition//-----------------


%-----------------[Configurations]-----------------



Rhorizon = R_horizon(2*M_,Spacetime);

th0 = linspace(pi/2, pi/2, photon_num); % fixed value
lin0 = linspace(0,0,photon_num);
x = [lin0; r0; th0; ph0]; dx = [lin0; dr0; lin0; dph0];

for j = 1:photon_num
    b = impact_parameter(x(:,j),dx(:,j),Spacetime);
    tn = -1;
    bt = [b, tn];
    
    dr = dx(2,j);
    [r,ph,i] = xp1_adaptive(x(:,j),dr,bt,Spacetime,Rhorizon);
    rp(1:length(r),j) = r; php(1:length(ph),j) = ph; ij(j) = i;
end

for j = 1:photon_num
    rp(ij(j):length(rp),j) = rp(ij(j),j);
    php(ij(j):length(php),j) = php(ij(j),j);
end


th_ph = linspace(0,2*pi);

xplot = rp.*cos(php); yplot = rp.*sin(php);

plot_lim = 0.93176105*FoV;

plot(xplot,yplot,'r')

xlim([-plot_lim, plot_lim]); ylim([-plot_lim, plot_lim]);
pbaspect([1 1 1])
