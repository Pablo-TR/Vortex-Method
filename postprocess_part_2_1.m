function postprocess_part_2_1(alphaIndw_all,CL_CD,CDindiw_all, CDviw_all, Clw_all, cp_coords_w,twists)
    idx = find(CL_CD == max(CL_CD));
    
    figure(
    plot(twists, CL_CD);
    title('Efici``encia aerodin``amica vs torsi\''o','FontSize',18,'Interpreter','latex')
    xlabel('Torsi\''o [$\circ$]', 'FontSize', 16, 'Interpreter', 'latex');
    ylabel('Efici``encia aerodin''amica')
    grid minor
    
    figure()
    plot(cp_coords_w, Clw_all{idx});
    title('Sustentació a l''ala','FontSize',18,'Interpreter','latex')
    xlabel('Posició a l''ala [m]', 'FontSize', 16, 'Interpreter', 'latex');
    ylabel('Cl')
    grid minor
    

    figure()
    plot(cp_coords_w,CDindiw_all{idx})
    hold on 
    plot(cp_coords_w,CDviw_all{idx})
    hold on
    plot(cp_coords_w,CDviw_all{idx}+CDindiw_all{idx})
    title('Distribució de drags a l''ala','FontSize',18,'Interpreter','latex')
    xlabel('Posició a l''ala [m]','FontSize', 16, 'Interpreter', 'latex')
    ylabel('$C_d [-]$','FontSize', 16, 'Interpreter', 'latex')
    legend('CDi', 'CDv', 'CD','Interpreter', 'latex')
    grid minor
    hold off

    figure()
    plot(cp_coords_w,alphaIndw_all{idx})
    title('Angle induït a l''ala','FontSize',18,'Interpreter','latex')
    ylabel('Angle induït [º]','FontSize', 16, 'Interpreter', 'latex')
    xlabel('Posició a l''ala [m]','FontSize', 16, 'Interpreter', 'latex')
    grid minor
end