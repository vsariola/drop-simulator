function plot_volume_snapins

addpath('../helpers');

g = 9.81; % m/s^2
rho = 1000; % kg/m^3

close all;

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
axes('Units','Centimeter','Position',[le bo wi he]);

load('../../output/volume_snapin_simulations.mat');

x = sim_V * rho * g / 1e-6;
y = sim_pillar_snapin;
l1 = plot(x,y,'-','linewidth',1.3,'Color',[0.5 0.5 1]);

hold on;
xd = 15;
yd = interp1(x,y,xd);
line([xd xd]',[yd 0]','LineStyle','--','Color','k');
ind = x > 14 & x < 16;
xl = x(ind);
yl = y(ind);
p = polyfit(xl,yl',1);
l2 = plot(x,polyval(p,x));

legend([l1 l2],'Simulation',sprintf('%.3f * x + %.2f',p(1),p(2)),'Location','NorthEast');
legend boxoff;
xlim([0 max(x)+5]);
ylim([0 max(y)+0.2]);
fprintf('Relative slope: %g\n',p(1) * xd / yd);

hA=gca;
hA.TickLength = [0.03 0.03];

ylabel('Snap-in force {\itF} (µN)');
xlabel('Droplet weight {\itW} (µN)');

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
ax1 = gca;
emptybox(ax1)

rmpath('../helpers');