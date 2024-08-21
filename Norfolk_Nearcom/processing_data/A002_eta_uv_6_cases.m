
clear all
close all

froot='/Users/fyshi/ESTCP_MAPS/Nearcom_Data/';
fcase={'D_IR_Base_ERA5','D_IR_Base_HM','D_IR_Bathy_Acc_GN_1m','D_IR_RMW_F1.25','D_IR_SLR_1.3M','D_IR_WSF_1.225'};
%fcase={'D_IR_Base_ERA5'};
case_name={'ERA5','HM','Acc GN 1m','RMW F1.25','SLR 1.3m','WSF 1.225'};

output_folder='../saved_images/';

fdir_input=[froot 'Grid_double/'];

files=[91 98 98 97 98 91];
DT=600.0;

ax=[-76.3 -76.246 36.94 36.975];

cax_hs=[0 2.5];
cax_eta=[-0.5 2.5];

Mindep=[0.1 0.4 0.4 0.4 0.4 0.2];
uv_deplimit = 0.2;

% read info

m=768;
n=304;

X1=load([fdir_input 'lon_curv.txt']);
Y1=load([fdir_input 'lat_curv.txt']);


X=X1(1:n,1:m);
Y=Y1(1:n,1:m);

fac=0.004;
xyaxis=[-76.31 -76.255 36.94 36.975];
skx=4;
sky=4;
skxW=8;
skyW=8;


fig=figure(1);
colormap parula
clf

wid=10;
len=10;
%set(fig,'units','inches','paperunits','inches','papersize', [wid len],'position',[1 1 wid len],'paperposition',[0 0 wid len]);






for k=1:length(fcase)
% read files -----------------------

if k==5 
dep=load([fdir_input 'dep_circ_SLR.txt'],'-ascii');
else
dep=load([fdir_input 'dep_circ.txt'],'-ascii');
end

fdir_data=[froot 'Data_double/' fcase{k} '/'];
filename=[fdir_data 'info4plot.txt'];
T=readtable(filename);
dt=datetime(T.Var1);
daynum=datenum(dt);


fdir=[froot fcase{k} '/'];

fname=sprintf('%.4d',files(k));
eta=load([fdir 'eta_' fname],'-ascii');
mask=load([fdir 'mask_' fname],'-ascii');
u=load([fdir 'u_' fname],'-ascii');
v=load([fdir 'v_' fname],'-ascii');
hs=load([fdir 'hs_' fname],'-ascii');
wdir=load([fdir 'wdir_' fname],'-ascii');

wx=cos(wdir*pi/180)*0.25;
wy=sin(wdir*pi/180)*0.25;

uu=sqrt(u.^2+v.^2);


[ux,uy]=gradient(u,1,1);
[vx,vy]=gradient(v,1,1);
ww=(uy-vx);

[n,m]=size(eta);

Dep=dep(1:n,1:m);
MASK=ones(size(mask));
MASK(eta+Dep<Mindep(k))=0;
hs(MASK<1)=NaN;
eta(MASK<1)=NaN;
u(MASK<1)=NaN;
v(MASK<1)=NaN;
ww(MASK<1)=NaN;
wx(MASK<1)=NaN;
wy(MASK<1)=NaN;

u(Dep<uv_deplimit)=NaN;
v(Dep<uv_deplimit)=NaN;

if k==4
Dtime=daynum+(files(k+1)-1)*DT/3600/24; % deal with the two hour data
else
Dtime=daynum+(files(k)-1)*DT/3600/24;
end

Dtime_datetime=datetime(Dtime,'ConvertFrom','datenum');
titledate=datestr(Dtime_datetime);

% elevation scale
%maxele=max(max(eta));
%minele=maxele-0.1;
cax_hs=[0 2.5];
cax_eta=[-0.5 2.5];


x0=X(1,1);
y0=Y(1,1);

if k==5 
eta=eta+1.3;
cax_eta=[-0.5+1.3 2.5+1.3];
else
cax_eta=[-0.5 2.5];
end


clf

plot([x0 x0],[y0 y0],'.r','MarkerSize',1)
%plot_google_map('maptype','satellite','APIKey','AIzaSyBeu2oRBtLClpcm4i2VDIXltuzMAOY5yX4')
hold on

b=pcolor(X,Y,eta),shading interp
%set(b,'FaceAlpha',0.8);
%set(b,'AlphaData',~isnan(hs))

%cbar=colorbar;
caxis(cax_eta)
%set(get(cbar,'ylabel'),'String',' Hs (m) ');

hold on

quiver(X(1:sky:end,1:skx:end),Y(1:sky:end,1:skx:end),u(1:sky:end,1:skx:end)*fac,v(1:sky:end,1:skx:end)*fac,0,'Color','k');

%xlabel('Lon(deg) ','fontsize',12,'fontweight','bold');
%ylabel('Lat(deg) ','fontsize',12,'fontweight','bold');
axis(xyaxis);
%title([case_name{k}  ' ( ' titledate ')'])

axis(xyaxis) % -76.3100  -76.2550   36.9400   36.9750
plot([xyaxis(1) xyaxis(2) xyaxis(2) xyaxis(1) xyaxis(1)],[xyaxis(3) xyaxis(3) xyaxis(4) xyaxis(4) xyaxis(3)],'r-')

% previous code
%axis tight
axis off
set(gca,'Position',[0 0 1.0 1.0]);
set(fig, 'PaperPositionMode', 'auto')
%print(gcf,'flood.png','-dpng','-r150'); % little higher than screen resolution
print(gcf,'flood.png','-dpng','-r0'); % screen resolution


% transparent
I=imread(['flood.png']);
G=rgb2gray(I);  
ima=imadjust(G);  
bw=im2bw(ima);     
%figure,imshow(bw)

% level=graythresh(G);
level=0.9;
bw2=im2bw(ima,level);
%figure,imshow(bw2);

bw3=~bw2;   
bw4 =bwareaopen(bw3, 20);
%bw4=imfill(~bw4,'hole');
%figure,imshow(bw4)

bw5=~bw4;
R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);


R(bw5)=255;
G(bw5)=255;
B(bw5)=255;
rgb=cat(3,R,G,B);   
%figure,imshow(rgb)


siz=size(I);
alpha=ones(siz(1),siz(2));
alpha(B==255)=0;    
output_name=[output_folder fcase{k} '_etauv' '.png'];
imwrite(rgb,output_name,'Alpha',alpha)


end






