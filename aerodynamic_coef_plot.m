function aerodynamic_coef_plot(coef1, coef2, coords_w, coords_t, plot_tag, axis_tag)
    figure;
    hold on;
    plot(coords_w, coef1, '-o', 'DisplayName', 'Wing', 'LineWidth', 1);
    plot(coords_t, coef2, '-x', 'DisplayName', 'Tail', 'LineWidth', 1);
    hold off;
    
    % Customize the plot
    title(['Distribution of ', plot_tag, ' coefficients for $\alpha = 4^\circ$'], ...
          'Interpreter', 'latex', 'FontSize', 14);
    xlabel('Wing span position', 'FontSize', 12);
    ylabel(axis_tag, 'FontSize', 12);
    legend('show', 'Location', 'best');
    xlim([-12, 12]);
    grid on;
    box on;
end