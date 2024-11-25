function postprocess_part_1(xcWing, cp, distance, gammas, x_n, z_n, x_c, z_c, normals, alpha)
    NACA_airfoils_plots(xcWing, cp, distance, gammas) % Plot the NACA airfoils.
    postprocess_cp_distr(x_n, z_n, x_c, z_c, cp, normals, alpha) % Quiver cp.

end