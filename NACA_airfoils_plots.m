function NACA_airfoils_plots(xcWing, cp, distance, gammas)
    
    % figure;
    % grid on
    % xlim([0 1])
    % plot(xcWing, V)
    % title('Distribution of velocity','FontSize',18,'Interpreter','latex')
    % xlabel('$\theta$ [$^\circ$]','FontSize',16,'Interpreter','latex')
    % ylabel('$V_x$ and $V_z$ [m/s]','FontSize',16,'Interpreter','latex')
    % hold off    

    % Plot cp versus theta:    
    figure;
    plot(xcWing, cp)
    hold on
    grid on
    xlim([0 1])
    %ylim([-3 1])
    title('Distribution of pressure coefficient','FontSize',18,'Interpreter','latex')
    xlabel('$\theta$ [$^\circ$]','FontSize',16,'Interpreter','latex')
    ylabel('$C_p$ [-]','FontSize',16,'Interpreter','latex')
    
    % Plot gamma versus theta:
    figure;
    plot(distance(1:end-2), gammas(:,1))
    hold on
    grid on
    xlim([0 1])
    title('Distribution of $\gamma$','FontSize',18,'Interpreter','latex')
    xlabel('$\theta$ [$^\circ$]','FontSize',16,'Interpreter','latex')
    ylabel('$\gamma$ [-]','FontSize',16,'Interpreter','latex')

end