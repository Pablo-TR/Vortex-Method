%% THE CONSTANT STRENGTH VORTEX METHOD APPLIED TO SIMPLE AND TWO-ELEMENT AIRFOILS
clearvars
close all

% Input data main airfoil
N1 = 512; % Number of nodes airfoil 1: choose from [32, 64, 128, 256, 512]
NACA1 = 15; % Airfoil profile (NACA0015)
c1 = 0.63;

data = readmatrix(sprintf('NACA0015/NACA%04d_N_%d.txt', NACA1, N1));
x1 = c1*data(:, 2:3);

% Input data flap airfoil
N2 = 512; % Number of nodes airfoil 1: choose from [32, 64, 128, 256, 512]
NACA2 = 15; % Airfoil    profile (NACA0015)
c2 = 0.35;

data = readmatrix(sprintf('NACA0015/NACA%04d_N_%d.txt', NACA2, N2));
d=0.02;

x2_ref = c2*data(:, 2:3);

alpha = 4;
delta = 16;
rot1 = [cosd(alpha) -sind(alpha); sind(alpha) cosd(alpha)];
rot2 = [cosd(delta) -sind(delta); sind(delta) cosd(delta)];
x1 = x1*rot1;
x2 = x2_ref*rot1*rot2;
x2(:,1) = x2(:,1) + (c1+d)*cosd(alpha);
x2(:,2) = x2(:,2)- (c1+d)*sind(alpha);

% Preallocate arrays
N=N1+N2; % Total number of panels
b = zeros(N, 1); % Right-hand side vector
A = -0.5 * eye(N); % Influence matrix
q = [1, 0]; % Freestream velocity
vij = zeros(N, N, 2);
v = zeros(N, 2);
cp = zeros(N, 1);
cl = 0;
cm = 0;




% Vectorized coordinates and panel lengths main airfoil
xc1 = (x1(1:N1, :) + x1(2:N1+1, :)) / 2;
l1 = sqrt(sum((x1(2:N1+1, :) - x1(1:N1, :)).^2, 2));
sj1 = (x1(1:N1, 2) - x1(2:N1+1, 2)) ./ l1;
cj1 = (x1(2:N1+1, 1) - x1(1:N1, 1)) ./ l1;
Nc1 = [sj1, cj1];
Tc1 = [cj1, -sj1];

% Vectorized coordinates and panel lengths flap airfoil
xc2 = (x2(1:N2, :) + x2(2:N2+1, :)) / 2;
xc2_ref = (x2_ref(1:N2, :) + x2_ref(2:N2+1, :)) / 2;
l2 = sqrt(sum((x2(2:N2+1, :) - x2(1:N2, :)).^2, 2));
sj2 = (x2(1:N2, 2) - x2(2:N2+1, 2)) ./ l2;
cj2 = (x2(2:N2+1, 1) - x2(1:N2, 1)) ./ l2;
Nc2 = [sj2, cj2];
Tc2 = [cj2, -sj2];

% % Generalized parameters
l=zeros(N,1);
l(1:N1)=l1;
l(N1+1:N1+N2)=l2;

xc=zeros(N+2,2);
xc(1:N1,:)=xc1;
xc(N1+1:N1+N2,:)=xc2;

x=zeros(N,2);
x(1:N1+1,:)=x1;
x(N1+2:N1+N2+2,:)=x2;

%Influence airfoil-airfoil
for i = 1:N1
    b(i) = -dot(q, Tc1(i, :));
    for j = 1:N1
        if j == i
            A(i, j) = -0.5;
            vij(i, j, :) = 0.5 * Tc1(i, :);
        else
            xc_diff = xc1(i, :) - x1(j, :);
            xcipanj = xc_diff(1) * cj1(j) - xc_diff(2) * sj1(j);
            zcipanj = xc_diff(1) * sj1(j) + xc_diff(2) * cj1(j);
            r1 = sqrt(xcipanj^2 + zcipanj^2);
            r2 = sqrt((xcipanj - l1(j))^2 + zcipanj^2);
            theta1 = atan2(zcipanj, xcipanj);
            theta2 = atan2(zcipanj, (xcipanj - l1(j)));

            wipanj = (1 / (4 * pi)) * log(r2^2 / r1^2);
            uipanj = (1 / (2 * pi)) * (theta2 - theta1);
            ui = uipanj * cj1(j) + wipanj * sj1(j);
            wi = -uipanj * sj1(j) + wipanj * cj1(j);

            A(i, j) = dot([ui, wi], Tc1(i, :));
            vij(i, j, :) = [ui, wi];
        end
    end
end

