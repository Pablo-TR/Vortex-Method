clear; close all

%% Geometry & initialization: %%
D = 2;
N = 128;
Q_inf = [1,0];
kuttaChange = ceil(N / 4);
geometry = 'given';

%% Called functions: %%
[beta, x_nod, z_nod, x_c_glob, z_c_glob, l_j, normals, tangents] = discretize_geometry(D, N,'NACA0015');
[a,b, ~] = precompute_terms(normals, tangents, N, Q_inf, x_c_glob, z_c_glob, x_nod,z_nod, l_j);
[a,b] = applyKuttaCondition(kuttaChange, a, b);
gammas = solveVortexStrength(a,b, kuttaChange);
[V] = computeV(gammas, N, tangents);
cp = computeCP(gammas, Q_inf, N);

%% Plots: %%

figure;
plot(x_c_glob, z_c_glob, '-o');
%hold on
axis equal
grid on
ylim([-1 1])
%plot(x_nod, z_nod, '-o');

% Plot velocity versus theta:
figure;
plot(rad2deg(beta(1:end-1)), V(:,1))
hold on
grid on
xlim([0 360])
plot(rad2deg(beta(1:end-1)), V(:,2))
title('Distribution of velocity','FontSize',18,'Interpreter','latex')
xlabel('$\theta$ [$^\circ$]','FontSize',16,'Interpreter','latex')
ylabel('$V_x$ and $V_z$ [m/s]','FontSize',16,'Interpreter','latex')

% Plot cp versus theta:
figure;
plot(rad2deg(beta(1:end-1)), cp(1,:))
hold on
grid on
xlim([0 360])
ylim([-3 1])
title('Distribution of pressure coefficient','FontSize',18,'Interpreter','latex')
xlabel('$\theta$ [$^\circ$]','FontSize',16,'Interpreter','latex')
ylabel('$C_p$ [-]','FontSize',16,'Interpreter','latex')

% Plot gamma versus theta:
figure;
plot(rad2deg(beta(1:end-1)), gammas(:,1))
hold on
grid on
xlim([0 360])
title('Distribution of $\gamma$','FontSize',18,'Interpreter','latex')
xlabel('$\theta$ [$^\circ$]','FontSize',16,'Interpreter','latex')
ylabel('$\gamma$ [-]','FontSize',16,'Interpreter','latex')


