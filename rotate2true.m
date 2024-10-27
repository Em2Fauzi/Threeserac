function [x, y, z] = rotate2true(pos, init)

rot1 = [1 0 0; 0 cos(init(2)) -sin(init(2)); 0 sin(init(2)) cos(init(2))]*[pos(1); pos(2); pos(3)]; 
rot2 = [cos(init(1)-pi/2) 0 sin(init(1)-pi/2); 0 1 0; -sin(init(1)-pi/2) 0 cos(init(1)-pi/2)]*rot1;

x = rot2(1); y = rot2(2); z = rot2(3);

