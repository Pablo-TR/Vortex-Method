function [a,b] = applyKuttaCondition(kuttaChange, a, b)
    kuttaRow = zeros(1,size(a,2));
    kuttaRow(1) = 1;
    kuttaRow(end) = 1;
    a(kuttaChange, :) = kuttaRow;
    b(kuttaChange)  = 0;
end