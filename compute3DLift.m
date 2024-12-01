function [Cl3D] = compute3DLift(gammas, Q_inf, S, HS_coords)
    Q_mod = norm(Q_inf);
    N = length(gammas);
    Cl3D = 0;
    for i = 1:1:N
        delta_y = HS_coords(i,5) - HS_coords(i,2);
        Cl3D = Cl3D + (gammas(i)*delta_y)/(Q_mod*S);
    end
    Cl3D = 2*Cl3D;
end