clear; close all
%% Read data: %%
[NACA_Data_1_1, nodes_NACA_1_1] = read_data('NACA0015'); % 0015
[NACA_Data_1_2, nodes_NACA_1_2] = read_data('NACA0015'); % 0015

%% Geometry & initialization: %%
Q_mod = 1;
alphas = [0 2 4 6 8];
deltas = [0 4 8 12 16];
txtN = [1 2 3 4 5]; % 1=32, 2=64, 3=128, 4=256, 5=512
geometry = 'read';
plotGeometry = false;
D = 0;

%For part 1
c = 1;

%For part 2
d = 0.02;
c1 = 0.63;
c2 = 0.35;
%For part 3
iw = 0;
it = -2;
Sv = 2.4;
lv = 1;
lh = 7.5;
b = 24;
bh = 5.6;
crw = 1.8;
crh = 1;
ctw = 1.2;
cth = 0.6;
cdw = @(cl) 0.008*cl^2 - 0.0013*cl + 0.0063;
cdth = @(cl) 0.0052*cl^2 + 0.0071*cl;
cdtv = @(cl) 0.0062;

cp_all = cell(1, length(txtN));  % Per cp
Cl_all = cell(1, length(txtN));  % Per Cl
Cm_all = cell(1, length(txtN));  % Per Cm

cp1_all = cell(1, length(txtN));  % Per cp
Cl1_all = cell(1, length(txtN));  % Para Cl
Cm1_all = cell(1, length(txtN));  % Para Cm

cp2_all = cell(1, length(txtN));  % Per cp
Cl2_all = cell(1, length(txtN));  % Per Cl
Cm2_all = cell(1, length(txtN));  % Per Cm


%% Called functions: %%
%---------------------------------Part 1:---------------------------------
for k = 1:1:length(txtN)
    [cp, Cl, Cm] = computePart1_1(NACA_Data_1_1, nodes_NACA_1_1, alphas, Q_mod, c, txtN, D,...
    geometry, plotGeometry,k);

    % Guardar els resultats en les cel·les
    cp_all{k} = cp;
    Cl_all{k} = Cl;
    Cm_all{k} = Cm;
  %{
    [cp1, Cl1, Cm1, cp2, Cl2, Cm2] = computePart1_2(NACA_Data_1_2, nodes_NACA_1_2, alphas, ...
    Q_mod, c1, c2, txtN, D, geometry, plotGeometry, d, deltas, k);

    cp1_all{k} = cp1;
    Cl1_all{k} = Cl1;
    Cm1_all{k} = Cm1;

    cp2_all{k} = cp2;
    Cl2_all{k} = Cl2;
    Cm2_all{k} = Cm2;
  %}
end

%---------------------------------Part 2 (Prandtl):---------------------------------
alpha = deg2rad(4);
alphas(:) = deg2rad(alphas(:));
delta = deg2rad(0);
theta = [0 0];
Q_inf = Q_mod*[cos(alpha),0,sin(alpha)];
Cl_Wairfoil = Cl_all{end};
Nhs = 64;
%Cl_Tairfoil = 
[CLw, Clw, alpha_indw, CD_indiw, CD_indw, CD_viw, CD_viscw, CDw, cp_coords] = ...
    computePart2_1(Cl_Wairfoil, Nhs,b, 0, 0, Q_inf, theta, iw, alpha, alphas, crw, ctw, cdw);


[CLw, CLt, Clw, Clt, alpha_indw, alpha_indt, CD_indiw, CD_indw, CD_indit, ...
    CD_indt, CD_viw, CD_viscw, CD_vit, CD_visct, CDw, CDt] = ...
    computePart2(Cl_Wairfoil, Cl_Tairfoil,  Nhs,b, bh, lv, lh , Q_inf, theta,...
    iw, it, alpha, crw, ctw, crt, ctt, Cdt, cdw);
