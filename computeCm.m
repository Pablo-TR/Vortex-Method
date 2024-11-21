function [Cm] = computeCm(cp, xp, zp, xc,zc,c)
    Cm = 0;

    for i=1:1:length(cp)
        delta_x = xc(i)-xp(i);
        delta_z = zc(i)-zp(i);
        Cm = Cm + cp(i)*(xc(i)*delta_x + zc(i)*delta_z);
    end
    Cm = Cm/c;
end