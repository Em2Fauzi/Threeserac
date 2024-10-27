classdef sptm_Hayward
    properties
        M = 1
        l = 0.5
    end
    methods
        function g = gtt(obj, x)
            g = -(1-(2*obj.m(x(2))/x(2)));
        end

        function g = grr(obj, x)
            g = 1/(1-(2*obj.m(x(2))/x(2)));
        end

        function h = hr(obj,x)
            h = x(2)^2;
        end

        function m_ = m(obj,r)
            m_ = obj.M*r^3/(r^3 + obj.l^3);
        end
    end
end



