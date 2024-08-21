
clear all
close all

%addpath('/Users/fengyanshi/OUTSIDE_Google/things');

output_folder='../saved_images/';
froot='/Users/fyshi/ESTCP_MAPS/FUNWAVE_Data/';
fcase={'R1_smdm','R2_smdm','R3_smdm','R4_smdm','R5_smdm','R6_smdm'};
case_name={'ERA5','HM','Acc GN 1m','RMW F1.25','SLR 1.3m','WSF 1.225'};
%fcase={'R1_smdm'};
%case_name={'ERA5'};


files=[30];
dt=100.0;

ax=[-76.3 -76.246 36.94 36.975];
cax=[-0.5 1.15];
Mindep=0.1;
uv_deplimit = 0.2;

% read info

m=7744;
n=5888;

DimsX={[m n]};
% ---------------
% load x and y 
load([froot 'depth/' 'lon_lat_7744x5888.mat']);
x=lon_sm;
y=lat_sm;
load([froot 'depth/' 'dep.mat']);
% --------------

x0=x(1,1);
y0=y(1,1);

sk=2;


wid=10;
len=8;
%set(fig,'units','inches','paperunits','inches','papersize', [wid len],'position',[1 1 wid len],'paperposition',[0 0 wid len]);


numb=files(1);

fnum=sprintf('%.5d',numb);

for k=1:length(fcase)
% read files -----------------------


fig=figure(1);
colormap jet
clf

fdir=[froot fcase{k} '/'];

fname=[fdir 'eta_' fnum];
fileID=fopen(fname);
eta=fread(fileID,DimsX{1},'*single');
fclose(fileID);
eta=eta';

fname=[fdir 'mask_' fnum];
fileID=fopen(fname);
mask=fread(fileID,DimsX{1},'*single');
fclose(fileID);
mask=mask';

MASK0=ones(size(mask));
MASK0(dep<0)=0;

MASK=mask;


floodmask=MASK-MASK0;
floodmask_c=floodmask;

floodmask(floodmask<1)=NaN;

%plot([x0 x0+0.03],[y0 y0+0.04],'.r','MarkerSize',1)
%hold on


b=pcolor(x(1:sk:end,1:sk:end),y(1:sk:end,1:sk:end),floodmask(1:sk:end,1:sk:end)),shading flat

caxis(cax)
axis(ax)

% range ax=[-76.3 -76.246 36.94 36.975];

% previous code ----------
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
output_name=[output_folder fcase{k} '_flood' '.png'];
imwrite(rgb,output_name,'Alpha',alpha)

end






