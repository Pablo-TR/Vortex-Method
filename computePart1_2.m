function [cp1, Cl1, Cm1, cp2, Cl2, Cm2] = computePart1_2(NACA_Data, nodes_NACA, alphas, Q_mod,c1,c2, txtN, D,geometry, plotGeometry, d, deltas, k, fixDeltaTo0)
N = nodes_NACA(txtN(k));

[~, xn, zn, xc, zc, lj1, normals, tangents] = discretize_geometry(D, N, NACA_Data, geometry, plotGeometry, txtN(k), c1);
[~, xn2_orig, zn2_orig, xc2_orig, zc2_orig, lj2, normals2_orig, tangents2_orig] = discretize_geometry(D, N, NACA_Data,...
    geometry, plotGeometry, txtN(k), c2);

cp1  = zeros(length(alphas),2*(N-1));
Cl1  = zeros(length(alphas),1);
Cm1  = zeros(length(alphas),1);

kuttaChange = floor((N)/4);

cdef = c1+c2+d;
    for i = 1:1:length(alphas)
        interference = 1;
        alpha = alphas(i);
        if fixDeltaTo0
            delta = 0;
        end
        tangents2 = tangents2_orig;
        normals2 = normals2_orig;
        [xc2, zc2] = computeElevatorCoords(delta, xc2_orig, zc2_orig, d, c1);
        [xn2, zn2] = computeElevatorCoords(delta, xn2_orig, zn2_orig, d, c1);
    
        [cp1(i,:), Cl1(i), Cm1(i)] = computeAerodynamicParams(alpha, xc, zc, xn, zn, xc2, zc2,...
            xn2, zn2, normals, tangents, normals2, tangents2, N, lj1, lj2, Q_mod, cdef, kuttaChange, interference);
    end
cp2  = zeros(length(alphas),2*(N-1));
Cl2  = zeros(length(alphas),1);
Cm2  = zeros(length(alphas),1);


for i = 1:1:length(deltas)

    interference = 1;
    alpha = 4;
    delta = deltas(i);
    [xc2, zc2] = computeElevatorCoords(delta, xc2_orig, zc2_orig, d, c1);
    [xn2, zn2] = computeElevatorCoords(delta, xn2_orig, zn2_orig, d, c1);
    
    tangents2 = rotateVector(delta, tangents2_orig);
    normals2 = rotateVector(delta, normals2_orig);
    [cp2(i,:), Cl2(i), Cm2(i)] = computeAerodynamicParams(alpha,xc, zc, xn, zn,...
        xc2, zc2, xn2, zn2,normals, tangents, normals2, tangents2, N, lj1, lj2, Q_mod, cdef, kuttaChange, interference);

end

end
