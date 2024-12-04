function [CLw, CLt, Clw, Clt, alpha_indw, alpha_indt, CD_indiw, CD_indw, CD_indit, CD_indt, CD_viw, CD_viscw, CD_vit, CD_visct, CDw, CDt] = computePart2_2(Cl_Wairfoil, Cl_Tairfoil,  Nhs,ws, ts, lv, lh, Q_inf, theta, iw, it, alpha, crw, ctw, crt, ctt, Cdt, Cdw);
    Sw = computeSurface(crw, ctw, ws);
    St = computeSurface(crt, ctt, ts);
    
    Cl_Wairfoil_data = fit(alpha, Cl_Wairfoil, 'poly1'); 
    Cl_Tairfoil_data = fit(alpha, Cl_Tairfoil, 'poly1');

    [cp_coords_w, HS_coords_w]= discretizeHorseshoe(ws, Nhs, 0, 0);
    [cp_coords_t, HS_coords_t]= discretizeHorseshoe(ws, Nhs, lv, lh);
    
    thetaw = computeSectionTheta(cp_coords_w, theta(1), theta(2), ws);
    thetat = computeSectionTheta(cp_coords_w, 0, 0, ts);

    cw = computeSectionChord(cp_coords_w, crw, ctw, ws);
    ct = computeSectionChord(cp_coords_w, crt, ctt, ts);

    Cl0_w = Cl_Wairfoil_data.p2;
    Clalpha_w = Cl_Wairfoil_data.p1;

    [A11, b1] = computeLL(cp_coords_w, HS_coords_w, alpha, Q_inf, Cl0_w, Clalpha_w, thetaw, cw, iw); 


    Cl0_t = Cl_Tairfoil_data.p2;
    Clalpha_t = Cl_Tairfoil_data.p1;

    [A22, b2] = computeLL(cp_coords_t, HS_coords_t, alpha, Q_inf, Cl0_t, Clalpha_t, thetat, ct, it); 

    [A12, ~] = computeLL(cp_coords_w, HS_coords_t, alpha, Q_inf, Cl0_t, Clalpha_t, thetat, ct, it);

    [A21, ~] = computeLL(cp_coords_t, HS_coords_w, alpha, Q_inf, Cl0_w, Clalpha_w, thetaw, cw, iw);
    A = [A11 A12;
        A21 A22];
    b = [b1; b2];

    gammas = A\b;
  
     CLw = compute3DLift(gammas(1:Nhs), Q_inf, Sw, HS_coords_w);
     CLt = compute3DLift(gammas(Nhs+1:end), Q_inf, St, HS_coords_t);

    [alpha_indw, Clw] = computeInducedAlpha(gammas(1:Nhs), Q_inf, cw, Cl0_w, thetaw, alpha, iw, Cl_alpha_w);
    [alpha_indt, Clt] = computeInducedAlpha(gammas(Nhs+1:end), Q_inf, ct, Cl0_t, thetat, alpha, it, Cl_alpha_t);

    [CD_indiw, CD_indw] = computeInducedDrag(gammas(1:Nhs), HS_coords_w, alpha_ind_w, Q_inf, Sw);
    [CD_indit, CD_indt] = computeInducedDrag(gammas(Nhs+1:end), HS_coords_t, alpha_ind_t, Q_inf, St);
    
    [CD_viw, CD_viscw] = computeViscousDrag(Cdw, Clw, HS_coords_w, cw, Sw);
    [CD_vit, CD_visct] = computeViscousDrag(Cdt, Clt, HS_coords_t, ct, St);
    
    CDw = CD_viscw + CD_indw;
    CDt = CD_visct + CD_indt;

    %Cm0 = computePitchingMoment(Cmw, gammas, cr, ct [HS_coordsw; HS_coordst], [cp_coords_w; cp_coords_t], Sw);
    %{
    [cl, CL] =  compute3DLift(gammas, Q_inf, Sw, [HS_coords_w;Hs_coords_t]);
    [~, CD_ind] = computeInducedDrag(gammas, [HS_coords_w;HS_coords_t], [alpha_ind_w; alpha_ind_t], Q_inf, Sw);
    %}
        

end