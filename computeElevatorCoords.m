function  [xc2, zc2] = computeElevatorCoords(delta, xc1, zc1, d, x)
    angle = -delta;
    elevatorPos = [xc1+d zc1];
    rotMat = [cosd(angle) -sind(angle);
              sind(angle) cosd(angle)];
    elevatorPos = rotMat * elevatorPos';
    xc2 = (elevatorPos(1,:) + x)';
    zc2 = elevatorPos(2,:)';
end