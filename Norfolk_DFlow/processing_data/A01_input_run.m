clear all
close all

root_folder='/Users/fyshi/ESTCP_MAPS/IR_Web_Export/';
output_folder='../saved_images/';

cases={'SLR_1.3m'};

baseline=['Baseline/'];


file_name_Dep='Water_depth_mesh2d_nFaces_mean.shp';
file_name_Dep_ini='Water_depth_mesh2d_nFaces_mean_ini.shp';
file_name_WL='WL_mesh2d_nFaces_mean_max.shp';

k=1;
WL=shaperead([root_folder cases{k} '/' file_name_WL]);
Dep=shaperead([root_folder cases{k} '/' file_name_Dep]);
Dep_ini=shaperead([root_folder cases{k} '/' file_name_Dep_ini]);

axy=[-76.34 -76.245 36.930 36.970];
alpha=0.8;
ycut=36.9328;

% -- draw
B01_draw_poly
C01_make_image