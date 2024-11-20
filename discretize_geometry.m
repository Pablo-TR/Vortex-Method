function [distance,x_node_glob, z_node_glob, x_c_glob, z_c_glob, l_j, normals, tangents] = discretize_geometry(D, N,NACA_Data, opts, plotGeometry)
switch opts
    case 'read' %% Read from csv
        x_c_glob = zeros(N-1,1);
        z_c_glob = zeros(N-1,1);
        l_j = zeros(N-1,1); 

        normals = zeros(N-1,2);
        tangents = zeros(N-1,2);
        
        x_node_glob=NACA_Data{3};
        x_node_glob=table2array(x_node_glob(:, 2));
        z_node_glob=NACA_Data{3};
        z_node_glob=table2array(z_node_glob(:, 3));


        delta = (max(x_node_glob)-min(x_node_glob))/N;
        distance = 0:delta:1;

        for j = 1:1:N-1
            
            x_c_glob(j) = (x_node_glob(j)+x_node_glob(j+1))/2;
            z_c_glob(j) = (z_node_glob(j)+z_node_glob(j+1))/2;
            
            l_j(j) = sqrt((x_node_glob(j+1)-x_node_glob(j))^2+(z_node_glob(j+1)-z_node_glob(j))^2);
            sin_j = (z_node_glob(j)-z_node_glob(j+1))/l_j(j);
            cos_j = (x_node_glob(j+1)-x_node_glob(j))/l_j(j);
            
            normals(j,:) = [sin_j, cos_j];
            tangents(j,:) = [cos_j,-sin_j]; 
        end
        
    otherwise %% Discretize from given geometry (EX 1 -> cylinder)
        x_node_glob = zeros(N+1,1);
        z_node_glob = zeros(N+1,1);

        x_c_glob = zeros(N+1,1);
        z_c_glob = zeros(N+1,1);
        l_j = zeros(N+1,1); 

        normals = zeros(N+1,2);
        tangents = zeros(N+1,2);

        delta_distance = 2*pi/N;
        distance = 0:delta_distance:2*pi;
       
        for j = 0:1:N+1
            
            x_node_glob(j+1) = (D/2) * cos(delta_distance*j);
            z_node_glob(j+1) = -(D/2) * sin(delta_distance*j);
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
if plotGeometry
    figure;
    plot(x_node_glob, z_node_glob, '-o');     
end
end
