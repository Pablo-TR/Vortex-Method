function postprocess_cp_distr(x_n, z_n, x_c, z_c, cp, normals, alpha)

cp = transpose(cp);

% Compute the x and y components of the vectors
x_final = cp .* normals(:,1);
z_final = cp .* normals(:,2);

% Initialize figure
figure;
hold on;

% Plot the base curve
plot(x_n, z_n, 'k-', 'LineWidth', 2)

% Loop through each vector to apply the logic
for i = 1:length(cp)
    if cp(i) >= 0
        % For positive cp, plot the vector as usual
        quiver(x_c(i)+x_final(i), z_c(i)+z_final(i), -x_final(i), -z_final(i), 0, ...
               'b', 'LineWidth', 1, 'MaxHeadSize', 0.75);
    else
        % For negative cp, reverse the vector direction
        quiver(x_c(i), z_c(i), -x_final(i), -z_final(i), 0, ...
               'r', 'LineWidth', 1, 'MaxHeadSize', 0.75);
    end
end

% Add title and labels
title(sprintf('Distribution of $C_P$ for $\\alpha$ = %d', alpha), ...
      'FontSize', 18, 'Interpreter', 'latex')
xlabel('$X$ [m]', 'FontSize', 16, 'Interpreter', 'latex')
ylabel('$Y$ [m]', 'FontSize', 16, 'Interpreter', 'latex')

% Turn on grid for better visualization
grid on;

end
