function postprocess1_Cl_Cm(Cl_all, Cm_all,alphas, txtN)

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
        scatter(alphas(1, 1:5), Cl_all{h}, 100, '*', 'MarkerEdgeColor', currentColor);
        plotHandles(h) = plot(alphas(1, 1:5), Cl_all{h}, 'LineWidth', 0.75, 'Color', currentColor, ...
            'DisplayName', sprintf('Número de divisions: %d', N(h)));
    end

    % Mostrar la leyenda usando únicamente los handles de los plots
    legend(plotHandles, 'Location', 'best');
    title('Coeficient de sustentaci\''o envers l''angle d''atac pel perfil NACA 22112','FontSize', 18, 'Interpreter', 'latex')
    xlabel('$\alpha \, [^\circ]$', 'FontSize', 16, 'Interpreter', 'latex')
    ylabel('$C_l$ [-]', 'FontSize', 16, 'Interpreter', 'latex')

    figure;
    hold on;
    grid on;

    % Inicializar un array para almacenar los handles de los plots
    plotHandles = gobjects(length(txtN), 1);

    for h = 1:length(txtN)
        % Selecciona el color correspondiente a esta iteración
        currentColor = colors(h, :);

        % Dibujar el scatter y el plot con el mismo color
        scatter(alphas(1, 1:5), Cm_all{h}, 100, '*', 'MarkerEdgeColor', currentColor);
        plotHandles(h) = plot(alphas(1, 1:5), Cm_all{h}, 'LineWidth', 0.75, 'Color', currentColor, ...
            'DisplayName', sprintf('Número de divisions: %d', N(h)));
    end

    % Mostrar la leyenda usando únicamente los handles de los plots
    legend(plotHandles, 'Location', 'best');
    title('Coeficient de moment envers l''angle d''atac pel perfil NACA 22112','FontSize', 18, 'Interpreter', 'latex')
    xlabel('$\alpha \, [^\circ]$', 'FontSize', 16, 'Interpreter', 'latex')
    ylabel('$C_m$ [-]', 'FontSize', 16, 'Interpreter', 'latex')
    
end