classdef sptm_HaywardFinite
    properties
        M = 1
        R = 5
        l = 1
    end
    methods
        function g = gtt(obj, x)
            if x(2) >= obj.R
                g = -(1-(2*obj.M/x(2)));
            else
                g = -(1-(2*obj.m(x(2))/x(2)));
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
            m_ = obj.k.*obj.M.*r.^3.*(1./(obj.l.^3+r.^3)-...
                (obj.l.^3 * (-r.^3+obj.l.^3 .* log(1+r.^3./obj.l.^3)+r.^3 .*log(1+r.^3./obj.l.^3)))./...
                (r.^3 .*(obj.l.^3+r.^3) .* obj.R.^3));
        end

        function k_ = k(obj)
            k_ = 1./(obj.R.^3.*(1./(obj.l.^3+obj.R.^3)-...
                (obj.l.^3.*(-obj.R.^3+obj.l.^3.*log(1+obj.R.^3/obj.l.^3)...
                +obj.R.^3.*log(1+obj.R.^3/obj.l.^3)))./(obj.R.^6.*(obj.l.^3+obj.R.^3))));
        end
    end
end



