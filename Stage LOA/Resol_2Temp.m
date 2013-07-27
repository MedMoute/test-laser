%----------------------------------------------------------------------------------------%
%                    R�solution temporelle de la r�action d'un solide                    %
%                           � une impulsion laser ultra rapide                           %
%----------------------------------------------------------------------------------------%
%   Stage LOA - Ann�e 2012-2013
%
%   Le probl�me que nous souhaitons r�soudre correspond � la determination
%   par le calcul de la r�ponse d'un mat�riau solide � une impulsion
%   ultrabr�ve.
%   Pour pouvoir effectuer une comparaison du mod�le th�orique avec la
%   r�alisation exp�rimentale.
%   La seule donn�e exp�rimentale que l'on peut obtenir en r�solution
%   temporelle est la reflectifit� du mat�riau (cf. Th�se T. Garl pour plus
%   de pr�cisions)
%
%   A priori, les seules connaissances sur le syst�me sont celles
%   concernant l'impulsion laser et les propri�t�s standard du mat�riau
%   test�.
%
%   L'objectif de ce script est � terme de calculer num�riquement toutes
%   les propri�t�s temporelles de mat�riau aux temps ultrabrefs.
%   Celui ci sera coupl� � une interface graphique pour faciliter son
%   usage.


% 1.Import/Initialisation des constantes du syst�me

% 1.1 Initialisation des donn�es � zero.
clear;
close all;
Univ.Z_HBar =1.055*10^-34 ;                                  % Constante de Planck r�duite /J*s
Univ.Z_Kb = 1.38*10^-23; % Boltzmann constant / J*K-1
Univ.Z_Tamb = 300;      % Temperature ambiente /K
Univ.Z_ve = 1*10^8 ;   % Vitesse electronique ~ vitesse de Fermi /m*s-1

Laser.Z_Lambda0 = 800*10^-9     ;        % Longeur d'onde du laser /m
Laser.Z_Tlas = 35*10^-15; % Dur�e de l'impulsion /s
Laser.Z_Sigma = Laser.Z_Tlas*Laser.Z_Tlas/2;  % Ecart-type de la gaussienne-envellope /s 2
Laser.Z_Elas = 0.25*10^12; % Puissance de pic / J/s
Laser.Z_Fl=30; % Fluence

Solid.Z_Epsilonre0 = -15.4;      %Fonction di�lectrique r�elle non perturb�e / Obtenue par l'experience
Solid.Z_Epsilonim0 =16.25;      %Fonction di�lectrique complexe non perturb�e/ Obtenue par l'experience
Solid.Z_Epsilon0 = 22.39;        %Norme de la fcontion dielectrique non perturb�e
Solid.Z_Eta0 =  1.87;            %Indice de r�fraction complexe non perturb�
Solid.Z_Kappa0 = 4.35;
Solid.Z_Omega0 = 1.31*10^15;      % Fr�quence plasma non perturb�e /s-1
Solid.Z_d = 3.3*10^-8;            % Distance interatomique du Bismuth /m
Solid.Z_na = Solid.Z_d^-3       ;              % Densit� atomique /m-3
Solid.Z_Td = 119;                            % Temp�rature de Debye du Bismuth /K
Solid.Z_Omegad = 1.56*10^13;    % Fr�quence de Debye /s-1
Solid.Z_dabs = Laser.Z_Lambda0/(4*pi*Solid.Z_Kappa0) ; % Distance d'absorbtion du laser /m
Solid.Z_EpsilonF = 5.2;        % Fermi Energy /eV
Solid.Z_EF = Solid.Z_EpsilonF*1.6*10^-19;    % '' / J
Solid.Z_EpsilonB = 0.42;         % Energie de liaison atomique /eV
Solid.Z_EB = Solid.Z_EpsilonB*1.6*10^-19;        % '' /J
Solid.Z_Cl = 122;     % Capacit� calorifique volumique du bismuth /J*m-3*K-1
Solid.Z_Rho = 9870;    %Densit� du bismuth / kg*m-3
Solid.Z_Kappal = 7.9;  %Conductivit� thermique en /J s-1*m-1*K-1
Solid.Z_Ab=0.26; % Absorbtion
Solid.Z_am=3.47*10^-25; % Bismuth atomic mass /kg

