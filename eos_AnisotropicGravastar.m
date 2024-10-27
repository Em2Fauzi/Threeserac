classdef eos_AnisotropicGravastar
    properties
        M = 1
        l = 1.4632
        R = 2.5
        alphac = 1.36686
        w = 1
        a = 1
        L = 2
        sig_s = 0.001
        sig_t = 0.3
    end

    methods
        function eps_ = eps(obj,r)
            eps_ = 3/(4*pi) .* (obj.M.*obj.k.*obj.l.^3)./((r.^3 + obj.l.^3).^2) .* (1-(r./obj.R).^3);
        end
        function m_ = m(obj,r)
            m_ = obj.k.*obj.M.*r.^3.*(1./(obj.l.^3+r.^3)-...
                (obj.l.^3 * (-r.^3+obj.l.^3 .* log(1+r.^3./obj.l.^3)+r.^3 .*log(1+r.^3./obj.l.^3)))./...
                (r.^3 .*(obj.l.^3+r.^3) .* obj.R.^3));
        end
        function p_ = p(obj,r)
            p_ = -obj.eps(r).*(1 - obj.F(r)*obj.Thet);
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
            tr = (1 + tanh((r - obj.alpha.*obj.w)./(obj.alpha.*obj.sig_t)))/2;
            fr = 1 + obj.a.*(obj.eps(r)./obj.eps(0)).^(obj.L-1);
            F_ = tr.*fr;
        end

        function Thet_ = Thet(obj)
            Thet_ = 1/(1 + exp((obj.alpha - obj.alphac)/obj.sig_s));
        end

        function alph = alpha(obj)
            alph = 2*obj.M/obj.l;
        end
        function k_ = k(obj)
            k_ = 1./(obj.R.^3.*(1./(obj.l.^3+obj.R.^3)-...
                (obj.l.^3.*(-obj.R.^3+obj.l.^3.*log(1+obj.R.^3/obj.l.^3)...
                +obj.R.^3.*log(1+obj.R.^3/obj.l.^3)))./(obj.R.^6.*(obj.l.^3+obj.R.^3))));
        end
    end
end