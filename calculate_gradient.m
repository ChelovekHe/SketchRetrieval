clear all;clc;

I = imread('bird1.jpg');
I = imresize(I,[256 256]);
I = rgb2gray(I);

fy=[-1 0 1];        %���崹ֱ�����ݶ�ģ��
fx=fy';             %����ˮƽ�����ݶ�ģ��

imshow(I);

Gy=imfilter(I,fy,'replicate');    %���㴹ֱ�����ݶ�
Gx=imfilter(I,fx,'replicate');    %����ˮƽ�����ݶ�
Ged=sqrt(double(Gx.^2+Gy.^2));    %�����ݶȷ�ֵ
edge_orientation = atan2(double(Gy), double(Gx)) / pi * 180; %�����ݶȷ���