% Les temps et longueurs caract�ristiques du syst�me �tant extr�mement
% courts, il est pr�f�rable d'adimensionaliser ce dernier en posant
%   ~x=x/dabs  et  ~t = t/Tlas
% Pour des raisons de simplicit�, nous allons aussi adimensionner les
% unit�s restantes : ~T=T/Tamb
% En posant ~P=P, on obtient que :
% ~m=m * dabs�/Tlas�

%	1.2 Adimentionalisation des coefficents


Univ.HBar =Univ.Z_HBar/Laser.Z_Tlas ;                                  % Constante de Planck r�duite /J*s
Univ.Kb = Univ.Z_Kb*Univ.Z_Tamb; % Boltzmann constant / J*K-1
Univ.Tamb = Univ.Z_Tamb/Univ.Z_Tamb;      % Temperature ambiente /K
Univ.ve = Univ.Z_ve*Laser.Z_Tlas/Solid.Z_dabs  ;   % Vitesse electronique ~ vitesse de Fermi /m*s-1

Laser.Lambda0 = Laser.Z_Lambda0/Solid.Z_dabs     ;        % Longeur d'onde du laser /m
Laser.Tlas = Laser.Z_Tlas/Laser.Z_Tlas; % Dur�e de l'impulsion /s
Laser.Sigma = 1/2;  % Ecart-type de la gaussienne-envellope /s 2
Laser.Elas = Laser.Z_Elas*Laser.Z_Tlas; % Puissance de pic / J/s
Laser.Fl=Laser.Z_Fl; % Fluence

Solid.Epsilonre0 = Solid.Z_Epsilonre0;      %Fonction di�lectrique r�elle non perturb�e / Obtenue par l'experience
Solid.Epsilonim0 =Solid.Z_Epsilonim0;      %Fonction di�lectrique complexe non perturb�e/ Obtenue par l'experience
Solid.Epsilon0 = Solid.Z_Epsilon0;        %Norme de la fcontion dielectrique non perturb�e
Solid.Eta0 =  Solid.Z_Eta0;            %Indice de r�fraction complexe non perturb�
Solid.Kappa0 = Solid.Z_Kappa0;
Solid.Omega0 =Solid.Z_Omega0*Laser.Z_Tlas;      % Fr�quence plasma non perturb�e /s-1
Solid.d = Solid.Z_d/Solid.Z_dabs;            % Distance interatomique du Bismuth /m
Solid.na = Solid.Z_na*(Solid.Z_dabs^3)       ;              % Densit� atomique /m-3
Solid.Td = Solid.Z_Td/Univ.Z_Tamb;                            % Temp�rature de Debye du Bismuth /K
Solid.Omegad = Solid.Z_Omegad*Laser.Z_Tlas;    % Fr�quence de Debye /s-1
Solid.dabs = Solid.Z_dabs/Solid.Z_dabs ; % Distance d'absorbtion du laser /m
Solid.EF = Solid.Z_EF;    % '' / J
Solid.EB = Solid.Z_EB;        % '' /J
Solid.Cl = Solid.Z_Cl*(Solid.Z_dabs^3*Univ.Tamb);     % Capacit� calorifique volumique du bismuth /J*m-3*K-1
Solid.Rho = Solid.Z_Rho*(Solid.Z_dabs^5/Laser.Z_Tlas^2);    %Densit� du bismuth / kg*m-3
Solid.Kappal = Solid.Z_Kappal*(Laser.Z_Tlas*Solid.Z_dabs*Univ.Z_Tamb);  %Conductivit� thermique en /J s-1*m-1*K-1
Solid.Ab=Solid.Z_Ab; % Absorbtion
Solid.am=Solid.Z_am*(Solid.Z_dabs^2/Laser.Z_Tlas^2); % Bismuth atomic mass /kg

