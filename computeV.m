function [V] = computeV(gammas, N,tangents)
    V = zeros(N-1,2);
    for i = 1:1:N-1
       V(i,:) = gammas(i).*tangents(i,:); 
    end
end