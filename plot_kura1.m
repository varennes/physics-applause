% plot 'kura1' simulation results overlayed on Kuramot Review simulation
% results from figure 10.

bw = imread('./fig/review_fig10_zoom.png');

xmin = 0;
xmax = tmax;
ymin = 0;
ymax = 1;

imagesc([xmin xmax], [ymin ymax], flipud(bw));

hold on

plot(t,r,'linewidth',2)
set(gcf, 'Color', 'None')
set(gca,'ydir','normal')

xlabel('time');
ylabel('Synchronization Order Parameter, q');
title('Simulation Comparison')

% print('compare_review','-dpng')