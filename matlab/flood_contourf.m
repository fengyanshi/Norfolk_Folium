clear all
close all

threhold=0.01;
fdir='/Volumes/DISK_2020_5/Norfolk_DEM/results/SLR_2100/';
fplot='/Users/fengyanshi15/proposal/JACK_2020/TWL/interactive/matlab/';
fmodel='/Volumes/DISK_2020_5/Norfolk_DEM/model/';
% --------------

NumbX=[71];
DimsX_b=[6500 6001];

lat1=load([fmodel 'lat_median.txt']);
lon1=load([fmodel 'lon_median.txt']);

[LON LAT]=meshgrid(lon1,lat1);
% depth
eval(['cd ' fdir]);
fname=['dep.out'];
fileID=fopen(fname);
dep=fread(fileID,DimsX_b,'*single');
fclose(fileID);
dep=dep'-1.50;

dx=9.2593e-05;
[n m]=size(dep);
x=[0:m-1]*dx;           % change
y=[0:n-1]*dx;           % change

lat_1_s=36.635092999999998;
lat_1_e=37.190648000000003;
lon_1_s=-76.599999999999994;
lon_1_e=-75.998240999999993;

eval(['cd ' fplot]);
fig=figure;
len=8;
wid=len*DimsX_b(1)/DimsX_b(2)*1.2;
%set(gcf,'units','inches','paperunits','inches','papersize', ...
%[wid len],'position',[1 1 wid+1 len+1],...
%'paperposition',[0 0 wid len]);

eval(['cd ' fdir]);
fnum=sprintf('%.5d',NumbX(1));
fname=['hmax_' fnum];
fileID=fopen(fname);
hmax=fread(fileID,DimsX_b,'*single');
fclose(fileID);
hmax=hmax';

hm=hmax;

hm(hm<threhold)=NaN;         %

flood1=hmax;

flood1(flood1>=threhold)=1;
flood1(dep>0)=0;         %
flood1(flood1<threhold)=0;

clf
colormap jet

[~, hContour]=contourf(x,y,hm,10,'EdgeColor','none');   

drawnow;  % this is important, to ensure that FacePrims is ready in the next line!
hFills = hContour.FacePrims;  % array of TriangleStrip objects
[hFills.ColorType] = deal('truecoloralpha');  % default = 'truecolor'
for idx = 1 : numel(hFills)
   hFills(idx).ColorData(4) = 150;   % default=255
end

caxis([0.0 3.0])                       %
c=colorbar;
c.Location='east';
c.TickDirection ='in';
c.Position=[.9 .4 .01 .5];
c.FontSize = 12;

%hold on
%contour(x,y,flood1,[0.5 0.5],'Color','k')

axis tight
axis off
set(gca,'Position',[0 0 1.0 1.0]);

%set(gcf,'paperunits','centimeter')
%set(gcf,'papersize',[100,96.7])
%set(gcf,'paperposition',[0 0 100 96.7]);

% output

eval(['cd ' fplot]);

addpath('/Users/fengyanshi15/self_software/MATLAB/SVG_export/');

%print('mycontour', '-dsvg');   % Saves the svg

export_fig('test.svg','-dsvg','-r300');

return

set(fig, 'PaperPositionMode', 'auto')
%print(gcf,'flood.png','-dpng','-r150'); % little higher than screen resolution
print(gcf,'flood.png','-dpng','-r0'); % screen resolution
