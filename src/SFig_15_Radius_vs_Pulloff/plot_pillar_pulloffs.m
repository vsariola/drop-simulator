function plot_pillar_pulloffs

addpath('../helpers');

fsize = 10;

if isempty(get(groot,'CurrentFigure'))
    fsize = 10;
    width = 7;
    height = 7;
    figure('Units','centimeters','Position',[1 1 width height]);
    le = 0.135*11.6;
    ri = 0.014*11.6;
    to = 0;
    bo = 0.12*10;
    wi = (width-le-ri);
    he = (height-to-bo);
    a1 = axes('Units','Centimeter','Position',[le bo wi he]);
end

load('../../output/pillar_pulloff_simulations.mat');
load('../../output/pillar_summary.mat');

l = plot(sim_pillar_radius,sim_pillar_pulloff,'-','linewidth',1.3,'Color',[1 0.5 0.5]);

hold on;
plot(data_pillar_radius,data_pillar_pulloff,'rs','MarkerSize',3);
h = ploterr(data_pillar_radius,data_pillar_pulloff,[],{data_pillar_pulloff_low,data_pillar_pulloff_high},'r','log');
hold off;

xmargin = 1.1;
ymargin = 1.2;
xlim([min(data_pillar_radius)/xmargin max(data_pillar_radius)*xmargin]);
ylim([min(sim_pillar_pulloff)/ymargin max(sim_pillar_pulloff)*ymargin]);

set(gca,'XScale','log');
set(gca,'YScale','log');

hA=gca;
hA.YAxis.MinorTickValues = [];
tv = [2 5 10 20 50 100 200];
hA.YAxis.TickValues = tv;
hA.YAxis.TickLabels = num2str(tv');
hA.XAxis.TickValues = [20 50 100 200 400];
hA.XAxis.MinorTickValues = [];
hA.TickLength = [0.03 0.03];

ylabel('Pull-off force (µN)');
xlabel('Pillar radius (µm)');


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

rmpath('../helpers');