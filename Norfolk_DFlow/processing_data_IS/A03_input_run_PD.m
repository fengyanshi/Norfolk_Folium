clear all
close all

root_folder='/Users/fyshi/ESTCP_MAPS/IS_Web_Export/';
output_folder='../saved_images/';

cases={'IS_PD_0.88','IS_PD_0.76','IS_PD_0.64'};

for k=1:length(cases)

baseline=['IS_Baseline/'];


file_name_Dep='Water_depth_mesh2d_nFaces_mean_max.shp';
file_name_Dep_ini='Water_depth_mesh2d_nFaces_mean_ini.shp';
file_name_WL='WL_mesh2d_nFaces_mean_max.shp';

WL=shaperead([root_folder cases{k} '/' file_name_WL]);
Dep=shaperead([root_folder cases{k} '/' file_name_Dep]);
Dep_ini=shaperead([root_folder baseline file_name_Dep_ini]);

axy=[-76.34 -76.245 36.930 36.970];
%axy=load('dflow_block.txt');
alpha=0.8;
ycut=36.9328;

% -- draw
B01_draw_poly
C01_make_image
end