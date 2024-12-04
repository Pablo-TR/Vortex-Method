function [S] = computeSurface(ct, cr, b)
    S = ((cr+ct)*(b/2))/2;
    S = S*2;
end