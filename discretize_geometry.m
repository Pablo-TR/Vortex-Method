function [beta,x_node_glob, z_node_glob, x_c_glob, z_c_glob, l_j, normals, tangents] = discretize_geometry(D, N, opts)
switch opts
    case 'read' %% Read from csv
        [NACA15_Data, NACA22_Data, num_nodes_NACA15, num_nodes_NACA22] = read_data(data1_15, data2_15, data3_15, data4_15, data5_15,...
    data1_22, data2_22, data3_22, data4_22, data5_22, options)
    otherwise %% Discretize from given geometry (EX 1 -> cylinder)
        x_node_glob = zeros(N+1,1);
        z_node_glob = zeros(N+1,1);

        x_c_glob = zeros(N+1,1);
        z_c_glob = zeros(N+1,1);
        l_j = zeros(N+1,1); 

        normals = zeros(N+1,2);
        tangents = zeros(N+1,2);


        beta = 0:2*pi/N:2*pi;
        delta_beta = 2*pi/N;
       
        for j = 0:1:N+1
            
            x_node_glob(j+1) = (D/2) * cos(delta_beta*j);
            z_node_glob(j+1) = -(D/2) * sin(delta_beta*j);
        end   
        for j = 1:1:N+1
            
            x_c_glob(j) = (x_node_glob(j+1)+x_node_glob(j))/2;
            z_c_glob(j) = (z_node_glob(j+1)+z_node_glob(j))/2;
            
            l_j(j) = sqrt((x_node_glob(j+1)-x_node_glob(j))^2+(z_node_glob(j+1)-z_node_glob(j))^2);
            sin_j = (z_node_glob(j)-z_node_glob(j+1))/l_j(j);
            cos_j = (x_node_glob(j+1)-x_node_glob(j))/l_j(j);
            
            normals(j,:) = [sin_j, cos_j];
            tangents(j,:) = [cos_j,-sin_j]; 
        end
        
end
