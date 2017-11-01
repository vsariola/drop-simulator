function emptybox(a1)
a2 = axes();        %Over axis, used for ticks, labels, and to hold data
propLink = linkprop([a1 a2],'units');
propLink = linkprop([a1 a2],'position');
box on;
set(a2,'color','none');
a2.XAxis.TickValues = [];
a2.YAxis.TickValues = [];
