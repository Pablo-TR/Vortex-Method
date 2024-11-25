function [B] = rotateVector(delta, V)
    angle = -delta;
    rotMat = [cos(angle) -sin(angle);
              sin(angle) cos(angle)];
    B = rotMat*V';
    B = B';
end