% 2. Calcul des temp�ratures pr�sentes dans le mat�riau - Mod�le � deux
% temp�ratures

%   2.0 Pr�sentation du mod�le
%
% Le mod�le est basiquement :

% en posant la matrice suivante :
%    _      _
%   |  Te(t) |
% T=|        |
%   |_ Tl(t)_|
%
% Le probl�me g�n�ral � r�soudre est :
%  _   _                 _  _      _        _     _     _
% | Ce  |    dT     d   |  |   Ke   |    dT  |   |  P+ g |
% |     |.* ---- = ---- |  |        |.* ---- | + |       |
% |_Cl _|    dt     dx  |_ |_  Kl  _|    dx _|   |_  -g _|

%   2.1 Calcul des coefficients n�cessaires � la r�solution du probl�me � 2 Temp�ratures

% Valeurs r�elles :
TTM.Param.Fact_Mul=10^10;
TTM.Param.Ce = TTM.Param.Fact_Mul*(pi^2*Univ.Kb^2)*10/(2*Solid.EF);                          % Capacit� thermique du gaz electronique
TTM.Param.g = TTM.Param.Fact_Mul*(pi^2*Univ.Kb^2*Univ.HBar*Solid.Omegad^2)/(2*Solid.EF^2*Solid.Td^2);        % Terme d'�change entre gaz et mat�riau
TTM.Param.Ke = TTM.Param.Fact_Mul*(Univ.ve^2*pi^2*Univ.Kb^3*Solid.Td^3)/(12*Solid.EB*Solid.Omegad^2*Univ.HBar);    % Conductivit� thermique du gaz
TTM.Param.Cl = TTM.Param.Fact_Mul*Solid.Cl/(Solid.na*Solid.Rho);                                    % Capacit� thermique du mat�riau
TTM.Param.Kl = TTM.Param.Fact_Mul*Solid.Kappal/Solid.na;                                              % Conductivit� thermique du mat�riau (�gale � Kappal en r�alit�)

% % Valeurs de Test :
% Laser.Elas=10000000;
% TTM.Param.Ce= 0.1;
% TTM.Param.g=0.02;
% TTM.Param.Ke=0.001;
% TTM.Param.Cl=1;
% TTM.Param.Kl=0.000000001;

% Les temps et longueurs caract�ristiques du syst�me �tant extr�mement
% courts, il est pr�f�rable d'adimensionaliser ce dernier en posant
%   ~x=x/dabs  et  ~t = t/Tlas
% Pour des raisons de simplicit�, nous allons aussi adimensionner les
% unit�s restantes : ~T=T/Tamb
% En posant ~P=P, on obtient que :
% ~m=m * dabs�/Tlas�

%	2.2 Adimentionalisation des coefficents

% TODO ////

%   2.3 Initialisation du maillage

% On souhaite pouvoir observer pr�cis�ment le ph�nom�ne aux temps courts
% t<10*Tlas, puis relacher la pr�cision au del� :

TTM.t=[linspace(0,9.9,100) linspace(10,60,51)];

% On choisit un pas constant de 0.05dabs sur 5dabs

TTM.x=linspace(0,5,101);

TTM.N_t_temp=size(TTM.t);
TTM.N_x_temp=size(TTM.x);
TTM.N_t=TTM.N_t_temp(2);
TTM.N_x=TTM.N_x_temp(2);

TTM.Te=zeros(TTM.N_x,TTM.N_t);
TTM.Tr=zeros(TTM.N_x,TTM.N_t);

