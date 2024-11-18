function [gamma] = solveVortexStrength(a,b, kuttaChange)
    gamma = a\b;
    gamma(kuttaChange) = mean([gamma(kuttaChange+1), gamma(kuttaChange-1)]) ;
end