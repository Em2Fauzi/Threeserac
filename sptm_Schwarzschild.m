classdef sptm_Schwarzschild
    properties
        M = 1
    end
    methods
        function g = gtt(obj,x)
        g = -(1-(2*obj.M/x(2)));
        end

        function g = grr(obj,x)
        g = 1/(1-(2*obj.M/x(2)));
        end
        
        function h = hr(obj,x)
        h = x(2)^2;
        end
    end
end



