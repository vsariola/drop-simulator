function plot_ca_snapins_and_pulloffs

    close all;

    addpath('../helpers');
    
    fsize = 10;
    width = 14;
    height = 7;
    figure('Units','centimeters','Position',[1 1 width height]);
    le = 0.135*11.6;
    ri = 0.01;

    to = 0.12*10;
    bo = 0.12*10;
    wi = width/2-le-ri;
    he = (height-to-bo);
    
    a1 = axes('Units','Centimeter','Position',[le bo wi he]);

    sd = load('../../output/ca_snapin_simulations.mat');
   
    sx = sd.gamma * (1+cos(sd.sim_theta));
    sy = sd.sim_ca_snapin;
   
    sd = load('../../output/ca_pulloff_simulations.mat');
   
    pux = sd.gamma * (1+cos(sd.sim_theta));
    puy = sd.sim_ca_pulloff;
    
    plot(sx,sy,'-','linewidth',1.3,'Color',[0.5 0.5 1]);
   
    addmargin = @(l,m) l+[-1 1]*(l(2)-l(1))*m; 
    limits = @(a,m) addmargin([min(a) max(a)],m);
    
    xlim(limits(sx,0.05));
    ylim(limits(sy,0.05));

    hA=gca;
    hA.YAxis.MinorTickValues = [];
    hA.XAxis.TickValues = 0:0.02:1;
    hA.TickLength = [0.03 0.03];

    ylabel('Snap-in force (µN)');
    xlabel('Work of adhesion {\it\gamma}(1+cos{\it\theta})');

    set(gca,'FontName','Arial','FontSize', fsize) % Arial everywhere, the point size depends on the size of you Figure object, let's adjust that finally so they are close to identical in the final Figure
    h = get(gca, 'title');
    set(h ,'FontName','Arial','FontSize', fsize)
    h = get(gca, 'xlabel');
    set(h,'FontName','Arial','FontSize', fsize)
    h = get(gca, 'ylabel');
    set(h ,'FontName','Arial','FontSize', fsize)
    set(gcf,'color','w'); % white background
    set(gca,'TickDir','out')
    
    box off
    emptybox(gca)
    topa1 = gca;
    linkaxes([a1 topa1],'x');
    set(gca,'TickDir','out')
    
    topa1.TickLength = [0.03 0.03];
    topa1.XAxisLocation = 'top';
    topa1.YAxisLocation = 'right';
    box off
    thetas = [180 120 90 60]';
    topa1.XAxis.TickValues = sd.gamma*(1+cosd(thetas));
    topa1.XAxis.TickLabels = num2str(thetas);
    xlabel('Contact angle {\it\theta}');
    
    a1 = axes('Units','Centimeter','Position',[le*2+wi+ri bo wi he]);
    
    plot(pux,puy,'-','linewidth',1.3,'Color',[1 0.5 0.5]);
    
    addmargin = @(l,m) l+[-1 1]*(l(2)-l(1))*m; 
    limits = @(a,m) addmargin([min(a) max(a)],m);
    
    xlim(limits(pux,0.05));
    ylim(limits(puy,0.05));

    hA=gca;
    hA.YAxis.MinorTickValues = [];
    hA.XAxis.TickValues = 0:0.02:1;
    hA.TickLength = [0.03 0.03];

    
    ylabel('Pull-off force (µN)');
    xlabel('Work of Adhesion {\it\gamma}(1+cos{\it\theta})');

    set(gca,'FontName','Arial','FontSize', fsize) % Arial everywhere, the point size depends on the size of you Figure object, let's adjust that finally so they are close to identical in the final Figure
    h = get(gca, 'title');
    set(h ,'FontName','Arial','FontSize', fsize)
    h = get(gca, 'xlabel');
    set(h,'FontName','Arial','FontSize', fsize)
    h = get(gca, 'ylabel');
    set(h ,'FontName','Arial','FontSize', fsize)
    set(gcf,'color','w'); % white background
    set(gca,'TickDir','out')
    
    box off
    emptybox(gca)
    topa1 = gca;
    linkaxes([a1 topa1],'x');
    set(gca,'TickDir','out')
    
    topa1.TickLength = [0.03 0.03];
    topa1.XAxisLocation = 'top';
    topa1.YAxisLocation = 'right';
    box off
    thetas = [180 120 90 60]';
    topa1.XAxis.TickValues = sd.gamma*(1+cosd(thetas));
    topa1.XAxis.TickLabels = num2str(thetas);
    xlabel('Contact angle {\it\theta}');
    
    rmpath('../helpers');    
end