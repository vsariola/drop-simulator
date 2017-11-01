function plot_ca_data(data,cas)

n = size(data,2)/2;

for i = 1:n
   h = data(:,i*2-1);
   f = data(:,i*2);
   ind = ~isnan(h);
   h = h(ind);
   f = f(ind);
   plot(h,f);
   [y,ind] = max(f);
   x = h(ind);
   text(x,y+0.005,sprintf('%d°',cas(i)),'FontName','Arial','FontSize',10,'HorizontalAlign','center','VerticalAlign','bottom');
   hold on;
end
xlim([1.6 2.075]);
ylim([0.11 1.43]);
hA = gca;
hA.TickLength = [0.03 0.03];