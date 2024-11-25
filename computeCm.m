function [Cm] = computeCm(cp, xc, zc, xn,zn,c)
    Cm = 0;

    for i=1:1:length(cp)
        delta_x = xn(i+1)-xn(i);
        delta_z = zn(i+1)-zn(i);
        Cm = (Cm + cp(i)*((xc(i)-c/4)*delta_x + zc(i)*delta_z))/(c);
    end
    Cm = Cm/c;
end