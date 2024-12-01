function [HS_coords, cp_coords] = computeHSCPcoords(Nhs, WS, H, L)
%Horseshoe coords of P1 and P2
    HS_coords = zeros(Nhs+1, 3);
    HS_coords(:,2) = linspace(-WS, Nhs+1, WS); %Y pos
    HS_coords(:,1) = L; % X pos
    HS_coords(:,3) = H; % Z pos
%Control points at X_(i+1/2)   
    cp_coords = zeros(Nhs,3);
    for i = 1:1:Nhs
        cp_coords(i,:) = 0.5*(HS_coords(i,:) + HS_coords(i+1,:));
    end
end