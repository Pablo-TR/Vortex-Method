function [A,b] = coeff_influence(Nw,Nh,X_c,X_p,alpha, theta, c_y ,cl_0,cl_a, Q_inf,AOA)

K_inf = [-sin(AOA*pi/180) ; 0; cos(AOA*pi/180)];
if Nh ~=0
    N = Nw + Nh + 1; % We create one artificial control node 
else 
    N = Nw;
end

A = zeros(N,N);
b = zeros(N,1);


for i=1:N % Let i be the control node of the horshoe i

    for j=1:N % Let j be the first node of the horshoe j
        if (i == j)
            V_inf_semi = compute_V_inf(X_c(i,:),X_p(i,:),X_p(i+1,:));
            A(i,j) = -1/2*cl_a(i)*c_y(i)*dot(V_inf_semi,K_inf) + 1;
            %A(i,j) = -dot(V_inf_semi,K_inf) + 1;

          %  Vab = No se evalua, porque sale inf (singularidad); Propio
          %  vortice no contibuye a velocidad en el CP
        else
            Xc = X_c(i,:);
            Xp1 = X_p(j,:);
            Xp2 = X_p(j+1,:);
            V_inf_semi = compute_V_inf(X_c(i,:),X_p(j,:),X_p(j+1,:));
            V_finite = compute_V_finite(X_c(i,:),X_p(j,:),X_p(j+1,:));
            V_tot = V_inf_semi + V_finite;
            A(i,j) = -1/2*cl_a(i)*c_y(i)*dot(V_tot,K_inf); 
            %A(i,j) = -dot(V_tot,K_inf);
           
        end
    end

    b(i) = 1/2*c_y(i)*Q_inf*(cl_0(i) + cl_a(i)*(alpha(i) + theta(i)*pi/180));

end

end