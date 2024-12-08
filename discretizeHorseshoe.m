function [cp_coords, HS_coords] = discretizeHorseshoe(b, N, h, L)
    HS_coords = zeros(N, 6);
    cp_coords = zeros(N, 3);

    HS_coords(:,[1, 4]) = L;
    HS_coords(:,[3, 6]) = h;
    
    aux = linspace(-b/2,b/2,N+1);

    for i = 1:1:length(aux)-1
        HS_coords(i,2) = aux(i); 
        HS_coords(i,5) = aux(i+1);

        cp_coords(i,:) =  0.5*(HS_coords(i,1:3) + HS_coords(i,4:6)); 
    end
    
end