function [CD_indi, CD_ind] = computeInducedDrag(gammas, HS_coords, alpha_ind, Q_inf)
    Q_mod = norm(Q_inf);
    N = length(gammas);
    CD_indi = zeros(N,1);

    for i = 1:1:N
        delta_y = HS_coords(i,5) - HS_coords(i,2);
        CD_indi(i) = (gammas(i) * delta_y * alpha_ind(i))/(Q_mod*S);
    end
    CD_indi = -2.*CD_indi;
    CD_ind = sum(CD_indi);
end