%Influence flap-airfoil
for i = 1:N1
    for j = 1:N2
            xc_diff = xc1(i, :) - x2(j, :);
            xcipanj = xc_diff(1) * cj2(j) - xc_diff(2) * sj2(j);
            zcipanj = xc_diff(1) * sj2(j) + xc_diff(2) * cj2(j);
            r1 = sqrt(xcipanj^2 + zcipanj^2);
            r2 = sqrt((xcipanj - l2(j))^2 + zcipanj^2);
            theta1 = atan2(zcipanj, xcipanj);
            theta2 = atan2(zcipanj, (xcipanj - l2(j)));

            wipanj = (1 / (4 * pi)) * log(r2^2 / r1^2);
            uipanj = (1 / (2 * pi)) * (theta2 - theta1);
            ui = uipanj * cj2(j) + wipanj * sj2(j);
            wi = -uipanj * sj2(j) + wipanj * cj2(j);

            A(i, N1+j) = dot([ui, wi], Tc2(i, :));
            vij(i, N1+j, :) = [ui, wi];
        
    end
end

%Influence flap-flap
for i = 1:N2
    b(N1+i) = -dot(q, Tc2(i, :));
    for j = 1:N2
        if j == i
            A(N1+i, N1+ j) = -0.5;
            vij(N1+i, N2+j, :) = 0.5 * Tc2(i, :);
        else
            xc_diff = xc2(i, :) - x2(j, :);
            xcipanj = xc_diff(1) * cj2(j) - xc_diff(2) * sj2(j);
            zcipanj = xc_diff(1) * sj2(j) + xc_diff(2) * cj2(j);
            r1 = sqrt(xcipanj^2 + zcipanj^2);
            r2 = sqrt((xcipanj - l2(j))^2 + zcipanj^2);
            theta1 = atan2(zcipanj, xcipanj);
            theta2 = atan2(zcipanj, (xcipanj - l2(j)));

            wipanj = (1 / (4 * pi)) * log(r2^2 / r1^2);
            uipanj = (1 / (2 * pi)) * (theta2 - theta1);
            ui = uipanj * cj2(j) + wipanj * sj2(j);
            wi = -uipanj * sj2(j) + wipanj * cj2(j);

            A(N1+i, N1+j) = dot([ui, wi], Tc2(i, :));
            vij(N1+i,N1+ j, :) = [ui, wi];
        end
    end
end

%Influence airfoil-flap
for i = 1:N2
    for j = 1:N1
            xc_diff = xc2(i, :) - x1(j, :);
            xcipanj = xc_diff(1) * cj1(j) - xc_diff(2) * sj1(j);
            zcipanj = xc_diff(1) * sj1(j) + xc_diff(2) * cj1(j);
            r1 = sqrt(xcipanj^2 + zcipanj^2);
            r2 = sqrt((xcipanj - l1(j))^2 + zcipanj^2);
            theta1 = atan2(zcipanj, xcipanj);
            theta2 = atan2(zcipanj, (xcipanj - l1(j)));

            wipanj = (1 / (4 * pi)) * log(r2^2 / r1^2);
            uipanj = (1 / (2 * pi)) * (theta2 - theta1);
            ui = uipanj * cj1(j) + wipanj * sj1(j);
            wi = -uipanj * sj1(j) + wipanj * cj1(j);

            A(N1+i, j) = dot([ui, wi], Tc1(i, :));
            vij(N1+i, j, :) = [ui, wi];
        
    end
end



i = floor(N1 / 4);
A(i, :) = zeros(1, N);
A(i, [1, N1]) = 1;
b(i) = 0;

j = N1+floor(N2 / 4);
A(j, :) = zeros(1, N);
A(j, [N1+1, N1+N2]) = 1;
b(j) = 0;

gamma = A\b;
gamma(i) = 0.5 * (gamma(i - 1) + gamma(i + 1));
gamma(j) = 0.5 * (gamma(j - 1) + gamma(j + 1));


% Final calculations for cl, cm, and cp
for i=1:N1
    v(i,:)=gamma(i)*Tc1(i);
end

for i=N1+1:N1+N2
    v(i,:)=gamma(i)*Tc2(i-N1);
end



cp = 1 - (gamma / norm(q)).^2;
cl1 = 2 * sum((gamma(1:end) .* [l1;l2]) / (norm(q) * (c1+d+c2)));
%cl2 = 2 * sum((gamma (N1+1:size(gamma,1)).* l2) / (norm(q) * (c1+c2+d)));
cl = cl1;
cm1 = sum((cp(1:N1) / c1) .* ((xc1(:, 1) - c1 * cosd(alpha) / 4) .* diff(x1(:, 1)) + (xc1(:, 2) + c1* sind(alpha)/4) .* diff(x1(:, 2))));
cm2 = sum((cp(1:N1) / c2) .* ((xc2_ref(:, 1) - c2 * cosd(alpha+delta) / 4) .* diff(x2_ref(:, 1)) + (xc2_ref(:, 2) + c2* sind(alpha+delta)/4) .* diff(x2_ref(:, 2))));
cm = cm1 + cm2;

%% Plotting

figure(1)
plot(xc1(:,1),xc1(:,2),xc2(:,1),xc2(:,2)), axis equal

figure(2)
plot(xc(1:size(xc,1)-2, 1), v)
title("V")
figure(3)
plot(xc(1:size(xc,1)-2,1), cp)
title("Cp")
figure(4)
plot(xc(1:size(xc,1)-2,1), gamma)
title("Gamma")