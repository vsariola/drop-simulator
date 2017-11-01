function plot_pillar_snapins_and_pulloffs

addpath('../helpers');

close all;

fsize = 10;
width = 11.6;
height = 5;
figure('Units','centimeters','Position',[1 1 width height]);
le = 0.135*11.6;
ri = 0.014*11.6;
ce = 0.13*11.6;

to = 0;
bo = 0.12*10;
wi = (width-le-ce-ri)/2;
he = (height-to-bo);
axes('Units','Centimeter','Position',[le bo wi he]);

load('../../output/pillar_adjusted_snapin_simulations.mat');
load('../../output/pillar_summary.mat');

plot(sim_pillar_radius,sim_pillar_snapin,'-','linewidth',1.3,'Color',[0.5 0.5 1]);

hold on;
plot(data_pillar_radius,data_pillar_snapin,'bo','MarkerSize',3);
ploterr(data_pillar_radius,data_pillar_snapin,[],{data_pillar_snapin_low,data_pillar_snapin_high},'b','log');
hold off;

xmargin = 1.3;
ymargin = 1.5;
xlim([min(data_pillar_radius)/xmargin max(data_pillar_radius)*xmargin]);
ylim([min(sim_pillar_snapin(sim_pillar_snapin > 0))/ymargin max(data_pillar_snapin)*ymargin]);

set(gca,'XScale','log');
set(gca,'YScale','log');

hA=gca;
hA.YAxis.MinorTickValues = [];
tv = [0.001 0.01 0.1 1 10 100];
hA.YAxis.TickValues = tv;
hA.YAxis.TickLabels = num2str(tv');
hA.XAxis.TickValues = [20 50 100 200 400];
hA.XAxis.MinorTickValues = [];
hA.TickLength = [0.03 0.03];

ylabel('Snap-in force (µN)');
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

axes('Units','Centimeter','Position',[le+wi+ce bo wi he]);

load('../../output/pillar_pulloff_simulations.mat');
load('../../output/pillar_summary.mat');

plot(sim_pillar_radius,sim_pillar_pulloff,'-','linewidth',1.3,'Color',[1 0.5 0.5]);

hold on;
plot(data_pillar_radius,data_pillar_pulloff,'rs','MarkerSize',3);
ploterr(data_pillar_radius,data_pillar_pulloff,[],{data_pillar_pulloff_low,data_pillar_pulloff_high},'r','log');
hold off;

xmargin = 1.3;
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

if ~exist('../../output','dir')
    mkdir('../../output');
end

addpath('../export_fig');
export_fig('../../output/pillar_plots.png','-r600');
export_fig('../../output/pillar_plots.pdf');

rmpath('../helpers');