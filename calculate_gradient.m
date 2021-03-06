%
%函数功能：计算图像的梯度
%输入参数：图像的地址
%输出参数：图像X方向的梯度，Y方向的梯度，梯度的幅度，梯度的方向
%
%% 返回的是一个矩阵


%%
function [edge_orientation] = calculate_gradient(image)

I = image;
% I = imread(imgPath);
% I = imresize(I,[64 64]);
% I = rgb2gray(I);

fy=[-1 0 1];        %定义垂直方向梯度模板
fx=fy';             %定义水平方向梯度模板

% imshow(I);

G_y=imfilter(I,fy,'replicate');    %计算垂直方向梯度
G_x=imfilter(I,fx,'replicate');    %计算水平方向梯度
G_magnitude=sqrt(double(G_x.^2+G_y.^2));    %计算梯度幅值
edge_orientation = atan2(double(G_y), double(G_x)) / pi * 180; %计算梯度方向

end