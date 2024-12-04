clear; close all
%% Read data: %%
[NACA_Data_1_1, nodes_NACA_1_1] = read_data('NACA0015'); % 0015
[NACA_Data_1_2, nodes_NACA_1_2] = read_data('NACA0015'); % 0015

%% Geometry & initialization: %%
Q_mod = 1;
alphas = [0 2 4 6 8];
%alphas = 5;
geometry = 'read';
plotGeometry = false;
D = 0;

%For part 1
c = 1;

%For part 2
d = 0.02;
c1 = 0.63;
c2 = 0.35;
deltas = [0 4 8 12 16];
txtN = [1 2 3 4 5]; % 1=32, 2=64, 3=128, 4=256, 5=512
%For part 3
lv = 1;
lh = 7.5;
cp_all = cell(1, length(txtN));  % Per cp
Cl_all = cell(1, length(txtN));  % Per Cl
Cm_all = cell(1, length(txtN));  % Per Cm
M_crit_all = cell(1, length(txtN));  % Per M_crit

cp1_all = cell(1, length(txtN));  % Per cp
Cl1_all = cell(1, length(txtN));  % Para Cl
Cm1_all = cell(1, length(txtN));  % Para Cm

cp2_all = cell(1, length(txtN));  % Per cp
Cl2_all = cell(1, length(txtN));  % Per Cl
Cm2_all = cell(1, length(txtN));  % Per Cm



%% Called functions: %%
%---------------------------------Part 1:---------------------------------
for k = 1:1:length(txtN)
    [cp, Cl, Cm, M_crit] = computePart1_1(NACA_Data_1_1, nodes_NACA_1_1, alphas, Q_mod, c, txtN, D,...
    geometry, plotGeometry,k);

    % Guardar els resultats en les cel·les
    cp_all{k} = cp;
    Cl_all{k} = Cl;
    Cm_all{k} = Cm;
    M_crit_all{k} = M_crit;
  
    
    [cp1, Cl1, Cm1, cp2, Cl2, Cm2] = computePart1_2(NACA_Data_1_2, nodes_NACA_1_2, alphas, ...
    Q_mod, c1, c2, txtN, D, geometry, plotGeometry, d, deltas, k);

    cp1_all{k} = cp1;
    Cl1_all{k} = Cl1;
    Cm1_all{k} = Cm1;

    cp2_all{k} = cp2;
    Cl2_all{k} = Cl2;
    Cm2_all{k} = Cm2;
    
end

postprocessConvergence1(M_crit_all, alphas, txtN, Cl_all, Cm_all)
postprocessConvergence1(M_crit_all, alphas, txtN, Cl1_all, Cm1_all)
postprocessConvergence1(M_crit_all, alphas, txtN, Cl2_all, Cm2_all)



%---------------------------------Part 2 (Prandtl):---------------------------------
%computePart2()
