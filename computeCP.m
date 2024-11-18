function [cp] = computeCP(gammas, Q_inf, N)
    cp = zeros(1,N);
    q_mod = sqrt(Q_inf(1)^2+Q_inf(2)^2);
    
    for i = 1:1:N
        cp(i) = 1-(gammas(i)./q_mod)^2;
    end
end