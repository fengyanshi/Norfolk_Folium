clear all

% folder of results
fdir='/Volumes/DISK_2020_5/Norfolk_DEM/results/SLR_2100/';
fmodel='/Volumes/DISK_2020_5/Norfolk_DEM/model/';

NumbX=[71];
DimsX_b=[6500 6001];

%lat1=load([fmodel 'lat_median.txt']);
%lon1=load([fmodel 'lon_median.txt']);

%[lon lat]=meshgrid(lon1,lat1);
% depth
%eval(['cd ' fdir]);
fname=[fdir 'dep.out'];
fileID=fopen(fname);
dep=fread(fileID,DimsX_b,'*single');
fclose(fileID);
dep=dep'-1.50;

dx=9.2593e-05;
[n m]=size(dep);
x1=[0:m-1]*dx;           % change
y1=[0:n-1]*dx;           % change

[x y]=meshgrid(x1,y1);

lat0=36.635092999999998;
lon0=-76.599999999999994;
lon=lon0+x;
lat=lat0+y;

xcut1=1800;
xcut2=6500;
ycut1=1500;
ycut2=4500;

lonG=[lon(ycut1,xcut1) lon(ycut2,xcut2)];
latG=[lat(ycut1,xcut1) lat(ycut2,xcut2)];

NumbX=[71];

fnum=sprintf('%.5d',NumbX(1));
fname=[fdir 'hmax_' fnum];
fileID=fopen(fname);
hmax=fread(fileID,DimsX_b,'*single');
fclose(fileID);
hmax=hmax';

hm=hmax;

threhold=0.01;
%hm(hm<threhold)=NaN;  
hm(dep<0.5 | hm<threhold)=NaN;  



fig=figure(1);

wid=10;
len=6.4;
set(fig,'units','inches','paperunits','inches','papersize', [wid len],'position',[1 1 wid+1 len+1],'paperposition',[0 0 wid len]);
colormap jet

clf

plot(lonG,latG,'.r','MarkerSize',1)
plot_google_map('maptype','satellite','APIKey','AIzaSyBeu2oRBtLClpcm4i2VDIXltuzMAOY5yX4')
hold on

b=pcolor(lon(ycut1:ycut2,xcut1:xcut2),lat(ycut1:ycut2,xcut1:xcut2),hm(ycut1:ycut2,xcut1:xcut2));shading interp
%set(b,'FaceAlpha',0.6);
%set(b,'AlphaData',~isnan(eta))

%vb=[-10:0];
%contour(lon(1:end-ycut,xcut:end),lat(1:end-ycut,xcut:end),-dep(1:end-ycut,xcut:end),vb,'Color','k')
colorbar

caxis([0 3])
%lonG=[lon(1,xcut) lon(end-ycut,end)];
%latG=[lat(1,xcut) lat(end-ycut,end)];
axis([lonG latG])
%axis([lon(1,xcut) lon(end-ycut,end) lat(1,end) lat(end-ycut,xcut)])
%title([times])
xlabel('LON (deg)')
ylabel('LAT (deg)')


set(gcf,'PaperPositionMode','auto')

print -djpeg100 hmax.jpg







