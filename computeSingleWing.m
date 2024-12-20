function [CLw, Clw, alpha_ind_w, CD_indiw, CD_indw, CD_viw, CD_viscw, CDw, cp_coords_w] = computeSingleWing(Cl_alpha_w, Cl0_w, Nhs,ws, lv, lh, Q_inf, theta, iw, alpha, crw, ctw, Cdw)
    Sw = computeSurface(crw, ctw, ws);
    
   
    
    [cp_coords_w, HS_coords_w]= discretizeHorseshoe(ws, Nhs, lv, lh);
    
    thetaw = computeSectionTheta(cp_coords_w, theta(1), theta(2), ws);
    
    cw = computeSectionChord(cp_coords_w, crw, ctw, ws);
    
    OutOfFoil = 0;
    
    [A, b] = computeLL(cp_coords_w, HS_coords_w, alpha, Q_inf, Cl0_w, Cl_alpha_w, thetaw, cw, iw, OutOfFoil); 

    gammas = A\b';
  
    CLw = compute3DLift(gammas, Q_inf, Sw, HS_coords_w);

    [alpha_ind_w, Clw] = computeInducedAlpha(gammas(1:Nhs), Q_inf, cw, Cl0_w, thetaw, alpha, iw, Cl_alpha_w);

    [CD_indiw, CD_indw] = computeInducedDrag(gammas(1:Nhs), HS_coords_w, alpha_ind_w, Q_inf, Sw, Clw);
    
    [CD_viw, CD_viscw] = computeViscousDrag(Cdw, Clw, HS_coords_w, cw, Sw);
    
    CDw = CD_viscw + CD_indw;

    %Cm0 = computePitchingMoment(Cmw, gammas, cr, ct [HS_coordsw; HS_coordst], [cp_coords_w; cp_coords_t], Sw);
    %{
    [cl, CL] =  compute3DLift(gammas, Q_inf, Sw, [HS_coords_w;Hs_coords_t]);
    [~, CD_ind] = computeInducedDrag(gammas, [HS_coords_w;HS_coords_t], [alpha_ind_w; alpha_ind_t], Q_inf, Sw);
    %}
        
end