clear; close all
%% Read data: %%
[NACA_Data_1_1, nodes_NACA_1_1] = read_data('NACA0015');
[NACA_Data_1_2, nodes_NACA_1_2] = read_data('NACA0015');

%% Geometry & initialization: %%
Q_mod = 1;
alphas = [0 2 4 6 8];
%alphas = 5;
geometry = 'read';
plotGeometry = true;
D = 0;

%For part 1
c = 1;

%For part 2
d = 0.02;
c1 = 0.63;
c2 = 0.35;
deltas = [0 4 8 12 16];
txtN = 2;
%For part 3
lv = 1;
lh = 7.5;

%% Called functions: %%
%---------------------------------Part 1:---------------------------------
computePart1_1(NACA_Data_1_1, nodes_NACA_1_1, alphas, Q_mod, c, txtN, D, geometry, plotGeometry);
computePart1_2(NACA_Data_1_2, nodes_NACA_1_2, alphas, Q_mod, c1, c2, txtN, D, geometry, plotGeometry, d, deltas);

%---------------------------------Part 2 (Prandtl):---------------------------------
%computePart2()
