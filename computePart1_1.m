function [cp, Cl, Cm, M_crit] = computePart1_1(NACA_Data, nodes_NACA, alphas, Q_mod,c, txtN, D,geometry, plotGeometry, k)

Laitone = @(Cp0, M_inf) Cp0 / (sqrt(1 - M_inf^2) + (Cp0 / 2) * (M_inf^2 / sqrt(1 - M_inf^2)) * ...
        (1 + (1.4 - 1) *0.5* M_inf^2));
Cp_star = @(M_inf) (2 / (1.4 * M_inf^2)) * (((2 + (1.4 - 1) * M_inf^2) / (1 + 1.4))^(1.4 / (1.4 - 1)) - 1);

N_W = nodes_NACA(txtN(k));
[distance, xnWing, znWing, xcWing, zcWing, ljWing, normalsWing, tangentsWing] = discretize_geometry(D, N_W,NACA_Data,geometry,plotGeometry, txtN(k),c);

kuttaChange = floor(N_W/4); %33

cp  = zeros(length(alphas),N_W-1);
Cl  = zeros(length(alphas),1);
Cm  = zeros(length(alphas),1);

for i = 1:1:length(alphas)
    alpha = alphas(i);
    Q_inf = Q_mod.*[cos(deg2rad(alpha)) sin(deg2rad(alpha))];
    [~,~,~,~,gammas] = applyVortexMethod(Q_inf, normalsWing, tangentsWing,N_W, xcWing, zcWing, xnWing,znWing, ljWing, kuttaChange,0);
    cp(i,:) = computeCP(gammas, Q_inf);
    Cl(i) = computeCl(gammas, ljWing,Q_inf,c);
    Cm(i) = computeCm(cp(i,:), xcWing, zcWing,xnWing, znWing, c);                      
end

fprintf('Cl for NACA22112 at AoAs of: ')
fprintf('\n')
fprintf('%.4f ',Cl');
fprintf('\n')

fprintf('Cm for NACA22112 at AoAs of: ')
fprintf('\n')
fprintf('%.4f ',Cm');
fprintf('\n')

%postprocess_part_1_1(xcWing, cp, distance, gammas,xnWing, znWing, xcWing, zcWing, normalsWing, alphas) % Plots.

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

fprintf('AoAs for NACA22112 at M_crit of: ');
fprintf('\n');
fprintf('%.2f ', alphas_crit); % Imprime cada valor de alphas_crit en una sola línea
fprintf('\n');
fprintf('Corresponding M_crit values: ');
fprintf('\n')
fprintf('%.4f ', M_crit); % Imprime cada valor de M_crit con 4 decimales
fprintf('\n');

s = [0.15, 0.1, 0.05, 0];
Cl_compressible = zeros(length(s),1);

for i = 1:1:length(s)
    beta = sqrt(1-(M_crit(2)-s(i))^2);
    Cl_compressible(i) = Cl(2)*(1/beta);
end

fprintf('Cl compressible for NACA22112 at AoA 2 for Machs: ')
fprintf('\n');
fprintf('%.4f ', Cl_compressible);
M_Cl_compresible = M_crit(2)-s;


end