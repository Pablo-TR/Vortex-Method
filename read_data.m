function [NACA_Data, num_nodes_NACA] = read_data(options)

% Switch to concatenate tables based on the selected option
switch options
    case 'NACA0015'
        
        data1_15=readtable('NACA0015/NACA0015_N_32.txt');
        data2_15=readtable('NACA0015/NACA0015_N_64.txt');
        data3_15=readtable('NACA0015/NACA0015_N_128.txt');
        data4_15=readtable('NACA0015/NACA0015_N_256.txt');
        data5_15=readtable('NACA0015/NACA0015_N_512.txt');

        % Determine the maximum number of rows
        maxRows = max([height(data1_15), height(data2_15), height(data3_15), height(data4_15), height(data5_15)]);
        
        % Pad each table up to the maximum number of rows with NaN
        data1 = padarray(table2array(data1_15), [maxRows - height(data1_15), 0], NaN, 'post');
        data2 = padarray(table2array(data2_15), [maxRows - height(data2_15), 0], NaN, 'post');
        data3 = padarray(table2array(data3_15), [maxRows - height(data3_15), 0], NaN, 'post');
        data4 = padarray(table2array(data4_15), [maxRows - height(data4_15), 0], NaN, 'post');
        data5 = padarray(table2array(data5_15), [maxRows - height(data5_15), 0], NaN, 'post');

        % Convert each matrix back to a table
        data1 = array2table(data1);
        data2 = array2table(data2);
        data3 = array2table(data3);
        data4 = array2table(data4);
        data5 = array2table(data5);
        
        % Define the tables in a cell array for easy iteration
        NACA_Data = {data1, data2, data3, data4, data5};
        
        % Create a vector to store the number of valid rows in each table
        num_nodes_NACA = zeros(1, length(NACA_Data));
        
        % Loop to count valid rows in the first column of each table
        for i = 1:length(NACA_Data)
            % Select the first column of the current table
            first_column = NACA_Data{i}{:, 1};
            
            % Count the rows that are not NaN in the first column
            num_nodes_NACA(i) = sum(~isnan(first_column));
        end
        
        % Display the result
        disp('Number of nodes for each case with the NACA 0015:');
        disp(num_nodes_NACA);

    case 'NACA22112'

        data1_22=readtable('NACA22112/NACA_22112_N_32.txt');
        data2_22=readtable('NACA22112/NACA_22112_N_64.txt');
        data3_22=readtable('NACA22112/NACA_22112_N_128.txt');
        data4_22=readtable('NACA22112/NACA_22112_N_256.txt');
        data5_22=readtable('NACA22112/NACA_22112_N_512.txt');

        % Determine the maximum number of rows
        maxRows = max([height(data1_22), height(data2_22), height(data3_22), height(data4_22), height(data5_22)]);
        
        % Pad each table up to the maximum number of rows with NaN
        data1 = padarray(table2array(data1_22), [maxRows - height(data1_22), 0], NaN, 'post');
        data2 = padarray(table2array(data2_22), [maxRows - height(data2_22), 0], NaN, 'post');
        data3 = padarray(table2array(data3_22), [maxRows - height(data3_22), 0], NaN, 'post');
        data4 = padarray(table2array(data4_22), [maxRows - height(data4_22), 0], NaN, 'post');
        data5 = padarray(table2array(data5_22), [maxRows - height(data5_22), 0], NaN, 'post');

        % Convert each matrix back to a table
        data1 = array2table(data1);
        data2 = array2table(data2);
        data3 = array2table(data3);
        data4 = array2table(data4);
        data5 = array2table(data5);

        % Define the tables in a cell array for easy iteration
        NACA_Data = {data1, data2, data3, data4, data5};
        
        % Create a vector to store the number of valid rows in each table
        num_nodes_NACA = zeros(1, length(NACA_Data));
        
        % Loop to count valid rows in the first column of each table
        for i = 1:length(NACA_Data)
            % Select the first column of the current table
            first_column = NACA_Data{i}{:, 1};
            
            % Count the rows that are not NaN in the first column
            num_nodes_NACA(i) = sum(~isnan(first_column));
        end
        
        % Display the result
        disp('Number of nodes for each case with the NACA 22112:');
        disp(num_nodes_NACA);
end
end

