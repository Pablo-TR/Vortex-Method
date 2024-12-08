function aerodynamic_coef_plot(coef1, coords_w, plot_tag, axis_tag, lim)
    figure;
    hold on;
    plot(coords_w, coef1, '-', 'DisplayName', 'Wing', 'LineWidth', 1);
    hold off;
    
    % Customize the plot
    title(['Distribution of ', plot_tag, ' coefficients for $\alpha = 4^\circ$'], ...
          'Interpreter', 'latex', 'FontSize', 14);
    xlabel('Wing span position', 'FontSize', 12);
    ylabel(axis_tag, 'FontSize', 12);
    xlim([-lim/2, lim/2]);
    grid on;
    box on;
end