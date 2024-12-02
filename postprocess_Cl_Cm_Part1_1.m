function postprocess_Cl_Cm_Part1_1(cp, Cl, Cm,alpha)
    figure;    
    scatter(alpha,Cl,'b')
    hold on
    grid on
    title('Coeficient de sustentaci\''o envers l''angle d''atac pel perfil NACA 22112','FontSize', 18, 'Interpreter', 'latex')
    xlabel('$\alpha \, [^\circ]$', 'FontSize', 16, 'Interpreter', 'latex')
    ylabel('$C_l$ [-]', 'FontSize', 16, 'Interpreter', 'latex')
    
    figure;    
    scatter(alpha,Cm,'r')
    hold on
    grid on
    title('Coeficient de moment envers l''angle d''atac pel perfil NACA 22112','FontSize', 18, 'Interpreter', 'latex')
    xlabel('$\alpha \, [^\circ]$', 'FontSize', 16, 'Interpreter', 'latex')
    ylabel('$C_m$ [-]', 'FontSize', 16, 'Interpreter', 'latex')
    
    %figure;    
    %plot(Cp, alpha,'b')

end