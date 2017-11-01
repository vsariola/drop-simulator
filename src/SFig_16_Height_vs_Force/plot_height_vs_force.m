function plot_height_vs_force

close all

width = 14;
height = 7;

load('../../output/ca_height_vs_force.mat');
load('../../data/butt_data.mat');

figure('Units','centimeters','Position',[1 1 width height]);
le = 0.135*11.6;
ri = 0.014*11.6;
to = 0;
bo = 0.12*10;
wi = (width-le-ri)/2;
he = (height-to-bo);

axes('Units','Centimeter','Position',[le bo wi he]);
plot_ca_data(Butt_data,angle_hmax(:,1));
text(1.62,1.35,'Ref [1]','FontName','Arial');
ylabel('{\itF} {\it\gamma}^{-1} {\ita}^{-1}');
xlabel('{\ith} {\ita}^{-1}');

axes('Units','Centimeter','Position',[le+wi bo wi he]);
plot_ca_data(results,angle_hmax(:,1));
set(gca,'YTickLabels',[]);
text(1.62,1.35,'Our results','FontName','Arial');
xlabel('{\ith} {\ita}^{-1}');
