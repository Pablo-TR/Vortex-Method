clear all
ws= 12;
cr = 1.8;
ct = 1.2;

Cl0_w = 0.2624;
Cl_alpha_w = 6.7743;
alpha = 4;
alpha = deg2rad(alpha);
N = 256;
iw = 0;
cd = @(cl) 0.0052*cl^2 + 0.0071*cl;
Q_inf = [1 0 0];
theta = [0 deg2rad(-3.5)];
Sw = computeSurface(cr, ct, ws);

[cp_coords_w, HS_coords_w]= discretizeHorseshoe(ws, N, 0, 0);

thetaw = computeSectionTheta(cp_coords_w, theta(1), theta(2), ws);

cw = computeSectionChord(cp_coords_w, cr, ct, ws);
OutOfFoil = 0;
[A, b] = computeLL(cp_coords_w, HS_coords_w, alpha, Q_inf, Cl0_w, Cl_alpha_w, thetaw, cw, iw, OutOfFoil); 

gammas = A\b';

CLw = compute3DLift(gammas, Q_inf, Sw, HS_coords_w);

[alpha_ind_w, Clw] = computeInducedAlpha(gammas, Q_inf, cw, Cl0_w, thetaw, alpha, iw, Cl_alpha_w);

[CD_indiw, CD_indw] = computeInducedDrag(gammas, HS_coords_w, alpha_ind_w, Q_inf, Sw, Clw);

close all
figure()
plot(cp_coords_w(:,2)/(ws/2),CD_indiw)
figure()
plot(cp_coords_w(:,2)/(ws/2),Clw)
ylim([-0.1, 0.7])
grid minor

figure()
plot(cp_coords_w(:,2)/(ws/2),gammas)
ylim([0, 0.09])
grid minor

figure()
plot(cp_coords_w(:,2)/(ws/2),alpha_ind_w)
grid minor
%[CD_viw, CD_viscw] = computeViscousDrag(Cd, Clw, HS_coords_w, cw, Sw);

%CDw = CD_viscw + CD_indw;




%[cp_coords, HS_coords] = discretizeHorseshoe(ws, N, 0, 0);
%c = computeSectionChord(cp_coords,cr,ct,ws);
%theta = computeSectionTheta(cp_coords, 0, 0, ws);
%[A, b] = computeLL(cp_coords, HS_coords, alpha, Q_inf,Cl0, cl_alpha, theta, c, iw);
%gammas = A\b';
%S = 2*((cr+ct)/2)*(ws/2);
%CL3D = compute3DLift(gammas, Q_inf, S, HS_coords);
%alpha_ind = computeInducedAlpha(gammas, Q_inf,c, Cl0_w, theta, alpha, iw, Cl_alpha_w);
[CDi, CDI] = computeInducedDrag(gammas, HS_coords_w, alpha_ind_w, Q_inf,Sw);




%cl_alpha = 6.3062 rad^-1
%cl0 = 0.0813
