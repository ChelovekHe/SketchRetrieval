%%
%�������ܣ�����������sketch���Ƶ�ͼƬ
%���������sketch��ַ
%����������õ�����ͼƬ
%

%%
function [retrieval_result] =retrieval(sketchPath)


%%  ****************************��sketch����Ԥ����**********************************************************
fprintf('��sketchԤ���� \n');
[sketch_after_processing] = sketch_processing(sketchPath);

%%  ****************************��sketch��ȡlocal feature****************************************************
fprintf('��sketch��ȡlocal feature \n');
[sketch_local_feature] = feature_extraction_local(sketch_after_processing);

%%  ****************************��sketch��lcoal feature��������******************************************
fprintf('��sketch��local feature�������� \n');
Mat = load('visual_vocabulary/vocabulary.mat','C'); %  ��ȡvisual vocabulary
visual_vocabulary = Mat.C;
clear Mat;

[sketch_histogram] = quantize_local_feature(sketch_local_feature,sketch_after_processing,visual_vocabulary);

%%  ******************************����sketch�ķָ����*****************************************************
fprintf('����sketch�ķָ����\n');
cell_percent = 0.2; %   ������������
image_percent = 0.2;%   ������������

[sketch_D,sketch_D1,sketch_D2,sketch_D3,sketch_D4,sketch_D5] = divide_function(sketch_after_processing,cell_percent,image_percent);

%%  ******************************����sketch��global feature*************************************************
fprintf('����sketch��global feature \n');
[sketch_global_feature] = feature_extraction_global(sketch_after_processing,sketch_D,sketch_D1,sketch_D2,sketch_D3,sketch_D4,sketch_D5);

%%  *******************************����sketch������[global feture,local feature]****************************************

fprintf('����sketch������ \n');

sketch_global_feature
sketch_histogram

%%  *********************************ѭ������ÿһ��image**********************************************************************

fprintf('ѭ������ÿһ��ͼ���ƥ��ֵ\n');

%  ��ȡ�ļ�
local_feature_list = textread('local_feature_after_quantization_list.txt', '%s'); %��ȡ�������local feature
len = size(local_feature_list);
len = len(1);
fprintf('len %d\n', len);

edge_list = textread('edge_full_list.txt', '%s');   %��ȡedge feature

%   �������
retrieval_result = zeros()

for i = 1:len
    %   ��ȡimage��local feature
    local_feature_Path = local_feature_list{i};
    fprintf('%d local feature %s\n', i, local_feature_Path);
    image = load(local_feature_Path);
    local_feature = image.hog_feature;
    
    %   ��ȡimage��edge feature
    edge_Path = edge_list{i};
    fprintf('%d edge feature %s\n', i, edge_Path);
    edge = load(edge_Path);
    edge_feature = edge.a;
    
    %   ����sketch�ķָ��������image��global feature
    %   ����ԭ�ͣ�function [G1,G2,G3,G4,G5] = feature_extraction_global(image,D1,D2,D3,D4,D5)
    [G1,G2,G3,G4,G5] = feature_extraction_global(edge_feature,sketch_D1,sketch_D2,sketch_D3,sketch_D4,sketch_D5);
    
    %   ����image������[global feature,local feature]
    
    
    %   ����sketch��image��ƥ���������¼ƥ��ֵ
    [similarity] = calculate_matching_cost(sketch_feature,image_feature,sketch_D,sketch_D1,sketch_D2,sketch_D3,sketch_D4,sketch_D5);
    
    
    %   [filethstr, name, ext] = fileparts(local_feature_Path);
    [~, name, ~] = fileparts(local_feature_Path);
    
    %����ÿһ��image,��Ҫ��¼[similarity , name]
    retrieval_result
    
end

fprintf('����ƥ���� \n');

end % end of function




