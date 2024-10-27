classdef sptm_PrimaryHair
    properties
        M = 2.137
        lam = 1
        n = 1
        % q = 4*M/(n*pi*lam);
        q = 2.66
    end
    methods
        function g = gtt(obj, x)
        g = -( 1-(2*obj.M/x(2)) + obj.n*obj.q *( ((pi/2 - atan(x(2)/obj.lam))/(x(2)/obj.lam)) + 1/(1 + (x(2)/obj.lam)^2 ))   );
        end

        function g = grr(obj, x)
        g = 1/( 1-(2*obj.M/x(2)) + obj.n*obj.q *( ((pi/2 - atan(x(2)/obj.lam))/(x(2)/obj.lam)) + 1/(1 + (x(2)/obj.lam)^2 ))   );
        end
        
        function h = hr(obj,x)
        h = x(2)^2;
        end
    end
end



