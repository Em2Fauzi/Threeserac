function [Io, RenderScreen] = render_axial...
    (Initial_Condition, Screen_Property, Parallel_Computing, ADisk_Surface,Spacetime)

r0              = Initial_Condition(1);
dr0             = Initial_Condition(3);

Resolution      = Screen_Property(1);
ScreenDistance  = Screen_Property(3);
FoV             = Screen_Property(4);

ScreenHeight    = ScreenDistance * FoV / r0;
ymage           = linspace(ScreenHeight, 0, Resolution);
RenderScreen    = zeros([Resolution, Resolution]);

dy_init         = dr0 * ymage / ScreenDistance;
dph0            = dy_init / r0;

Io = zeros(1,Resolution);

if Parallel_Computing
    parfor i = 1:Resolution
        Io(i)   = io_axial( [0; r0; 0; 0], [0; dr0; 0; dph0(i)], ADisk_Surface, Spacetime );
    end
else
    for i = 1:Resolution
        Io(i)   = io_axial( [0; r0; 0; 0], [0; dr0; 0; dph0(i)], ADisk_Surface, Spacetime );
    end
end

Max_Inten = 1;
for z_im = 1:Resolution
    for y_im = 1:Resolution
        r = 2*sqrt(((ymage(z_im)-(ScreenHeight/2))^2) + ((ymage(y_im)-(ScreenHeight/2))^2));
        if r < ScreenHeight
            Pixel_Intensity = interp1(ymage, Io, r)/Max_Inten;
            
            RenderScreen(z_im,y_im) = Pixel_Intensity;
        else
            RenderScreen(z_im,y_im) = 0;
        end
    end
end