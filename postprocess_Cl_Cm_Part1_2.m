function postprocess_Cl_Cm_Part1_2(cp1, Cl1, Cm1, cp2, Cl2, Cm2,alphas)
    figure;    
    scatter(alphas,Cl1,'b')
    hold on
    grid on
    title('Coeficient de sustentaci\''o envers l''angle d''atac pel conjunt estabilitzador-elevador','FontSize', 18, 'Interpreter', 'latex')
    xlabel('$\alpha \, [^\circ]$', 'FontSize', 16, 'Interpreter', 'latex')
    ylabel('$C_l$ [-]', 'FontSize', 16, 'Interpreter', 'latex')
    
    figure;    
    scatter(alphas,Cm1,'r')
    hold on
    grid on
    title('Coeficient de moment envers l''angle d''atac pel conjunt estabilitzador-elevador','FontSize', 18, 'Interpreter', 'latex')
    xlabel('$\alpha \, [^\circ]$', 'FontSize', 16, 'Interpreter', 'latex')
    ylabel('$C_m$ [-]', 'FontSize', 16, 'Interpreter', 'latex')
    
    %figure;    
    %plot(Cp, alpha,'b')

end