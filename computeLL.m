function  [a, b] = computeLL(cp_coords, HS_coords, alpha, Q_inf, Cl0, Cl_alpha, thetai_1_2, ci_1_2, k_inf)
    Q_mod = norm(Q_inf);
    Ncp = size(cp_coords, 1);
    Nhs = size(HS_coords,1);
    a = zeros(Nhs, Ncp);
    b = zeros(1, Ncp);

    for i = 1:1:Ncp %Ncp = number of control points
        cp = cp_coords(i,:);
        for j = 1:1:Nhs % N = number of horsehoes
            P1 = HS_coords(j,1:3);
            P2 = HS_coords(j,4:6);
 
            r1 = cp - P1;
            r2 = cp-P2;
            r1_norm = norm(r1);
            r2_norm = norm(r2);
            
            ur_semi = [-1,0,0]; % Needs to be rotated if there is wing twist? (not implemented yet)
            ur1 = r1/r1_norm;
            ur2 = r2/r2_norm;
            
            %Finite vortex
            Vab = (1/4*pi)*((r1_norm +r2_norm)/((r1_norm*r2_norm)...
                *(r1_norm*r2_norm+dot(r1,r2))))*cross(r1,r2);
            
            %Semi-infinite vortices            
            Va = (1/4*pi)*((1-dot(ur_semi,ur1))/(cross(ur_semi,r1)^2))*(cross(ur_semi,r1));
           
            ur_semi = [1,0,0]; % Needs to be rotated if there is wing twist? (not implemented yet)
            
            Vb = (1/4*pi)*((1-dot(ur_semi,ur2))/(cross(ur_semi,r2)^2))*(cross(ur_semi,r2));
            
            V = Va-Vb+Vab;

            a(i,j) = -0.5*Cl_alpha*ci_1_2(i)*dot(V,k_inf);            
            if i == j
                a(i,j) = a(i,j)+1;
            end
        end
        b(i) = 0.5*ci_1_2(i)*Q_mod*(Cl0 + Cl_alpha(alpha+thetai_1_2(i)));
    end
end