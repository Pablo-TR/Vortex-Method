clear; close all
%% Read data: %%
[NACA_Data, nodes_NACA] = read_data('NACA22112');

%% Geometry & initialization: %%
D = 2;
N = 0; %128 cylinder; nodes_NACA(3)
Q_inf = [1,0];
kuttaChange = ceil(N / 4);
lv = 1;
lh = 7.5;
d = 0.02;
geometry = 'read';
plotGeometry = true;


%% Called functions: %%
[NACA_Data, nodes_NACA] = read_data('NACA0015');
N_W = nodes_NACA(3);
[dWing, xnWing, znWing, xcWing, zcWing, ljWing, normalsWing, tangentsWing] = discretize_geometry(D, N_W,NACA_Data,geometry,plotGeometry);

 
[NACA_Data, nodes_NACA] = read_data('NACA22112');
N_HTP = nodes_NACA(3);
[dHTP, xnHTP, znHTP, xcHTP, zcHTP, ljHTP, normalsHTP, tangentsHTP] = discretize_geometry(D, N_HTP,NACA_Data,geometry,plotGeometry);

figure;
plot(xnWing,znWing);
hold on
plot(xnHTP+lh, znHTP+lv)

[A11,b11, ~] = precompute_terms(normalsWing, tangentsWing, N_W, Q_inf, xcWing, zcWing, xnWing,znWing, ljWing);
[A12,b12, ~] = precompute_terms(normalsWing, tangentsWing, N_W, Q_inf, xcHTP, zcHTP, xnWing,znWing, ljWing);
[A21,b21, ~] = precompute_terms(normalsHTP, tangentsHTP, N_HTP, Q_inf, xcWing, zcWing, xnHTP,znHTP, ljHTP);
[A22,b22, ~] = precompute_terms(normalsHTP, tangentsHTP, N_HTP, Q_inf, xcHTP, zcHTP, xnHTP,znHTP, ljHTP);

[a,b] = applyKuttaCondition(kuttaChange, a, b);
gammas = solveVortexStrength(a,b, kuttaChange);
[V] = computeV(gammas, N, tangents);
cp = computeCP(gammas, Q_inf, N);

%% Plots: %%


%hold on
%ylim([-1 1])
%plot(x_nod, z_nod, '-o');

% Plot velocity versus theta:
figure;
plot(distance(1:end-1), V(:,1))
hold on
grid on
xlim([0 1])
plot(distance(1:end-1), V(:,2))
title('Distribution of velocity','FontSize',18,'Interpreter','latex')
xlabel('$\theta$ [$^\circ$]','FontSize',16,'Interpreter','latex')
ylabel('$V_x$ and $V_z$ [m/s]','FontSize',16,'Interpreter','latex')

% Plot cp versus theta:
figure;
plot(distance(1:end-1), cp(1,:))
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


