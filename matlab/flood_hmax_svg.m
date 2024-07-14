clear all
close all

oldpath=path;
path('/Users/fengyanshi15/self_software/MATLAB/SVG/plot2svg_20120915/plot2svg_20120915',oldpath);

imm=imread('hmax_71.png');
imshow(imm);
plot2svg('mytrial.svg');


