
N=length(WL);
for i=1:N
 WL_poly(i)=WL(i).Val_1;
 Dep_poly(i)=Dep(i).Val_1;
 Dep_ini_poly(i)=Dep_ini(i).Val_1;
 Y(i)=WL(i).Y(1);
 X(i)=WL(i).X(1);
end 


clf
fig=figure(1);
colormap jet

% >1.0， extreme (p11), high 0.5-1.0, medium 0.25-0.5, low 0.1-0.25
icount =0;
for i=1:N
 if Dep_ini_poly(i)<=0.0 && Dep_poly(i)>=1.0 && Y(i) > axy1(3) && Y(i) < axy1(4) && X(i) > axy1(1) && X(i) < axy1(2) 
   icount=icount+1;
 lon(1:4,icount)=WL(i).X(1:4);
 lon(5,icount)=WL(i).X(1);
 lat(1:4,icount)=WL(i).Y(1:4);
 lat(5,icount)=WL(i).Y(1);
end 
end

if icount > 0
Nf=size(lon,2);
for i=1:Nf
hold on
fill(lon(:,i),lat(:,i),'r','EdgeColor','none')
end
end

% 0.5 1.0
clear lon lat
icount =0;
for i=1:N
 if Dep_ini_poly(i)<=0.0 && Dep_poly(i)<1.0 && Dep_poly(i)>=0.5 && Y(i) > axy1(3) && Y(i) < axy1(4) && X(i) > axy1(1) && X(i) < axy1(2)
   icount=icount+1;
 lon(1:4,icount)=WL(i).X(1:4);
 lon(5,icount)=WL(i).X(1);
 lat(1:4,icount)=WL(i).Y(1:4);
 lat(5,icount)=WL(i).Y(1);
end 
end

if icount > 0
Nf=size(lon,2);
for i=1:Nf
hold on
fill(lon(:,i),lat(:,i),[0 0.4470 0.7410],'EdgeColor','none')
end
end

% 0.25 0.5
clear lon lat
icount =0;
for i=1:N
 if Dep_ini_poly(i)<=0.0 && Dep_poly(i)<0.5 && Dep_poly(i)>=0.25 && Y(i) > axy1(3) && Y(i) < axy1(4) && X(i) > axy1(1) && X(i) < axy1(2)
   icount=icount+1;
 lon(1:4,icount)=WL(i).X(1:4);
 lon(5,icount)=WL(i).X(1);
 lat(1:4,icount)=WL(i).Y(1:4);
 lat(5,icount)=WL(i).Y(1);
end 
end

if icount > 0
Nf=size(lon,2);
for i=1:Nf
hold on
fill(lon(:,i),lat(:,i),[0.9290 0.6940 0.1250],'EdgeColor','none')
end
end

% 0.1 0.25
clear lon lat
icount =0;
for i=1:N
 if Dep_ini_poly(i)<=0.0 && Dep_poly(i)<=0.25 && Dep_poly(i)>=0.1 && Y(i) > axy1(3) && Y(i) < axy1(4) && X(i) > axy1(1) && X(i) < axy1(2)
   icount=icount+1;
 lon(1:4,icount)=WL(i).X(1:4);
 lon(5,icount)=WL(i).X(1);
 lat(1:4,icount)=WL(i).Y(1:4);
 lat(5,icount)=WL(i).Y(1);
end 
end

if icount > 0
Nf=size(lon,2);
for i=1:Nf
hold on
fill(lon(:,i),lat(:,i),'g','EdgeColor','none')
end
end

%axis(axy)
plot([axy1(1) axy1(2) axy1(2) axy1(1) axy1(1)],[axy1(3) axy1(3) axy1(4) axy1(4) axy1(3)],'r-')

% previous code
axis tight
axis off
set(gca,'Position',[0 0 1.0 1.0]);
set(fig, 'PaperPositionMode', 'auto')
%print(gcf,'flood.png','-dpng','-r150'); % little higher than screen resolution
print(gcf,'flood.png','-dpng','-r0'); % screen resolution








