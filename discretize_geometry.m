function [x_node_glob, z_node_glob, x_c_glob, z_c_glob, l_j, normals, tangents] = discretize_geometry(D, N, opts)
switch opts
    case 'read' %% Read from csv
        exit(0)
    otherwise %% Discretize from given geometry (EX 1 -> cylinder)
        x_node_glob = zeros(N+1);
        z_node_glob = zeros(N+1);

        x_c_glob = zeros(N);
        z_c_glob = zeros(N);
        l_j = zeros(N); 

        normals = zeros(N,2);
        tangents = zeros(N,2);


        delta_beta = 2*pi/N;
       
        for j = 0:1:N
            x_node_glob(j+1) = (D/2) * cos(delta_beta*j);
            z_node_glob(j+1) = -(D/2) * sin(delta_beta*j);
            
            x_c_glob(j) = (x_node_glob(j+1)-x_node_glob(j))/2;
            z_c_glob(j) = (z_node_glob(j+1)-z_node_glob(j))/2;
            
            l_j(j) = sqrt((x_node_glob(j+1)-x_node_glob(j))^2+(z_node_glob(j+1)-z_node_glob(j))^2);
            sin_j = (z_node_glob(j)-z_node_glob(j+1))/l_j;
            cos_j = (x_node_glob(j+1)-x_node_glob(j))/l_j;
            
            normals(j+1,:) = [sin_j, cos_j];
            tangents(j+1,:) = [cos_j,-sin_j];
        end
        
end
