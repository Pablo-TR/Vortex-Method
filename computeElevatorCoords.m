function  [xc2, zc2] = computeElevatorCoords(delta, xc1, zc1, d, x)
    angle = -delta;
    elevatorPos = [xc1+d zc1];
    rotMat = [cos(angle) -sin(angle);
              sin(angle) cos(angle)];
    elevatorPos = rotMat * elevatorPos';
    xc2 = (elevatorPos(1,:) + x)';
    zc2 = elevatorPos(2,:)';
end