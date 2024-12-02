function [B] = rotateVector(delta, V)
    angle = -delta;
    rotMat = [cosd(angle) -sind(angle);
              sind(angle) cosd(angle)];
    B = rotMat*V';
    B = B';
end