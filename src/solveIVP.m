% solveIVP.m file
function [zt,ut,V] = solveIVP(u0,du0,p,ht)       
    % Boilerplate to set u0, du0 and pressure in the Simulink model
    assignin('base', 'u0', u0);
    assignin('base', 'du0', du0);
    assignin('base', 'p', p);
    % Run the simulink model, 'time' is z in our case
    simOut = sim('dropmodel',...
        'StopTime',num2str(ht),... 
        'MaxStep',num2str(max(u0/400,1e-5)),...
        'LimitDataPoints','off');   
    % Return the shape of the surface and volume of the drop
    zt = simOut.get('tout');
    yout = simOut.get('yout');
    ut = yout(:,1);
    V = yout(end,2);        
    % Close the system, this is needed for parallelization
    close_system('dropmodel', 0);  
end