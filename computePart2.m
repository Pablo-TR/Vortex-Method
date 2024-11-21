function computePart2(normals, tangents, N, xc, zc, xn, zn, lj, alphas, Q_mod,c1,c2,deltas,d)

x = 1;
kuttaChange = (N-1)/4;
cp1  = zeros(length(alphas),2*(N-1));
Cl1  = zeros(length(alphas),1);
Cm1  = zeros(length(alphas),1);

xc_orig = xc;
zc_orig = zc;
xn_orig = xn;
zn_orig = zn;

tangents_orig = tangents;
normals_orig = normals;

for i = 1:1:length(alphas)
    interference = 1;
    alpha = alphas(i);
    delta = 0;
    tangents2 = tangents;
    normals2 = normals;
    [xc2, zc2] = computeElevatorCoords(delta, xc_orig, zc_orig, d, x);
    [xn2, zn2] = computeElevatorCoords(delta, xn_orig, zn_orig, d, x);
    [cp1(i,:), Cl1(i), Cm1(i)] = computeAerodynamicParams(alpha,xc, zc, xn, zn, xc2, zc2, xn2, zn2,normals, tangents, normals2, tangents2, N, lj, Q_mod, c1, c2, kuttaChange, interference);
    
end

cp2  = zeros(length(alphas),2*(N-1));
Cl2  = zeros(length(alphas),1);
Cm2  = zeros(length(alphas),1);

for i = 1:1:length(deltas)
    interference = 1;
    alpha = 0;
    delta = deg2rad(deltas(i));
    [xc2, zc2] = computeElevatorCoords(delta, xc_orig, zc_orig, d, x);
    [xn2, zn2] = computeElevatorCoords(delta, xn_orig, zn_orig, d, x);
    
    tangents2 = rotateVector(delta, tangents_orig);
    normals2 = rotateVector(delta, normals_orig);
    [cp2(i,:), Cl2(i), Cm2(i)] = computeAerodynamicParams(alpha,xc, zc, xn, zn, xc2, zc2, xn2, zn2,normals, tangents, normals2, tangents2, N, lj, Q_mod, c1, c2, kuttaChange, interference);

end





end

function  [xc2, zc2] = computeElevatorCoords(delta, xc1, zc1, x, d)
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


function [cp, Cl, Cm]  = computeAerodynamicParams(alpha, xc, zc, xn, zn, xc2, zc2, xn2, zn2,normals, tangents, normals2, tangents2, N, lj, Q_mod, c1, c2, kuttaChange, interference)
    A = zeros(2*(N-1),2*(N-1));
    b = zeros(2*(N-1),1);
    
    Q_inf = Q_mod.*[cos(deg2rad(alpha)) sin(deg2rad(alpha))];

    
    [A11,b11, ~] = precompute_terms(normals, tangents, N, Q_inf, xc, zc, xn,zn, lj);
    [A22,b22, ~] = precompute_terms(normals2, tangents2, N, Q_inf, xc2, zc2, xn2,zn2, lj);
    [A12,~, ~] = precompute_terms(normals2, tangents, N, Q_inf, xc, zc, xn2,zn2, lj);
    [A21,~, ~] = precompute_terms(normals, tangents2, N, Q_inf, xc2, zc2, xn,zn, lj);
        
    A(1:N-1, 1:N-1) = A11;
    A(1:N-1, N:2*(N-1)) = A12;
    A(N:2*(N-1), 1:(N-1)) = A21;
    A(N:2*(N-1), N:2*(N-1)) = A22;
    b(1:N-1) = b11;
    b(N:2*(N-1)) = b22;
    [A,b] = applyKuttaCondition(kuttaChange, A ,b ,interference);
    gammas = solveVortexStrength(A,b,kuttaChange,interference);
    
    cp = computeCP(gammas, Q_inf);
    
    Cl1 = computeCl(gammas(1:N-1), lj,Q_inf,c1);
    Cl2 = computeCl(gammas(N:end), lj,Q_inf,c2);
    Cl = Cl1+Cl2;
    
    Cm1 = computeCm(cp(1:N-1), xc, zc,xn, zn, c1);
    Cm2 = computeCm(cp(N:end), xc2, zc2,xn2, zn2, c2);

    Cm = Cm1+Cm2;
end