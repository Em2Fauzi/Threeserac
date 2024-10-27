function [Io, RenderScreen] = render_inclined...
    (Initial_Condition, Screen_Property, Parallel_Computing, ADisk_Surface, Spacetime)

r0              = Initial_Condition(1);
th0             = Initial_Condition(2);
dr0             = Initial_Condition(3);

Resolution      = Screen_Property(1:2);
ScreenDistance  = Screen_Property(3);
FoV             = Screen_Property(4);

AspectRatio     = Resolution(1)/Resolution(2);

ScreenHeight_y  = ScreenDistance * FoV / r0;
ScreenHeight_z  = ScreenDistance * FoV / (AspectRatio*r0);
ymage           = linspace(-ScreenHeight_y, ScreenHeight_y, Resolution(1));
zmage           = linspace(-ScreenHeight_z, ScreenHeight_z, Resolution(2));
Io              = zeros([Resolution(2), Resolution(1)]);

dz_init         = dr0 * zmage / ScreenDistance;
dy_init         = dr0 * ymage / ScreenDistance;

dph0            = dy_init / r0;
dth0            = dz_init / r0;

x   = [0; r0;  th0;  0];

if Parallel_Computing
    for i = 1:Resolution(1)
        parfor j = 1:Resolution(2)
            Io(j,i)   = io_inclined ( x, [0; dr0; dth0(j); dph0(i)], ADisk_Surface, Spacetime );
        end
        imagesc(Io)
        pbaspect([1 1 1])
        pause(0.000000001)
    end
else
    tic
    for i = 1:Resolution(1)
        for j = 1:Resolution(2)
            Io(j,i)   = io_inclined ( x, [0; dr0; dth0(j); dph0(i)], ADisk_Surface, Spacetime );
        end
        imagesc(Io)
        pbaspect([AspectRatio 1 1])
        pause(0.000000001)
    end
    toc
end
RenderScreen = Io;