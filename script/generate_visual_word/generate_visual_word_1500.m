
%%
%�ű����ܣ���local feture���о���õ�visual vocabulary
%���������һ��local feature�ļ���ȥ��������ȫ0����
%�����������������(���ʵ�)
%

%%  ����õ��ʵ�

% idx = kmeans(X,k),partition the observations of the n-by-p data matrix X into k clusters,
% and returns an n-by-1 vector (idx) containing cluster indices of each observation.
% Rows of X correspond to points and columns correspond to variables.
% By default, kmeans uses the squared Euclidean distance measure and the k-means++ algorithm for cluster center initialization.
% ����X��ÿһ�д���һ���㣬ÿһ�д���ÿ����ı���
%
clc;
clear;

local_feature = load('visual_vocabulary/feature.mat');
feature = local_feature.feature;

fprintf('start to kmeans\n');

[IDX,C] = kmeans(feature,1500,'MaxIter',100, 'Emptyaction','singleton'); % ����������kmeans���࣬�������ĸ�����ʵ��Ч��ȷ����I_3Ϊ�������50Ϊ�������ĸ�����100Ϊ���ĵ���������

fprintf('finished kmenas\n');

filename = strcat('visual_vocabulary/','vocabulary_1500');
save(filename,'IDX','C');   %   �������ɵĴʵ�






