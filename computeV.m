function [V] = computeV(gammas, N)
    V = zeros(N,2);
    for i = 1:1:N
       V(i,:) = abs(gammas(i)); 
    end
end