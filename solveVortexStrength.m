function [gamma] = solveVortexStrength(a,b, kuttaChange, interference)
    gamma = a\b;
    n = length(gamma)/2;

    gamma(kuttaChange) = mean([gamma(kuttaChange+1), gamma(kuttaChange-1)]) ;
    if interference
        gamma(kuttaChange+n) = mean([gamma(n+kuttaChange+1), gamma(n+kuttaChange-1)]) ;
    end
end