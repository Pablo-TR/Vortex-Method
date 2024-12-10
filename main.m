clear; close all
%% Read data: %%
[NACA_Data_1_1, nodes_NACA_1_1] = read_data('NACA22112'); % 0015
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
iw = deg2rad(0);
it = deg2rad(-2);
Sv = 2.4;
lv = 1;
lh = 7.5;
b = 24;
bh = 5.6;
crw = 1.8;
crh = 1;
ctw = 1.2;
cth = 0.6;
cdw = @(cl) 0.008*cl^2+0.0063 -0.0013*cl ;
cdth = @(cl) 0.0052*cl^2 + 0.0071;
cdtv = 0.0062;
Sw = b*(crw+ctw)/2;

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
%postprocessConvergence1(M_crit_all, alphas, txtN, Cl_all, Cm_all)
%postprocessConvergence1(M_crit_all, alphas, txtN, Cl1_all, Cm1_all)
%postprocessConvergence1(M_crit_all, alphas, txtN, Cl2_all, Cm2_all)

%---------------------------------Part 2 (Prandtl):---------------------------------

Nhs = 512;
alpha = deg2rad(4);
Q_inf = Q_mod*[cos(alpha),0,sin(alpha)];
thetat = [deg2rad(0) deg2rad(0)]; % thetat SHOULD NOT BE CHANGED

alphasR = deg2rad(alphas(:));
Cl_law = Cl_all{end};
Cl_law = fit(alphasR, Cl_law, 'poly1');

Cl_alpha_w =Cl_law.p1;
Cl0_w = Cl_law.p2;

Cl_law = Cl1_all{end};
Cl_law = fit(alphasR, Cl_law, 'poly1');

Cl_alpha_t = Cl_law.p1;
Cl0_t = 0;Cl_law.p2;

Cm25w = Cm_all{end}(3);
Cm25t = Cm1_all{end}(3);

%%
%1. Select and justify an adequate wing twist, and plot the spanwise distribution of the
%local coefficients of lift (Clw), viscous drag (CD_viscw), induced drag (CD_indw)
% and induced angle of attack (alpha_indw).
alpha = deg2rad(4);
CL_CD = [];
twists = [-0.9];
Clw_all = cell(1, length(twists));
CDviw_all = cell(1, length(twists));
CDindiw_all = cell(1, length(twists));
alphaIndw_all = cell(1, length(twists));

for i = 1:1:length(twists)
    theta = twists(i);
    thetaw = [deg2rad(0) deg2rad(theta)]; % Leave first value at 0
[CLw, Clw, alpha_indw, CD_indiw, CD_ind, CD_viw, CD_v, CDw, cp_coords_w] = ...
    computeSingleWing(Cl_alpha_w, Cl0_w, Nhs,b, 0, 0, Q_inf, thetaw, iw, alpha, crw, ctw, cdw);
Clw_all{i} = Clw;
CL_CD(i) = CLw/CDw;
CDviw_all{i} = CD_viw;
CDindiw_all{i} = CD_indiw;
alphaIndw_all{i} = alpha_indw;
end
postprocess_part_2_1(alphaIndw_all,CL_CD,CDindiw_all, CDviw_all, Clw_all, cp_coords_w(:,2), twists)



alphas(:) = deg2rad(alphas(:));
%%
%2. For an angle of attack of 4° (measured at the wing central section), and zero
%elevator deflection, plot the spanwise distribution of aerodynamic coefficients,
%and for both the wing and HTP, and determine the required location of the center
%of mass CM to attain balance of pitching moments.

%Cl_law = Cl1_all{end};
%Cl_law = fit(alphas', Cl_law, 'poly1');

theta = -0.9; % PUT THE VALUE FROM 1 HERE
alpha = deg2rad(4);
lambda = ctw/crw;
MAC = (2/3) * crw * ((1+lambda+lambda^2)/(1+lambda));

[CLw, CLt, Clw, Clt, Cm0w, Cm0t, alpha_indw, alpha_indt, CD_indiw, CD_indw, CD_indit, ...
    CD_indt, CD_viw, CD_viscw, CD_vit, CD_visct, CDw, CDt, Cm0, CL, CD, cp_coords_t] = ...
    computeSystem(Cl_alpha_w, Cl0_w, Cl_alpha_t, Cl0_t,  Nhs,b, bh, lv, lh , Q_inf, thetaw,thetat,...
    iw, it, alpha, crw, ctw, crh, cth, cdth, cdw, Sv, cdtv, Cm25w ,Cm25t);
[cg] = postprocess_part_2_2(Clw, Clt, CD_indiw, CD_indit, CD_viw, CD_vit, cp_coords_w(:,2), cp_coords_t(:,2), b, bh, CL, Cm0, MAC, Sw, Q_mod);



%%
%3. For a range of angles of attack 0°- 6°, and zero elevator deflection, plot the
% aerodynamic polar curve (CL vs CD).

CL_values = zeros(1, length(alphas) - 1); % Array per emmagatzemar CL
CD_values = zeros(1, length(alphas) - 1); % Array per emmagatzemar CD


for i = 1:1:length(alphas)-1
    alpha = alphas(i);
    [~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, CL, CD, ~] = ...
        computeSystem(Cl_alpha_w, Cl0_w, Cl_alpha_t, Cl0_t,  Nhs,b, bh, lv, lh , Q_inf, thetaw,thetat,...
    iw, it, alpha, crw, ctw, crh, cth, cdth, cdw, Sv, cdtv, Cm25w ,Cm25t);
    CL_values(i) = CL;
    CD_values(i) = CD;
end

[CL_fine, CD_fine] = postprocess_Part2_Polar(CL_values,CD_values);

%%
%4. Compute the global lift coefficient and pitching moment coefficient about the CM
%when alpha = 4° the elevator deflection is d= 12°.
alphas = [0,2,4,6,8];
deltas = [12];
fixDeltaTo0 = 0;
 [~, Cld, ~, ~, Cl2, Cm2] = computePart1_2(NACA_Data_1_2, nodes_NACA_1_2, alphas, ...
    Q_mod, c1, c2, txtN, D, geometry, plotGeometry, d, deltas, k, fixDeltaTo0);

alpha = deg2rad(4);
alphas = deg2rad(alphas(:));
Cl_law = fit(alphas, Cld, 'poly1');
Cl_alpha_t= Cl_law.p1;
Cl0_t = Cl_law.p2;
Cm25t = Cm2_all{end}(end);

[~, ~, ~, ~, ~, ~, ~, ~, ~, ...
    ~, ~, ~, ~, ~, ~, ~, Cm, CL, CD] = ...
    computeSystem(Cl_alpha_w, Cl0_w, Cl_alpha_t, Cl0_t,  Nhs,b, bh, lv, lh , Q_inf, thetaw,thetat,...
    iw, it, alpha, crw, ctw, crh, cth, cdth, cdw, Sv, cdtv, Cm25w ,Cm25t);
%Cm is referred to the Origin, not the center of mass
Cm_cg = CL*cg/MAC + Cm;