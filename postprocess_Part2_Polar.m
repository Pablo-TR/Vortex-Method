function [CL_fine, CD_fine] = postprocess_Part2_Polar(CL_values, CD_values)
    % Ordenar CL_values y CD_values
    [CD_values_sorted, idx] = sort(CD_values);
    CL_values_sorted = CL_values(idx);

    % Generar la curva usando pchip
    CD_fine = linspace(min(CD_values_sorted), max(CD_values_sorted), 500);
    CL_fine = spline(CD_values_sorted, CL_values_sorted, CD_fine);

    % Graficar
    figure;
    scatter(CD_values, CL_values, 'b*'); % Puntos originales
    hold on;
    plot(CD_fine, CL_fine, 'r-', 'LineWidth', 1.5); % Curva interpolada
    title('Corba polar $C_L$ vs $C_D$','FontSize',18,'Interpreter','latex')
    xlabel('$C_D$','FontSize',16,'Interpreter','latex');
    ylabel('$C_L$','FontSize',16,'Interpreter','latex');
    legend('Dades originals', 'Corba interpolada (spline)','FontSize',16,'Interpreter','latex');
    grid on;
end

