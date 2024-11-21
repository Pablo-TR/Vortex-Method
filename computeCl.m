function [Cl] = computeCl(gammas, l, Q_inf,c)
    Cl = 0;
    for i=1:1:length(l)
        Cl = Cl + (gammas(i)*l(i))/(norm(Q_inf)*c);
    end
    Cl = 2*Cl;
end