function computePart2(Cl_Wairfoil, Cl_Tairfoil,  Nhs,ws, lv, lh, Q_inf, theta, iw, it, alpha, crw, ctw, crt, ctt)
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

end