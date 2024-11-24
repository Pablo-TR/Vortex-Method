function [cp, Cl, Cm] = computePart1(NACA_Data,nodes_NACA, alphas, Q_mod,c, txtN, D,geometry, plotGeometry)

Laitone = @(Cp0, M_inf) Cp0 / (sqrt(1 - M_inf^2) + (Cp0 / 2) * (M_inf^2 / sqrt(1 - M_inf^2)) * ...
        (1 + (1.4 - 1) *0.5* M_inf^2));
Cp_star = @(M_inf) (2 / (1.4 * M_inf^2)) * (((2 + (1.4 - 1) * M_inf^2) / (1 + 1.4))^(1.4 / (1.4 - 1)) - 1);

N_W = nodes_NACA(txtN);
[~, xnWing, znWing, xcWing, zcWing, ljWing, normalsWing, tangentsWing] = discretize_geometry(D, N_W,NACA_Data,geometry,plotGeometry, txtN,c);

kuttaChange = 33;


cp  = zeros(length(alphas),N_W-1);
Cl  = zeros(length(alphas),1);
Cm  = zeros(length(alphas),1);

for i = 1:1:length(alphas)
    alpha = alphas(i);
    Q_inf = Q_mod.*[cos(deg2rad(alpha)) sin(deg2rad(alpha))];
    [Ak,Bk,A,b,gammas] = applyVortexMethod(Q_inf, normalsWing, tangentsWing,N_W, xcWing, zcWing, xnWing,znWing, ljWing, kuttaChange,0);
    cp(i,:) = computeCP(gammas, Q_inf);
    Cl(i) = computeCl(gammas, ljWing,Q_inf,c);
    Cm(i) = computeCm(cp(i,:), xcWing, zcWing,xnWing, znWing, c);
end

fprintf('Cl for NACA22112 at AoAs of: ')
alphas
fprintf('\n')
Cl'

fprintf('Cm for NACA22112 at AoAs of: ')
alphas
fprintf('\n')
Cm'

alphas_crit = [0 2 4];
M_crit = zeros(length(alphas_crit), 1);

%Bolzano for Laitone's M_crit equation
f = @(Cp0, M_crit) Cp_star(M_crit)-Laitone(Cp0,M_crit);
for i = 1:1:length(alphas_crit)
    M_a = 0.1;
    M_b = 0.99;
    M_c = 0.5*(M_a+M_b);
    Cp0 = min(cp(i,:));
    while abs(f(Cp0, M_c)) > 0.00000001
        M_c = (M_b+M_a)*0.5;
        if f(Cp0, M_c)*f(Cp0,M_a)<0
            M_b = M_c;
        else
            M_a = M_c;
        end
    end
    M_crit(i) = M_c;
end

fprintf('M_crit for NACA22112 at AoAs of: ')
alphas_crit
fprintf('\n')
M_crit

s = [0.15, 0.1, 0.05, 0];
Cl_compressible = zeros(length(s),1);

for i = 1:1:length(s)
    beta = sqrt(1-(M_crit(2)-s(i))^2);
    Cl_compressible(i) = Cl(2)*(1/beta);
end

fprintf('Cl compressible for NACA22112 at AoA 2 for Machs: ')
M_Cl_compresible = M_crit(2)-s
fprintf('\n')
Cl_compressible
end