function Ie = intensity_profile(r,param)

p = param;
yg = p(1);
mu = p(2);
sig = p(3);

Ie = exp(-((yg + asinh((r-mu)/sig)).^2)/2)./(sqrt(((r-mu).^2)+sig^2));