TTM.P=Solid.Ab.*Laser.Elas.*sqrt(1/(2*pi)).*(exp(-TTM.x)'*exp(-((TTM.t-1).^2)/2))';


for t_index=2:TTM.N_t
    
for x=TTM.x(1:TTM.N_x)
    X=TTM.t(1:t_index);
    Y=Solid.Ab.*Laser.Elas.*sqrt(1/(2*pi)).*(exp(-x)'*exp(-((X-1).^2)/2));
    if x==0
        
        TTM.P_Int=trapz(X,Y);
    else
        TTM.P_Int_temp=trapz(X,Y);
        TTM.P_Int=[TTM.P_Int TTM.P_Int_temp];
    end
end
 if t_index==2
 TTM.P_INT=TTM.P_Int;
 else
     TTM.P_INT=[TTM.P_INT; TTM.P_Int];
  TTM.P_INT_2=[zeros(1,101); TTM.P_INT];
 end
end
clear x
clear X
clear Y
%   2.4 Calcul de la solution

TTM.sol=pdepe(0,@TTMfunction,@TTMCondInit,@TTMCondBord,TTM.x,TTM.t,[],TTM.Param,Solid,Laser,Univ);

TTM.Te = TTM.sol(:,:,1);
TTM.Tr = TTM.sol(:,:,2);

%   2.5 Affichage des resultats

% figure
% surfc(TTM.x,TTM.t,TTM.P_INT_2,'EdgeColor','none','LineStyle','none','FaceLighting','phong','FaceColor','interp')
% title('P(x,t)')
% xlabel('Distance x')
% ylabel('Time t')
% colorbar
figure
subplot(2,3,1)
surfc(TTM.x,TTM.t,TTM.Te,'EdgeColor','none','LineStyle','none','FaceLighting','phong','FaceColor','interp')
title('Te(x,t)')
xlabel('Distance x')
ylabel('Time t')
colorbar

subplot(2,3,4)
surfc(TTM.x,TTM.t,TTM.Tr,'EdgeColor','none','LineStyle','none','FaceLighting','phong','FaceColor','interp')
title('Tr(x,t)')
xlabel('Distance x')
ylabel('Time t')
colorbar

% 3 Calcul du nombre de charges excit�es.

%   3.0 M�thode de calcul du nombre de charges excit�es

% Par la suite, on peut calculer l'�volution du nombre de porteurs de
% charge excitees en suivant une �volution en� 2 phases :
% 1 : R�gime excit� par le laser
%                     _
%              2A    |t
%  ne(t)=n_0+ ---- * | I(t) dt
%             D*ls  _|0
% 2 : R�gime de relaxation libre suivant une constante de d�generescence
%    _   _
%   | dne |
%   | --- |    = -K*ne
%   |_dt _|t>t_pulse
%                                      Dne(t)  DTe(t)
% K �tant inconnu, on suppose avoir :  ----- = ------
%                                        ne    Te_max


%   3.1 Calcul de la solution de densit� de charges.

    PE.x=TTM.x;
    PE.t=TTM.t;

    PE.N_x=TTM.N_x;
    PE.N_t=TTM.N_t;
    
    PE.Init=100;
    
    PE.sol=null(1,PE.N_x);
    
% % A faire plus tard //

for t_index=1:PE.N_t
    
    if ( max(TTM.P_INT_2(t_index),[],2) <= 0.95*max(max(TTM.P_INT_2)) )
        % Cela signifie que le laser influe encore
        PE.sol=[PE.sol; PE.Init+2*Solid.Ab*TTM.P_INT_2(t_index,:)];
    else
        % Cela signifie que le laser n'influe plus(Puissance divis�e par
        % 20 ou plus)
        
        PE.sol=[PE.sol; PE.sol(t_index-1,:) + (max(PE.sol(1:t_index-1,:))).*(TTM.Te(t_index,:)-TTM.Te(t_index-1,:))/max(TTM.Te)];
        
    end
end
clear t_index

subplot(2,3,3)
surfc(PE.x,PE.t,PE.sol,'EdgeColor','none','LineStyle','none','FaceLighting','phong','FaceColor','interp')
title('ne(x,t)')
ylabel('Distance x')
xlabel('Time t')
colorbar
 
%   3.2 Affichage du r�sultat



%   4. R�solution de l'�quation du phonon oscillant

% L'objectif suivant est de r�soudre le probl�me d'oscillateur forc� qui
% correspond � l'oscillation des phonons

%Pour r�soudre ce probl�me, on fait appel au solveur d'�quations
%diff�rentielles ode45 (m�thode de Runge Kutta)

PO.x=TTM.x;
PO.tspan=TTM.t;
PO.N_x=size(PO.x);
PO.N_t=size(PO.tspan);

PO.Init=[0; 0];

% Vraies valeurs :
PO.Param.m=2;
PO.Param.nu=0.1;
PO.Param.wo2=1;

% Valeurs test
% PO.Param.m=Solid.am;
% PO.Param.nu=Inconnu ?;
% PO.Param.wo2=Solid.Omega0;


PO.Param.Te=TTM.Te;
%   4.2 On effectue la r�solution de l'�qua diff pour plusieurs valeurs de x
for x=0:0.05:PO.x(PO.N_x(2))
    if x==0
        PO.sol_init = ode45(@POfun,PO.tspan,PO.Init,[],PO.Param,x);
        PO.N_sol=size(PO.sol_init.y(1,:));
        PO.sol_init_size=PO.sol_init.y(1,:);
        while PO.N_sol(2)<PO.N_t(2)+100
                        PO.sol_init_size=[PO.sol_init_size 0];
            PO.N_sol=size(PO.sol_init_size);
        end
        PO.sol=PO.sol_init_size;
    else
        PO.sol_temp = ode45(@POfun,PO.tspan,PO.Init,[],PO.Param,x);
        PO.N_sol=size(PO.sol_temp.y(1,:));
        PO.sol_temp_size=PO.sol_temp.y(1,:);
        while PO.N_sol(2)<PO.N_t(2)+100
            PO.sol_temp_size=[PO.sol_temp_size 0];
            PO.N_sol=size(PO.sol_temp_size);
        end
        PO.sol=[PO.sol; PO.sol_temp_size];
        
    end
    
end
PO.sol_adapt=PO.sol;
PO.sol_adapt(:,PO.N_t(2)+1:PO.N_sol(2))=[];
PO.sol_adapt=PO.sol_adapt';
clear x

%   4.3 Affichage du r�sultat

PO.tspan_2=[PO.tspan, PO.tspan(PO.N_t(2)):PO.tspan(PO.N_t(2))+99];
subplot(2,3,2)
surfc(PO.tspan_2,PO.x,PO.sol,'EdgeColor','none','LineStyle','none','FaceLighting','phong','FaceColor','interp')
title('q(x,t)')
ylabel('Distance x')
xlabel('Time t')
colorbar
% On affiche aux temps courts:
subplot(2,3,5)
PO.tspan_3=PO.tspan(1:101);
PO.sol_tpscourt=PO.sol(:,1:101);
surfc(PO.tspan_3,PO.x,PO.sol_tpscourt,'EdgeColor','none','LineStyle','none','FaceLighting','phong','FaceColor','interp')
title('q(x,t) aux temps courts')
ylabel('Distance x')
xlabel('Time t')
colorbar

%  5. Obtention du r�sultat final

EP.x=TTM.x;
EP.t=TTM.t;

EP.Param.Kb=1 ;% Valeurs test
EP.Param.EB=10;
EP.Param.wo=1;

EP.Param.e=1;
EP.Param.me=1;

EP.Param.na=1;
EP.Param.Td=100;
EP.Param.ve=1;

EP.w=(1-(TTM.Te.*EP.Param.Kb)./EP.Param.EB).*EP.Param.wo;
EP.wp=sqrt(4*pi*EP.Param.e/EP.Param.me).*sqrt(PE.sol);
EP.ve_ph=(EP.Param.na*EP.Param.ve/EP.Param.Td).*TTM.Tr.*((PO.sol_adapt).^2);


EP.Re=(1-((EP.wp).^2)./((EP.w).^2+(EP.ve_ph).^2));
EP.Im=(1-((EP.wp).^2)./((EP.w).^2+(EP.ve_ph).^2)).*((EP.ve_ph)./(EP.w));

%  6. Comparaison mod�le exp�rience


