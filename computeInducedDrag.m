function [CD_indi, CD_ind] = computeInducedDrag(gammas, HS_coords, alpha_ind, Q_inf, S, Cli)
    Q_mod = norm(Q_inf);
    N = length(gammas);
    CD_indi = zeros(N,1);
    CD_ind = 0;

    for i = 1:1:N
        delta_y = HS_coords(i,5) - HS_coords(i,2);
        CD_indi(i) = -Cli(i)*alpha_ind(i);
        CD_ind = CD_ind + (gammas(i) * delta_y*alpha_ind(i))/(Q_mod*S);
        %CD_ind = CD_indi(i) * delta_y + CD_ind; 
    end
   CD_ind = -2.*CD_ind;
end