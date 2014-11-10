%
%�������ܣ�����ͼ����ݶȴ�С�Լ��ݶȷ���
%���������ͼ��
%���������ͼ����ݶȴ�С���ݶȷ���
%

function [G_x,G_y,G_magnitude,edge_orientation] = calculate_gradient(imgPath)

I = imread(imgPath);
I = imresize(I,[64 64]);
% I = rgb2gray(I);

fy=[-1 0 1];        %���崹ֱ�����ݶ�ģ��
fx=fy';             %����ˮƽ�����ݶ�ģ��

imshow(I);

G_y=imfilter(I,fy,'replicate');    %���㴹ֱ�����ݶ�
G_x=imfilter(I,fx,'replicate');    %����ˮƽ�����ݶ�
G_magnitude=sqrt(double(G_x.^2+G_y.^2));    %�����ݶȷ�ֵ
edge_orientation = atan2(double(G_y), double(G_x)) / pi * 180; %�����ݶȷ���