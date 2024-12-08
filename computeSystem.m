function [CLw, CLt, Clw, Clt, Cm0w, Cm0t, alpha_ind_w, alpha_ind_t, CD_indi_w, CD_ind_w, CD_indi_t, CD_ind_t, CD_vi_w, CD_visc_w, CD_vi_t, CD_visc_t, CDw, CDt, Cm0, CL, CD, cp_coords_t] = computeSystem(Cl_alpha_w, Cl0_w, Cl_alpha_t, Cl0_t,  Nhs,ws, ts, lv, lh, Q_inf, thetaw,thetat, iw, it, alpha, crw, ctw, cr_t, ct_t, Cdt, Cdw, Sv, CD_visc_v, Cm25w, Cm25t)
    Sw = computeSurface(crw, ctw, ws);
    St = computeSurface(cr_t, ct_t, ts);
  

    [cp_coords_w, HS_coords_w]= discretizeHorseshoe(ws, Nhs, 0, 0);
    [cp_coords_t, HS_coords_t]= discretizeHorseshoe(ts, Nhs, lv, lh);
    
    thetaw = computeSectionTheta(cp_coords_w, thetaw(1), thetaw(2), ws);
    thetat = computeSectionTheta(cp_coords_w, thetat(1), thetat(2), ts);
    
    
    cw = computeSectionChord(cp_coords_w, crw, ctw, ws);
    ct = computeSectionChord(cp_coords_t, cr_t, ct_t, ts);
    
    OutOfFoil = 0;

    [A11, b1] = computeLL(cp_coords_w, HS_coords_w, alpha, Q_inf, Cl0_w, Cl_alpha_w, thetaw, cw, iw, OutOfFoil); 
    [A22, b2] = computeLL(cp_coords_t, HS_coords_t, alpha, Q_inf, Cl0_t, Cl_alpha_t, thetat, ct, it, OutOfFoil); 

    OutOfFoil = 1;

    [A12, ~] = computeLL(cp_coords_w, HS_coords_t, alpha, Q_inf, Cl0_w, Cl_alpha_w, thetaw, cw, iw, OutOfFoil);
    [A21, ~] = computeLL(cp_coords_t, HS_coords_w, alpha, Q_inf, Cl0_t, Cl_alpha_t, thetat, ct, it, OutOfFoil);

    A = [A11 A12;
        A21 A22];
    b = [b1'; b2'];

    gammas = A\b;
  
     CLw = compute3DLift(gammas(1:Nhs), Q_inf, Sw, HS_coords_w);
     CLt = compute3DLift(gammas(Nhs+1:end), Q_inf, St, HS_coords_t);

    [alpha_ind_w, Clw] = computeInducedAlpha(gammas(1:Nhs), Q_inf, cw, Cl0_w, thetaw, alpha, iw, Cl_alpha_w);
    [alpha_ind_t, Clt] = computeInducedAlpha(gammas(Nhs+1:end), Q_inf, ct, Cl0_t, thetat, alpha, it, Cl_alpha_t);

    [CD_indi_w, CD_ind_w] = computeInducedDrag(gammas(1:Nhs), HS_coords_w, alpha_ind_w, Q_inf, Sw, Clw);
    [CD_indi_t, CD_ind_t] = computeInducedDrag(gammas(Nhs+1:end), HS_coords_t, alpha_ind_t, Q_inf, St, Clt);
    
    [CD_vi_w, CD_visc_w] = computeViscousDrag(Cdw, Clw, HS_coords_w, cw, Sw);
    [CD_vi_t, CD_visc_t] = computeViscousDrag(Cdt, Clt, HS_coords_t, ct, St);
    

    
    [Cm0w, MACw] = computePitchingMoment(Cm25w, gammas(1:Nhs), crw, ctw, HS_coords_w,cp_coords_w, Sw, Q_inf, 0);
    [Cm0t, MACt] = computePitchingMoment(Cm25t, gammas(Nhs+1:end), cr_t, ct_t, HS_coords_t,cp_coords_t, St, Q_inf, lh);
    HS_coords = [HS_coords_w; HS_coords_t];
    
    CDw = CD_visc_w + CD_ind_w;
    CDt = CD_visc_t + CD_ind_t;
    
    Cm0 = Cm0w + Cm0t*(St*MACt)/(Sw*MACw);
    CL =  compute3DLift(gammas, Q_inf, Sw, HS_coords);
    CD = CDw + CDt*St/Sw + CD_visc_v * Sv/Sw;
        

end