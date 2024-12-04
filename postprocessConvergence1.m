function postprocessConvergence1(M_crit_all, alphas, txtN, Cl_all, Cm_all)
    postprocess1_Mach_critic(M_crit_all, alphas, txtN)
    postprocess1_Cl_Cm(Cl_all, Cm_all,alphas, txtN)
end