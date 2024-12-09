function [cg] = cg_calculator(CL, Cm0, c, S, Q)
    L = 0.5*Q^2*S*CL;
    M = 0.5*Q^2*S*c*Cm0;
    cg = (Cm0*c)/CL;
end