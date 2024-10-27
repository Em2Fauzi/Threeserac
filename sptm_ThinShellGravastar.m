classdef sptm_ThinShellGravastar
    properties
        M = 1
        R = 2.01
        gtt_In
        r_points
    end
    methods
        function g = gtt(obj, x)
            if x(2) >= obj.R
                g = -(1-(2*obj.M/x(2)));
            else
                g = -interp1(obj.r_points, obj.gtt_In, x(2));
            end
        end

        function g = grr(obj, x)
            if x(2) >= obj.R
                g = 1/(1-(2*obj.M/x(2)));
            else
                g = 1/(1-(2*obj.m(x(2))/x(2)));
            end
        end

        function h = hr(obj,x)
            h = x(2)^2;
        end

        function m_ = m(obj,r)
            m_ = obj.M*r^3/(obj.R^3);
        end
    end
end