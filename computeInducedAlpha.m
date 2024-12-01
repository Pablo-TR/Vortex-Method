function [alpha_ind, Cl] = computeInducedAlpha(gammas, Q_inf, c, Cl0, theta, alpha, ind_angle, Cl_alpha)
    Q_mod = norm(Q_inf);
    N = length(gammas);
    alpha_ind = zeros(N,1); 
    Cl = zeros(N,1);
    for i = 1:1:N
        Cl(i) = (2*gammas(i))/(c(i)*Q_mod);
        alpha_ind(i) = ((Cl(i)-Cl0)/Cl_alpha) - alpha - theta(i) - ind_angle;
    end
end