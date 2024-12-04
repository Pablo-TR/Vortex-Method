function V = compute_V_finite(Xc,Xp_1,Xp_2)

    r1 = Xc - Xp_1;
    r2 = Xc - Xp_2;
    V = 1/(4*pi)*(norm(r1)+norm(r2))*cross(r1,r2)/(norm(r1)*norm(r2)*(norm(r1)*norm(r2) + dot(r1,r2)));
    
end