clear all; clc; clf;

rgbs = linspace(0,1,255);
rgbs = rgbs';
maps = [rgbs rgbs.^(1.7) rgbs.^(3)];
colormap(maps);

%-----------------[Configurations]-----------------

%-----------------//Computation settings\\-----------------
ParallelComputing   = true;
%-----------------\\Computation settings//-----------------


%-----------------//Global variables\\-----------------
Spacetime           = sptm_Schwarzschild;
Spacetime.M         = 1;
% Spacetime.l         = 1.2;

M_                   = Spacetime.M;
%-----------------\\Global variables//-----------------


%-----------------//Screen settings\\-----------------
Resolution          = [200 200]; % [horizontal, vertical] resolution

ScreenDistance      = 0.001;
FoV                 = 12*M_;     % Horizontal FoV from the center

ImageUpdate         = true;
%-----------------\\Screen settings//-----------------


%-----------------//Accretion disk property\\-----------------
yg                  = -2;
mu                  = R_isco(6*M_,Spacetime);
sig                 = M_/4;
%-----------------\\Accretion disk property//-----------------


%-----------------//Initial condition\\-----------------
r0                  = 1000;
th0                 = -0.3;        % th0 = 0 for axial observation

dr0                 = 0.001;     % dr0 will be the (initial) step size
%-----------------\\Initial condition//-----------------


%-----------------[Configurations]-----------------



Screen_Property     = [Resolution, ScreenDistance, FoV, ImageUpdate];
Initial_Condition   = [r0, th0, dr0];
ADisk_Surface       = [yg, mu, sig, R_horizon(2*M_,Spacetime)];

tic
if th0 == 0
    [Io, Image] = render_axial...
        (Initial_Condition, Screen_Property, ParallelComputing, ADisk_Surface, Spacetime);
else
    [Io, Image] = render_inclined...
        (Initial_Condition, Screen_Property, ParallelComputing, ADisk_Surface, Spacetime);
end
toc

imagesc(Image*600); pbaspect([1 1 1])
    





