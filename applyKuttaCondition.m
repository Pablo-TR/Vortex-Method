function [a,b] = applyKuttaCondition(kuttaChange, a, b)
    kuttaRow = zeros(1,size(a,2)-2);
    kuttaRow(1) = 1;
    kuttaRow(end) = kuttaRow(1);
    a(kuttaChange, :) = [kuttaRow(1), kuttaRow, kuttaRow(end)];
    b(kuttaChange)  = 0;
end