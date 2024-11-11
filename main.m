%MAIN
clear all, close all
D = 1;
N = 20;
Q_inf = [1,0];
kuttaChange = 10;
geometry = 'given';
[beta, x_nod, z_nod, x_c_glob, z_c_glob, l_j, normals, tangents] = discretize_geometry(D, N, geometry);
[a,b, ~] = precompute_terms(normals, tangents, N, Q_inf, x_c_glob, z_c_glob, x_nod,z_nod, l_j);
[a,b] = applyKuttaCondition(kuttaChange, a, b);
gammas = solveVortexStrength(a,b, kuttaChange);
[V] = computeV(gammas, N);
cp = computeCP(gammas, Q_inf, N);

%plot(x_c_glob, z_c_glob, '-o');
%axis equal
%hold on
%plot(x_nod, z_nod, '-o');
%hold off
plot(rad2deg(beta(1:end-1)), V(:,1))