
function [pl,ql,pr,qr] = TTMCondBord(xl,Tl,xr,Tr,t,Param,Solid,Laser,Univ)

% if t==0
%     pl = [0; 0];
%     ql = [0; 0]; 
%     pr = [0; 0];
%     qr = [0; 0]; 
% else
    pl = [(Tl(1)-Univ.Tamb)*Param.Ce-I_P_Ce(xl,t,Solid,Laser,Univ,Param); (Tl(2)-Univ.Tamb)*Param.Cl-I_P_Cr(xl,t,Solid,Laser,Univ,Param)];
    ql = [0; 0]; 
    pr = [(Tr(1)-Univ.Tamb)*Param.Ce-I_P_Ce(xr,t,Solid,Laser,Univ,Param); (Tr(2)-Univ.Tamb)*Param.Cl-I_P_Cr(xr,t,Solid,Laser,Univ,Param)]; 
    qr = [0; 0]; 
% end
end

function I_Pl=I_P_Ce(x,t,Solid,Laser,Univ,Param)

I_Pl =(Param.Ce/(Param.Ce+Param.Cl))*Solid.Ab*Laser.Elas*sqrt(1/(2*pi))*( 1 - exp(-((t-1).^2)/2) ).*exp(-x);
end

function I_Pr=I_P_Cr(x,t,Solid,Laser,Univ,Param)

I_Pr =(Param.Cl/(Param.Ce+Param.Cl))*Solid.Ab*Laser.Elas*sqrt(1/(2*pi))*( 1 - exp(-((t-1).^2)/2) ).*exp(-x);
%I_Pr =(Param.Cl/(Param.Ce+Param.Cl))*Solid.Ab*(sqrt(pi)/2)*( 1 - exp(-((t-1).^2)).*exp(-x) );
end

function I_P=I_P(x,t,Solid,Laser,Univ,Param)

I_P =Solid.Ab*Laser.Elas*sqrt(1/(2*pi))*( 1 - exp(-((t-1).^2)/2) ).*exp(-x);
%I_Pr =(Param.Cl/(Param.Ce+Param.Cl))*Solid.Ab*(sqrt(pi)/2)*( 1 - exp(-((t-1).^2)).*exp(-x) );
end