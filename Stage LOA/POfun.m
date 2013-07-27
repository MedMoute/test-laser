function dy = POfun(t,x,Param,X)
%Modèle de l'oscillateur forcé pour le phonon

%State equation
dy = zeros(2,1);
dy(1)=1/Param.m.*Param.Te(floor(t+1),IndexOfX(X+1))-Param.nu.*x(1)-Param.wo2.*x(2);
dy(2)=x(1);
end

function y=IndexOfX(x)
y=int16(20.*x-19);
end