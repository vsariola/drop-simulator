function [Ft,zt,ut,rt,pt] = force_ca(theta,ht,Vt)   
    % set options for the fsolve algorithm
    foptions = optimset('TolFun',1e-6,'TolX',1e-8,'Display','off','MaxIter',1000);   
    % fsolve finds the solution to the system of equations m = 0
    % argm(1) = r, argm(2) = pressure
    m1 = [0.1096 1.3743]; t1 = 175*pi/180;
    m2 = [1.3841 0.8807]; t2 = 90*pi/180;
    lerp = @(a) (1 - a) * m1 + a * m2;
    m0 = lerp((theta - t1) / (t2 - t1));
    [argm,~,exitflag] = fsolve(@m,m0,foptions);   
    rt = argm(1);
    pt = argm(2);    
    % Force is the sum of laplace and capillary terms
    Ft = 2 * pi * rt * sin(theta) - pt * pi * rt^2;   
    % fsolve didn't converge, warn and return 0 instead of returning
    % potentially erroneous values
    if (exitflag <= 0)                    
        warning('Did not converge, exitflag = %d',exitflag);        
        Ft = 0;
    end
   
    % Also return the shape of the drop that solves the BVP
    [zt,ut] = solveIVP(argm(1),-cot(theta),argm(2),ht);
    
    % Penalty is added only if the simulation ends before zt reaches ht
    % i.e. if one of the conditional stops fires 
    function valm = m(arg)
        [zt,ut,Vcurrent] = solveIVP(arg(1),-cot(theta),arg(2),ht);
        penalty = 1+1000*(ht-zt(end));
        valm = [Vt - Vcurrent;(1 - ut(end))*penalty];         
    end
end