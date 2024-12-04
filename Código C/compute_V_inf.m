function V_inf = compute_V_inf(Xc,Xp_1,Xp_2)

    u_r =  [-1;0;0]; % Verifie avec le prof
    r2_a = Xc - Xp_1;
    u_r2_a = r2_a/norm(r2_a);
    r2_b = Xc - Xp_2;
    u_r2_b = r2_b/norm(r2_b);
    Va = (1 - dot(u_r,u_r2_a))*cross(u_r, r2_a)/(4*pi*(norm(cross(u_r, r2_a))^2));
    Vb = (1 - dot(u_r,u_r2_b))*cross(u_r, r2_b)/(4*pi*(norm(cross(u_r, r2_b))^2));
    V_inf = (Va - Vb);

end