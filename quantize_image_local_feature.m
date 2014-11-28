%%
%�������ܣ���ͼƬ�����������ôʵ��еĵ��ʱ�ʾͼƬ��
%���������ͼƬ����������ȡ�������
%����������õ�����ͼƬ��hog������һ��image��Ӧһ��_.s�ļ�����������ͼƬ��_.s�ļ���
%
%%
clc;
clear;

%%  ��ȡ�ļ�
local_feature_list = textread('local_feature_full_list.txt', '%s'); %��ȡlocal feature
len = size(local_feature_list);
len = len(1);
fprintf('len %d\n', len);

edge_list = textread('edge_full_list.txt', '%s');   %��ȡedge feature

%%  ��ȡvisual vocabulary
Mat = load('visual_vocabulary/vocabulary_2000.mat','C');
visual_vocabulary = Mat.C;
clear Mat;

%%
for i = 1:len
    %   ��ȡlocal feature
    local_feature_Path = local_feature_list{i};
    fprintf('%d local feature %s\n', i, local_feature_Path);
    image = load(local_feature_Path);
    local_feature = image.hog_feature;
    
    %   ��ȡedge feature
    edge_Path = edge_list{i};
%     fprintf('%d edge feature %s\n', i, edge_Path);
    edge = load(edge_Path);
    edge_feature = edge.a;
    
    [histogram] = quantize_local_feature(local_feature,edge_feature,visual_vocabulary);
    
    
    [filethstr, name, ext] = fileparts(local_feature_Path);
    str = strcat('local_feature_after_quantization/',name);
    filename = strcat(str,'_quan');
    save(filename,'histogram');   %   ����ÿһ����Ե��ȡ���ͼ��
    
end
%%
