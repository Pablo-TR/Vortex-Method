function [a,b, V_hat] = precompute_terms(normals, N, Q_inf)
b = zeros(N);
a = zeros(N,N);
V_hat = zeros(N,2,N);

for i = 1:1:N
    b(i) = -Q_inf * tanspose(normals(N,:));
    for j = 1:1:N
        x_c_pan = (x_c_glob(i)-x_node_glob(j))*normals(j,2)...
        - (z_c_glob(i)-z_node_glob(j))*normals(j,1);
        z_c_pan = (x_c_glob(i)-x_node_glob(j))*normals(j,1)...
        + (z_c_glob(i)-z_node_glob(j))*normals(j,2);

        r1 = sqrt(x_c_pan^2+ z_c_pan^2); 
        theta1 = atan2(z_c_pan,x_c_pan);
        r2 = sqrt((x_c_pan-l_j(j))^2+ z_c_pan^2);
        theta2 = atan(z_c_pan,x_c_pan-l_j(j));

        u_hat_loc = (1/4*pi) * ln(r1^2/r2^2);
        w_hat_loc = (theta2-theta1)/ (2*pi);

        u_hat_glob = u_hat_loc * normals(j,1)+ w_hat_loc * normals(j,2);
        w_hat_glob = -u_hat_loc * normals(j,2)+ w_hat_loc * normals(j,1);
       
        V_hat(i,:,j) =  [u_hat_glob w_hat_glob];

        a(i,j) = V_hat(i,:,j) * normals(j,:)'; 
        
    end
end
