function [V] = computeV(gammas, N,tangents)
    V = zeros(N,2);
    for i = 1:1:N
       V(i,:) = gammas(i).*tangents(i,:); 
    end
end