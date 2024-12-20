clear; close all
%% Read data: %%
[NACA_Data_1_1, nodes_NACA_1_1] = read_data('NACA22112'); % 0015
[NACA_Data_1_2, nodes_NACA_1_2] = read_data('NACA0015'); % 0015

%% Geometry & initialization: %%
Q_mod = 10;
alphas = [0 2 4 6 8];
deltas = [0 4 8 12 16];
txtN = [1]; % 1=32, 2=64, 3=128, 4=256, 5=512
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
iw = deg2rad(0);
it = deg2rad(2);
Sv = 2.4;
lv = 0;
lh = 6;
b = 12;
bh = 4.8;
crw = 1.8;
crh = 0.9;
ctw = 1.2;
cth = 0.6;
cdth = @(cl) 0.0075+0.0055*cl^2 ;%0.008*cl^2 - 0.0013*cl + 0.0063;
cdw = @(cl) 0.0063 + 0.0067*cl^2 -0.0033*cl;%0.0052*cl^2 + 0.0071*cl;
cdtv = 0.0062;

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
    
    fixDeltaTo0 = 1; % Works fine don't get confused by the name
    [cp1, Cl1, Cm1, cp2, Cl2, Cm2] = computePart1_2(NACA_Data_1_2, nodes_NACA_1_2, alphas, ...
    Q_mod, c1, c2, txtN, D, geometry, plotGeometry, d, deltas, k, fixDeltaTo0);

    cp1_all{k} = cp1;
    Cl1_all{k} = Cl1;
    Cm1_all{k} = Cm1;

    cp2_all{k} = cp2;
    Cl2_all{k} = Cl2;
    Cm2_all{k} = Cm2;

end

%---------------------------------Part 2 (Prandtl):---------------------------------

Nhs = 256;
alpha = deg2rad(4);
Q_inf = Q_mod*[cos(alpha),0,sin(alpha)];
thetat = [deg2rad(0) deg2rad(0)]; % thetat SHOULD NOT BE CHANGED


%Cl_law = Cl_all{end};
%Cl_law = fit(alphas', Cl_law, 'poly1');

Cl_alpha_t = 6.6878;%Cl_law.p1;
Cl0_t = 0.0023;%Cl_law.p2;

Cl_alpha_w = 6.7743;%Cl_law.p1;
Cl0_w = 0.2624;%Cl_law.p2;

Cm25w = -0.0653;
Cm25t = -0.0082;

%%
%1. Select and justify an adequate wing twist, and plot the spanwise distribution of the
%local coefficients of lift (Clw), viscous drag (CD_viscw), induced drag (CD_indw)
% and induced angle of attack (alpha_indw).
alpha = deg2rad(4);
twists = [-3.5];
for i = 1:1:length(twists)
    theta = twists(i);
    thetaw = [deg2rad(0) deg2rad(theta)]; % Leave first value at 0

[~, Clw, alpha_indw, CD_indiw, ~, CD_viw, ~, ~, cp_coords] = ...
    computeSingleWing(Cl_alpha_w, Cl0_w, Nhs,b, lv, lh, Q_inf, thetaw, iw, alpha, crw, ctw, cdw);
end

alphas(:) = deg2rad(alphas(:));
%%
%2. For an angle of attack of 4° (measured at the wing central section), and zero
%elevator deflection, plot the spanwise distribution of aerodynamic coefficients,
%and for both the wing and HTP, and determine the required location of the center
%of mass CM to attain balance of pitching moments.

%Cl_law = Cl1_all{end};
%Cl_law = fit(alphas', Cl_law, 'poly1');

theta = 0; % PUT THE VALUE FROM 1 HERE
alpha = deg2rad(4);

[CLw, CLt, Clw, Clt, Cm0w, Cm0t, alpha_indw, alpha_indt, CD_indiw, CD_indw, CD_indit, ...
    CD_indt, CD_viw, CD_viscw, CD_vit, CD_visct, CDw, CDt, Cm, CL, CD] = ...
    computeSystem(Cl_alpha_w, Cl0_w, Cl_alpha_t, Cl0_t,  Nhs,b, bh, lv, lh , Q_inf, thetaw,thetat,...
    iw, it, alpha, crw, ctw, crh, cth, cdth, cdw, Sv, cdtv, Cm25w ,Cm25t);
%%
%3. For a range of angles of attack 0°- 6°, and zero elevator deflection, plot the
% aerodynamic polar curve (CL vs CD).

for i = 1:1:length(alphas)-1
    alpha = alphas(i);
    [CLw, CLt, Clw, Clt, Cm0w, Cm0t, alpha_indw, alpha_indt, CD_indiw, CD_indw, CD_indit, ...
    CD_indt, CD_viw, CD_viscw, CD_vit, CD_visct, CDw, CDt, Cm, CL, CD] = ...
    computeSystem(Cl_alpha_w, Cl0_w, Cl_alpha_t, Cl0_t,  Nhs,b, bh, lv, lh,...
    Q_inf, thetaw,thetat, iw, it, alpha, crw, ctw, crh, cth, cdth, cdw, Sv,...
    cdtv, Cm25w ,Cm25t);    
end
%%
%4. Compute the global lift coefficient and pitching moment coefficient about the CM
%when alpha = 4° the elevator deflection is d= 12°.
alphas = [0,2,4,6,8];
delta = 12;
fixDeltaTo0 = 0;
 [~, ~, ~, ~, Cl2, Cm2] = computePart1_2(NACA_Data_1_2, nodes_NACA_1_2, alphas, ...
    Q_mod, c1, c2, txtN, D, geometry, plotGeometry, d, deltas, k, fixDeltaTo0);

alpha = deg2rad(4);
alphas = deg2rad(alphas(:));
Cl_law = fit(alphas', Cl_law, 'poly1');
Cl_alpha_t= Cl_law.p1;
Cl0_t = Cl_law.p2;

[~, ~, ~, ~, ~, ~, ~, ~, ~, ...
    ~, ~, ~, ~, ~, ~, ~, Cm, CL, CD] = ...
    computeSystem(Cl_alpha_w, Cl0_w, Cl_alpha_t, Cl0_t,  Nhs,b, bh, lv, lh , Q_inf, theta,...
    iw, it, alpha, crw, ctw, crh, cth, cdth, cdw);
%Cm is referred to the Origin, not the center of mass