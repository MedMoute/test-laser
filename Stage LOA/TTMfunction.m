function [c,f,s] = TTMfunction(x,t,T,DTDx,Param,Solid,Laser,Univ)

c = [Param.Ce; Param.Cl]; 
f = [Param.Ke; Param.Kl] .* DTDx; 
y = T(1) - T(2);
F = (Param.g*y);
s = [Solid.Ab*Laser.Elas*sqrt(1/(2*pi))*exp(-x)*exp(-((t).^2)/2)-F; F]; 

end

