function [cg] = postprocess_part_2_2(Clw, Clt, CD_indiw, CD_indit, CD_viw, CD_vit, coords_w, coords_t, b_w, b_t, CL, Cm0, c, S, Q)
    aerodynamic_coef_plot(Clw, coords_w, 'lift coefficient on wing', 'C_{l,wing}', b_w); % Plot of the lift coefficient for wing
    aerodynamic_coef_plot(Clt, coords_t, 'lift coefficient on tail', 'C_{l,tail}', b_t); % Plot of the lift coefficient for tail
    aerodynamic_coef_plot(CD_indiw, coords_w, 'induced drag on wing', 'C_{di,wing}', b_w); % Plot of the induced drag coefficient for wing
    aerodynamic_coef_plot(CD_viw, coords_w, 'viscous drag on wing', 'C_{dv,wing}', b_w); % Plot of the viscous drag coefficient for wing
    aerodynamic_coef_plot(CD_indiw+CD_viw, coords_w, 'drag on wing', 'C_{d,wing}', b_w);  % Plot of the total drag coefficient for wing
    aerodynamic_coef_plot(CD_indit, coords_t, 'induced drag on tail', 'C_{di,tail}', b_t); % Plot of the induced drag coefficient tail
    aerodynamic_coef_plot(CD_vit, coords_t, 'viscous drag on tail', 'C_{dv,tail}', b_t); % Plot of the viscous drag coefficient for tail
    aerodynamic_coef_plot(CD_indit+CD_vit, coords_t, 'drag on tail', 'C_{d,tail}', b_t);  % Plot of the total drag coefficient for tail
    [cg] = cg_calculator(CL, Cm0, c, S, Q);
end