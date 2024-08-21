cmap=[0.4660 0.6740 0.1880; 0.9290 0.6940 0.1250; 0 0.4470 0.7410; 1 0 0];
cb=colorbar;
x = linspace(0,1,100);
y = x.';
z = max(x,y);
% plot setup
contourf(x,y,z,size(cmap,1)-1)
axis equal
colormap(cmap)
% wrangle the discrete colorbar tick alignment
cb = colorbar;
cbscalein = cb.Limits;
cbscaleout = [min(z(:)) max(z(:))];
ticks = linspace(cbscaleout(1),cbscaleout(2),size(cmap,1)+1);
cb.Ticks = diff(cbscalein)*(ticks-cbscaleout(1))/diff(cbscaleout) + cbscalein(1);
cb.XTickLabel={'Low','Medium','High','Extreme',''};
