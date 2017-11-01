function summarize_pillar_data
    data = load('../../output/pillar_data.mat');
    
    N = length(data.radii);
    
    data_pillar_radius = data.radii;
    
    data_pillar_snapin = zeros(1,N); % uN
    data_pillar_snapin_low = zeros(1,N); % uN
    data_pillar_snapin_high = zeros(1,N); % uN
    
    data_pillar_pulloff = zeros(1,N); % uN
    data_pillar_pulloff_low = zeros(1,N); % uN
    data_pillar_pulloff_high = zeros(1,N); % uN
    
    for i = 1:N
        rets = process(data.snapins{i}); 
        data_pillar_snapin(i) = rets(1);
        data_pillar_snapin_low(i) = rets(2);
        data_pillar_snapin_high(i) = rets(3);
        
        retp = process(data.pulloffs{i});
        data_pillar_pulloff(i) = retp(1);
        data_pillar_pulloff_low(i) = retp(2);
        data_pillar_pulloff_high(i) = retp(3);
    end           
    
    save('../../output/pillar_summary.mat','data_pillar_radius','data_pillar_snapin','data_pillar_snapin_low','data_pillar_snapin_high','data_pillar_pulloff','data_pillar_pulloff_low','data_pillar_pulloff_high');

    function ret  = process(data)
        data = data(data > 0);
        if isempty(data)
            ret = [0 0 0];
            return;
        end
        logdata = log(data); % we take means and standard deviations in
                             % log-scale so that error bars are symmetric
                             % when plotted on log-scale
        meanlog = mean(logdata);
        stdlog = std(logdata);
        retmean = exp(meanlog);        
        retlow = exp(meanlog-stdlog);
        rethigh = exp(meanlog+stdlog);
        ret = [retmean retlow rethigh];
    end
end