function [Cm0, MAC] = computePitchingMoment(Cm25, gammas,cr, ct, HS_coords, xc, S, Q_inf, L)
    N = length(HS_coords);
    Q_mod = norm(Q_inf);
    Cm_aux= 0;
    
    lambda = ct/cr;
    MAC = (2/3) * cr * ((1+lambda+lambda^2)/(1+lambda));
    for i = 1:1:N
        delta_y = HS_coords(i,5) - HS_coords(i,2); 
        Cm_aux = Cm_aux + ((L+xc(i,2))*gammas(i)*delta_y)/(Q_mod*S*MAC) ;
    end
    Cm0 = Cm25 - 2*Cm_aux;
end
