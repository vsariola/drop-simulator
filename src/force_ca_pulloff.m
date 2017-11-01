function [Ft,zt,ut,rt,pt,ht] = force_ca_pulloff(theta,Vt)   
    ht0 = h_cap(Vt)+0.01;
    [~,~,~,rt,pt] = force_ca(theta,ht0,Vt);
    x0 = [ht0;rt;pt];
    options = optimoptions(@fmincon,'Algorithm','sqp','Display','none','SpecifyObjectiveGradient',true,'DiffMinChange',1e-3,'ConstraintTolerance',1e-3);
   
    [x,~,exitflag] = fmincon(@objfun,x0,[],[],[],[],[],[],@confuneq,options);
    
    ht = x(1);
    rt = x(2);
    pt = x(3);    
    % Force is the sum of laplace and capillary terms
    Ft = 2 * pi * rt * sin(theta) - pt * pi * rt^2;   
    % fsolve didn't converge, warn and return 0 instead of returning
    % potentially erroneous values
    if (exitflag <= 0)                    
        warning('Did not converge, exitflag = %d',exitflag);        
        Ft = 0;
    end
    
    function [f,g] = objfun(x)
        f =  - 2 * pi * x(2) * sin(theta) + x(3) * pi * x(2)^2;   

        if nargout > 1 % gradient required
            g = [0;
                 -2*pi*sin(theta)+2*x(3)*pi*x(2);
                 pi*x(2)^2];
        end
    end
    
    function [c,ceq] = confuneq(arg)
        [zt,ut,Vcurrent] = solveIVP(arg(2),-cot(theta),arg(3),arg(1));
        penalty = 1+1000*abs(arg(1)-zt(end));
        c = [];
        ceq = [Vt - Vcurrent;(1 - ut(end))*penalty];         
    end
end