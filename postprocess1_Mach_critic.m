function postprocess1_Mach_critic(M_crit_all, alphas, txtN)
    % Definir un conjunto de colores (matriz de 5 filas, una por cada color)
    colors = lines(length(txtN)); % Genera una matriz de colores [n x 3]
    N=[32 64 128 256 512];

    figure;
    hold on;
    grid on;

    % Inicializar un array para almacenar los handles de los plots
    plotHandles = gobjects(length(txtN), 1);

    for h = 1:length(txtN)
        % Selecciona el color correspondiente a esta iteración
        currentColor = colors(h, :);

        % Dibujar el scatter y el plot con el mismo color
        scatter(alphas(1, 1:3), M_crit_all{h}, 100, '*', 'MarkerEdgeColor', currentColor);
        plotHandles(h) = plot(alphas(1, 1:3), M_crit_all{h}, 'LineWidth', 0.75, 'Color', currentColor, ...
            'DisplayName', sprintf('Número de divisions: %d', N(h)));
    end

    % Mostrar la leyenda usando únicamente los handles de los plots
    legend(plotHandles, 'Location', 'best');

    xlabel('Angle d''atac $[^\circ]$', 'FontSize', 16, 'Interpreter', 'latex');
    ylabel('Mach cr\''itic [-]', 'FontSize', 16, 'Interpreter', 'latex');
    title('Relaci\''o entre l''angle d''atac i el Mach cr\''itic', 'FontSize', 18, 'Interpreter', 'latex');
    xlim([-0.5 4.5]);
end


