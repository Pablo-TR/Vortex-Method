function [gamma] = solveVortexStrength(a,b)
    gamma = a\b;
    gamma(kuttaChange) = (gamma(kuttaChange+1) + gamma(kuttaChange-1))/2 ;
end