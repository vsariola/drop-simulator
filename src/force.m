% force.m file
function [Ft,zt,ut,du,pt] = force(rt,ht,Vt)   
    % set options for the fsolve algorithm
    foptions = optimset('TolFun',1e-6,'TolX',1e-8,'Display','off','MaxIter',1000);   
    % fsolve finds the solution to the system of equations m = 0
    % argm(1) = du/dz at z = 0, argm(2) = pressure
    [argm,~,exitflag] = fsolve(@m,[0;1],foptions);   
    du = argm(1);
    pt = argm(2);
    % Force is the sum of laplace and capillary terms
    Ft = 2 * pi * rt / sqrt(1+du^2) - pi * pt * rt^2;   
    % fsolve didn't converge, warn and return 0 instead of returning
    % potentially erroneous values
    if (exitflag <= 0)                    
        warning('Did not converge, exitflag = %d',exitflag);        
        Ft = 0;
    end
   
    % Also return the shape of the drop that solves the BVP
    [zt,ut] = solveIVP(rt,argm(1),argm(2),ht);
    
    % Penalty is added only if the simulation ends before zt reaches ht
    % i.e. if one of the conditional stops fires 
    function valm = m(arg)
        [zt,ut,Vcurrent] = solveIVP(rt,arg(1),arg(2),ht);
        penalty = 1+1000*(ht-zt(end));
        valm = [Vt - Vcurrent;(1 - ut(end))*penalty];         
    end
end