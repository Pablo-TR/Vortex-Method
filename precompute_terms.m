function [a,b, V_hat] = precompute_terms(normals, tangents, N, Q_inf, x_c_glob, z_c_glob, x_node_glob, z_node_glob, l_j, interference)
b = zeros(N-1,1);
a = zeros(N-1,N-1);

for i = 1:1:N-1
    b(i) = -Q_inf * transpose(tangents(i,:));
    for j = 1:1:N-1
         x_c_pan = (x_c_glob(i)-x_node_glob(j))*normals(j,2)...
         - (z_c_glob(i)-z_node_glob(j))*normals(j,1);
         z_c_pan = (x_c_glob(i)-x_node_glob(j))*normals(j,1)...
         + (z_c_glob(i)-z_node_glob(j))*normals(j,2);
        
        r1 = sqrt((x_c_pan)^2 + z_c_pan^2); 
        theta1 = atan2(z_c_pan,x_c_pan);
        r2 = sqrt((x_c_pan-l_j(j))^2 + z_c_pan^2);
        theta2 = atan2(z_c_pan,x_c_pan-l_j(j));
        
        if i==j && interference == 0 
            theta1 = 0.0;
            theta2 = -pi;
        end

        u_hat_loc = (theta2-theta1)/ (2*pi);
        w_hat_loc = (1/(4*pi)) * log((r2^2)/(r1^2));
        
        rotMat = [normals(j,2) normals(j,1); -normals(j,1) normals(j,2)];
        
        V_hat =  rotMat * [u_hat_loc w_hat_loc]';

        a(i,j) = dot(V_hat, tangents(i,:)); 
        
    end
end
end
