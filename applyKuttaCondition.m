function [a,b] = applyKuttaCondition(kuttaChange, a, b, interference)
    kuttaRow = zeros(1,size(a,2)-2);

    if interference
        n = size(a,2);
        a(kuttaChange,1) = 1;
        a(kuttaChange,n/2) = 1;
        a(kuttaChange,2:(n/2)-1) = 0;
        a(kuttaChange,(n/2)+1:end) = 0;

        a(kuttaChange+n, end) = 1;
        a(kuttaChange+n, (n/2)+1) = 1;
        a(kuttaChange+n, 1:n/2) = 0;
        a(kuttaChange+n, (n/2)+2:n-1) = 0; 
        b(kuttaChange)  = 0;
        b(kuttaChange+n)  = 0;

    else
        kuttaRow(1) = 1;
        kuttaRow(end) = kuttaRow(1);
        a(kuttaChange, :) = [kuttaRow(1), kuttaRow, kuttaRow(end)];
        b(kuttaChange)  = 0;
    end
end