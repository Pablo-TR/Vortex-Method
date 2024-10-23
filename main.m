%MAIN
D = 1;
N = 30;
Q_inf = [1,0];
kuttaChange = int(N/4);
geometry = 'given';
[x_nod, z_nod, x_pan, z_pan, l_j, normals, tangents] = discretize_geometry(D, N, geometry);
[a,b, ~] = precompute_terms(normals, N, Q_inf);
[a,b] = applyKuttaCondition(kuttaChange, a, b);
gammas = solveVortexStrength(a,b, kuttaChange);
[V] = computeV(gammas, tangents, N);
cp = computeCP(gammas, Q_inf);