function computePart2(NACA_Data,nodes_NACA, alphas, Q_mod,c1,c2, txtN, D,geometry, plotGeometry,d, deltas)
N = nodes_NACA(txtN);

[~, xn, zn, xc, zc, lj1, normals, tangents] = discretize_geometry(D, N,NACA_Data,geometry,plotGeometry, txtN,c1);
[~, xn2_orig, zn2_orig, xc2_orig, zc2_orig, lj2, normals2_orig, tangents2_orig] = discretize_geometry(D, N,NACA_Data,geometry,plotGeometry, txtN,c2);

cp1  = zeros(length(alphas),2*(N-1));
Cl1  = zeros(length(alphas),1);
Cm1  = zeros(length(alphas),1);

kuttaChange = floor((N)/4);

cdef = c1+c2+d;

for i = 1:1:length(alphas)
    interference = 1;
    alpha = alphas(i);
    delta = 0;
    tangents2 = tangents2_orig;
    normals2 = normals2_orig;
    [xc2, zc2] = computeElevatorCoords(delta, xc2_orig, zc2_orig, d, c1);
    [xn2, zn2] = computeElevatorCoords(delta, xn2_orig, zn2_orig, d, c1);

    [cp1(i,:), Cl1(i), Cm1(i)] = computeAerodynamicParams(alpha,xc, zc, xn, zn, xc2, zc2,...
        xn2, zn2,normals, tangents, normals2, tangents2, N, lj1,lj2, Q_mod, cdef, kuttaChange, interference);
    
end

cp2  = zeros(length(alphas),2*(N-1));
Cl2  = zeros(length(alphas),1);
Cm2  = zeros(length(alphas),1);

for i = 1:1:length(deltas)

    interference = 1;
    alpha = 4;
    delta = deg2rad(deltas(i));
    [xc2, zc2] = computeElevatorCoords(delta, xc2_orig, zc2_orig, d, c1);
    [xn2, zn2] = computeElevatorCoords(delta, xn2_orig, zn2_orig, d, c1);
    
    tangents2 = rotateVector(delta, tangents2_orig);
    normals2 = rotateVector(delta, normals2_orig);
    [cp2(i,:), Cl2(i), Cm2(i)] = computeAerodynamicParams(alpha,xc, zc, xn, zn, xc2, zc2, xn2, zn2,normals, tangents, normals2, tangents2, N, lj1, lj2, Q_mod, cdef, kuttaChange, interference);

end




end

function  [xc2, zc2] = computeElevatorCoords(delta, xc1, zc1, d, x)
    angle = -delta;
    elevatorPos = [xc1+d zc1];
    rotMat = [cos(angle) -sin(angle);
              sin(angle) cos(angle)];
    elevatorPos = rotMat * elevatorPos';
    xc2 = (elevatorPos(1,:) + x)';
    zc2 = elevatorPos(2,:)';
end

function [B] = rotateVector(delta, V)
    angle = -delta;
    rotMat = [cos(angle) -sin(angle);
              sin(angle) cos(angle)];
    B = rotMat*V';
    B = B';
end


function [cp, Cl, Cm]  = computeAerodynamicParams(alpha, xc, zc, xn, zn, xc2, zc2, xn2, zn2,normals, tangents, normals2, tangents2, N, lj1, lj2, Q_mod, cdef, kuttaChange, interference)
    A = zeros(2*(N-1),2*(N-1));
    b = zeros(2*(N-1),1);
    
    Q_inf = Q_mod.*[cos(deg2rad(alpha)) sin(deg2rad(alpha))];

    
    [A11,b11, ~] = precompute_terms(normals, tangents, N, Q_inf, xc, zc, xn,zn, lj1, 0);
    [A22,b22, ~] = precompute_terms(normals2, tangents2, N, Q_inf, xc2, zc2, xn2,zn2, lj2,0);
    [A12,~, ~] = precompute_terms(normals2, tangents, N, Q_inf, xc, zc, xn2,zn2, lj2,1);
    [A21,~, ~] = precompute_terms(normals, tangents2, N, Q_inf, xc2, zc2, xn,zn, lj1,1);
        
    A(1:N-1, 1:N-1) = A11;
    A(1:N-1, N:2*(N-1)) = A12;
    A(N:2*(N-1), 1:(N-1)) = A21;
    A(N:2*(N-1), N:2*(N-1)) = A22;
    b(1:N-1) = b11;
    b(N:2*(N-1)) = b22;
    [A,b] = applyKuttaCondition(kuttaChange, A ,b ,interference);
    gammas = solveVortexStrength(A,b,kuttaChange,interference);
    
    cp = computeCP(gammas, Q_inf);
    
    Cl = computeCl(gammas, [lj1 lj2] ,Q_inf,cdef);
    
    Cm = computeCm(cp, [xc xc2], [zc zc2], [xn xn2], [zn zn2], cdef);

end