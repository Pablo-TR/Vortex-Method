function [NACA_Data, nodes_NACA] = read_data(options)

% Switch to concatenate tables based on the selected option
switch options
    case 'NACA0015'
        
        % Lista de archivos
        files = {
            'NACA0015/NACA0015_N_32.txt',
            'NACA0015/NACA0015_N_64.txt',
            'NACA0015/NACA0015_N_128.txt',
            'NACA0015/NACA0015_N_256.txt',
            'NACA0015/NACA0015_N_512.txt'
        };
        
        % Leer todos los archivos en una celda
        NACA_Data = cell(1, length(files));
        for i = 1:length(files)
            NACA_Data{i} = readtable(files{i});  % Leer cada archivo y almacenarlo en la celda
        end
        
        % Inicializar un vector para contar los nodos (filas válidas)
        nodes_NACA = zeros(1, length(NACA_Data));
        
        % Contar el número de filas válidas (sin NaN) en la primera columna de cada tabla
        for i = 1:length(NACA_Data)
            first_column = NACA_Data{i}{:, 1};  % Seleccionar la primera columna de la tabla
            nodes_NACA(i) = sum(~isnan(first_column));  % Contar las filas que no tienen NaN
        end
        
        % Mostrar el resultado
        disp('Number of nodes for each case with the NACA 0015:');
        disp(nodes_NACA);

    case 'NACA22112'
         % Lista de archivos
        files = {
            'NACA22112/NACA_22112_N_32.txt',
            'NACA22112/NACA_22112_N_64.txt',
            'NACA22112/NACA_22112_N_128.txt',
            'NACA22112/NACA_22112_N_256.txt',
            'NACA22112/NACA_22112_N_512.txt'
        };
        
        % Leer todos los archivos en una celda
        NACA_Data = cell(1, length(files));
        for i = 1:length(files)
            NACA_Data{i} = readtable(files{i});  % Leer cada archivo y almacenarlo en la celda
        end
        
        % Inicializar un vector para contar los nodos (filas válidas)
        nodes_NACA = zeros(1, length(NACA_Data));
        
        % Contar el número de filas válidas (sin NaN) en la primera columna de cada tabla
        for i = 1:length(NACA_Data)
            first_column = NACA_Data{i}{:, 1};  % Seleccionar la primera columna de la tabla
            nodes_NACA(i) = sum(~isnan(first_column));  % Contar las filas que no tienen NaN
        end
        
        % Mostrar el resultado
        disp('Number of nodes for each case with the NACA 22112:');
        disp(nodes_NACA);
end

