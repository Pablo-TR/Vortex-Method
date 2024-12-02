function [cp, Cl, Cm]  = computeAerodynamicParams(alpha, xc, zc, xn, zn, xc2, zc2, xn2,...
    zn2,normals, tangents, normals2, tangents2, N, lj1, lj2, Q_mod, cdef, kuttaChange, interference)
    A = zeros(2*(N-1),2*(N-1));
    b = zeros(2*(N-1),1);
    
    Q_inf = Q_mod.*[cos(deg2rad(alpha)) sin(deg2rad(alpha))];

    
    [A11,b11, ~] = precompute_terms(normals, tangents, N, Q_inf, xc, zc, xn,zn, lj1, 0);
    [A22,b22, ~] = precompute_terms(normals2, tangents2, N, Q_inf, xc2, zc2, xn2,zn2, lj2,0);
    [A12,~, ~] = precompute_terms(normals2, tangents2, N, Q_inf, xc, zc, xn2,zn2, lj2,1);
    [A21,~, ~] = precompute_terms(normals, tangents, N, Q_inf, xc2, zc2, xn,zn, lj1,1);
        
    A(1:N-1, 1:N-1) = A11;
    A(1:N-1, N:2*(N-1)) = A12;
    A(N:2*(N-1), 1:(N-1)) = A21;
    A(N:2*(N-1), N:2*(N-1)) = A22;
    b(1:N-1) = b11;
    b(N:2*(N-1)) = b22;
    [A,b] = applyKuttaCondition(kuttaChange, A ,b ,interference);
    gammas = solveVortexStrength(A,b,kuttaChange,interference);
    
    cp = computeCP(gammas, Q_inf);
    
    Cl = computeCl(gammas, [lj1; lj2] ,Q_inf,cdef);
    
    Cm1 = computeCm(cp(1,1:N-1), xc, zc , xn , zn , cdef);
    Cm2 = computeCm(cp(1,N:end), xc2, zc2 , xn2 , zn2 , cdef);
    Cm = Cm1+Cm2;

end