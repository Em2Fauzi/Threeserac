classdef eos_ThinShellGravastar
    properties
        M = 1
        R = 2.01
        w = 1
        a = 1
        L = 1
        sig_t = 1e-5
    end

    methods
        function eps_ = eps(obj,r)
            eps_ = 3*obj.M/(4*pi*obj.R^3);
        end
        function m_ = m(obj,r)
            m_ = obj.M*r^3/(obj.R^3);
        end
        function p_ = p(obj,r)
            p_ = -obj.eps(r).*(1 - obj.F(r));
        end

        function dnu_ = dnu(obj,r)
            dnu_ = ((8*pi.*obj.p(r).*(r.^3)) + (2*obj.m(r)))./(r.*(r-(2*obj.m(r))));
        end
        
        function [gtt, rr] = integrate_gtt(obj,nr)
            rr = linspace(0,obj.R,nr);
            dr = -obj.R/nr;
            nu_int(nr) = log(1 - 2*obj.m(obj.R)/obj.R);
            for i = nr:-1:2
                k1 = dr*obj.dnu(rr(i));
                k2 = dr*obj.dnu(rr(i)+(dr/2));
                k3 = dr*obj.dnu(rr(i)+(dr/2));
                k4 = dr*obj.dnu(rr(i)+(dr));
                nu_int(i-1) = nu_int(i) + (k1 + 2*k2 + 2*k3 + k4)/6;
            end
            gtt = exp(nu_int);
        end

        function F_ = F(obj,r)
            tr = (1 + tanh((r - (obj.R-1e-5))./(obj.sig_t)))/2;
            fr = 1 + obj.a.*(obj.eps(r)./obj.eps(0)).^(obj.L-1);
            F_ = tr.*fr;
        end
    end
end