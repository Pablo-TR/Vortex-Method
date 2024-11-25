function postprocess_cp_distr(x_n, z_n, x_c, z_c, cp, normals, alphas)

for k = 1:size(cp, 1)
    % Seleccionar los valores de cp para el ángulo actual
    cp_current = transpose(cp(k, :)); % Transponer para trabajar como vector columna
    
    % Compute the x and y components of the vectors
    x_final = cp_current .* normals(:, 1);
    z_final = cp_current .* normals(:, 2);

    % Crear una nueva figura para cada ángulo de ataque
    figure;
    hold on;

    % Plot the base curve
    plot(x_n, z_n, 'k-', 'LineWidth', 2);

    % Loop para graficar cada vector
    for i = 1:length(cp_current)
        if cp_current(i) >= 0
            % Para valores positivos de cp
            quiver(x_c(i)+x_final(i), z_c(i)+z_final(i), -x_final(i), -z_final(i), 0, ...
                   'b', 'LineWidth', 1, 'MaxHeadSize', 0.75);
        else
            % Para valores negativos de cp
            quiver(x_c(i), z_c(i), -x_final(i), -z_final(i), 0, ...
                   'r', 'LineWidth', 1, 'MaxHeadSize', 0.75);
        end
    end

    % Añadir título y etiquetas a la figura actual
    title(sprintf('Distribution of $C_P$ for $\\alpha$ = %d', alphas(k)), ...
          'FontSize', 18, 'Interpreter', 'latex');
    xlabel('$X$ [m]', 'FontSize', 16, 'Interpreter', 'latex');
    ylabel('$Y$ [m]', 'FontSize', 16, 'Interpreter', 'latex');

    % Turn on grid for better visualization
    grid on;

    % Finalizar hold para la figura actual
    hold off;
end

end

