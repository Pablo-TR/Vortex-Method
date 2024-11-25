clear; close all
%% Read data: %%

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
txtN = 2;
%For part 3
lv = 1;
lh = 7.5;

%% Called functions: %%

[NACA_Data, nodes_NACA] = read_data('NACA0015');


%computePart1(NACA_Data,nodes_NACA, alphas, Q_mod,c,txtN,D, geometry, plotGeometry)

[NACA_Data, nodes_NACA] = read_data('NACA0015');
computePart2(NACA_Data,nodes_NACA, alphas, Q_mod,c1,c2, txtN, D,geometry, plotGeometry,d, deltas)






%% Plots: %%



% figure;
% grid on
% xlim([0 1])
% plot(xcWing, V)
% title('Distribution of velocity','FontSize',18,'Interpreter','latex')
% xlabel('$\theta$ [$^\circ$]','FontSize',16,'Interpreter','latex')
% ylabel('$V_x$ and $V_z$ [m/s]','FontSize',16,'Interpreter','latex')
% hold off
% Plot cp versus theta:
figure;
plot(xcWing, cp)
hold on
grid on
xlim([0 1])
%ylim([-3 1])
title('Distribution of pressure coefficient','FontSize',18,'Interpreter','latex')
xlabel('$\theta$ [$^\circ$]','FontSize',16,'Interpreter','latex')
ylabel('$C_p$ [-]','FontSize',16,'Interpreter','latex')

% Plot gamma versus theta:
figure;
plot(distance(1:end-1), gammas(:,1))
hold on
grid on
xlim([0 1])
title('Distribution of $\gamma$','FontSize',18,'Interpreter','latex')
xlabel('$\theta$ [$^\circ$]','FontSize',16,'Interpreter','latex')
ylabel('$\gamma$ [-]','FontSize',16,'Interpreter','latex')



