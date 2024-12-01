function [CD_vi, CD_v]= computeViscousDrag(Cd, Cl, HS_coords, c,S)
    N = length(Cl);
    CD_vi = zeros(N,1);
    for i = 1:1:N
        delta_y = HS_coords(i,5) - HS_coords(i,2);
        CD_vi(i) = Cd(Cl(i))*delta_y*c(i);
    end
    CD_vi = CD_vi./S;
    CD_v = sum(CD_vi);
end