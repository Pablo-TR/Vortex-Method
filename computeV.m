function [V] = computeV(gammas, tangents, N)
    V = zeros(N,2);
    for i = 1:1:N
       V(i,:) = gammas(i) .*tangents; 
    end
end