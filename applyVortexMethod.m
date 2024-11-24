function  [Ak, bk, A, b, gammas] = applyVortexMethod(Q_inf, normals, tangents,N, xc, zc, xn,zn, lj, kuttaChange, interference)
  

[A,b, ~] = precompute_terms(normals, tangents, N, Q_inf, xc, zc, xn,zn, lj, interference);

[Ak,bk] = applyKuttaCondition(kuttaChange, A, b, 0);
gammas = solveVortexStrength(Ak,bk, kuttaChange,0);
%[V] = computeV(gammas, N_W, tangentsWing);
end