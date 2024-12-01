function [c] = computeSectionChord(cp_coords, cr, ct, b)
    N = length(cp_choords);
    c = zeros(N, 1);
    c_fun = @(y) abs(y)*(ct-cr)/(0.5*b) + cr; %Function to compute c at point y of the wingspan
    for i = 1:1:N
        y = cp_coords(i,2);
        c(i) = c_fun(y);
    end
end