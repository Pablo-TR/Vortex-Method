function [a,b, V_hat] = precompute_terms(normals, tangents, N, Q_inf, x_c_glob, z_c_glob, x_node_glob, z_node_glob, l_j)
b = zeros(N,1);
a = zeros(N,N);
V_hat = zeros(N,2,N);

for i = 1:1:N
    b(i) = -Q_inf * transpose(tangents(N,:));
    for j = 1:1:N
         x_c_pan = (x_c_glob(i)-x_node_glob(j))*normals(j,2)...
         - (z_c_glob(i)-z_node_glob(j))*normals(j,1);
         z_c_pan = (x_c_glob(i)-x_node_glob(j))*normals(j,1)...
         + (z_c_glob(i)-z_node_glob(j))*normals(j,2);
        
%         x_c_pan = (x_node_glob(i)-x_c_glob(j))*normals(j,2)...
%         - (z_node_glob(i)-z_c_glob(j))*normals(j,1);
%         z_c_pan = (x_node_glob(i)-x_c_glob(j))*normals(j,1)...
%         + (z_node_glob(i)-z_c_glob(j))*normals(j,2);


        r1 = sqrt(x_c_pan^2 + z_c_pan^2); 
        theta1 = atan2(z_c_pan,x_c_pan);
        r2 = sqrt((x_c_pan-l_j(j))^2 + z_c_pan^2);
        theta2 = atan2(z_c_pan,x_c_pan-l_j(j));

        w_hat_loc = (1/(4*pi)) * log((r2^2)/(r1^2));
        u_hat_loc = (theta2-theta1)/ (2*pi);

        u_hat_glob = u_hat_loc * normals(j,1)+ w_hat_loc * normals(j,2);
        w_hat_glob = -u_hat_loc * normals(j,2)+ w_hat_loc * normals(j,1);
       
        V_hat(i,:,j) =  [u_hat_glob w_hat_glob];

        a(i,j) = V_hat(i,:,j) * tangents(j,:)'; 
        
    end
end
