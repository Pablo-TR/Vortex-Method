function [cg] = postprocess_part_2_2(Clw, Clt, CD_indiw, CD_indit, CD_viw, CD_vit, coords_w, coords_t)
    aerodynamic_coef_plot(Clw, Clt, coords_w, coords_t, 'lift coefficient', 'C_l'); % Plot of the lift coefficient for wing and tail
    aerodynamic_coef_plot(CD_indiw, CD_indit, coords_w, coords_t, 'induced drag coefficient', 'C_{di}'); % Plot of the induced drag coefficient for wing and tail
    aerodynamic_coef_plot(CD_viw, CD_vit, coords_w, coords_t, 'viscous drag coefficient', 'C_{dv}'); % Plot of the viscous drag coefficient for wing and tail
    aerodynamic_coef_plot(CD_indiw+CD_viw, CD_indit+CD_vit, coords_w, coords_t, 'drag coefficient', 'C_d');  % Plot of the total drag coefficient for wing and tail

    %[cg] = cg_calculator();
    cg = 0;
end