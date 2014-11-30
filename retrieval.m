%%
%�������ܣ�����������sketch���Ƶ�ͼƬ
%���������sketch��ַ
%����������õ�����ͼƬ
%

%%
% function [retrieval_result] =retrieval(sketchPath)

function [retrieval_result,sketch_edge_feature,sketch_local_feature_before_quantization,sketch_local_feature,sketch_D1,sketch_D2,sketch_D3,sketch_D4,sketch_D5,sketch_G1,sketch_G2,sketch_G3,sketch_G4,sketch_G5,image_local_feature,image_edge_feature,image_G1,image_G2,image_G3,image_G4,image_G5] =retrieval(sketchPath)
    
%%  ****************************��sketchԤ����õ�edge feature**********************************************************
fprintf('1.��sketchԤ���� \n');
[sketch_edge_feature] = sketch_processing(sketchPath);

%%  ****************************��sketch��ȡlocal feature****************************************************
fprintf('2.��sketch��ȡlocal feature \n');
[sketch_local_feature_before_quantization] = feature_extraction_local(sketch_edge_feature);

%%  ****************************��sketch��lcoal feature��������******************************************
fprintf('3.��sketch��local feature�������� \n');
Mat = load('visual_vocabulary/vocabulary_2000.mat','C'); %  ��ȡvisual vocabulary
visual_vocabulary = Mat.C;
clear Mat;

%sketch_histogram��һ��1*65536�ľ���(ÿһ��ֵ��ʾ�ʵ��е�ĳһ������)
[sketch_local_feature] = quantize_local_feature(sketch_local_feature_before_quantization,sketch_edge_feature,visual_vocabulary);

%%  ******************************����sketch�ķָ����*****************************************************
fprintf('4.����sketch�ķָ����\n');
cell_percent = 0.2; %   ������������
image_percent = 0.2;%   ������������

[~,sketch_D1,sketch_D2,sketch_D3,sketch_D4,sketch_D5] = divide_function(sketch_edge_feature,cell_percent,image_percent);

%%  ******************************����sketch��global feature*************************************************
fprintf('5.����sketch��global feature \n');
[sketch_G1,sketch_G2,sketch_G3,sketch_G4,sketch_G5] = feature_extraction_global(sketch_edge_feature,sketch_D1,sketch_D2,sketch_D3,sketch_D4,sketch_D5);

%%  *******************************����sketch������[global feture,local feature]****************************************

fprintf('6.����sketch������ \n');
% local feature:һ��1*65536�ľ���(ÿһ��ֵ��ʾ�ʵ��е�ĳһ������)
% sketch_local_feature;
% global fature:G1,G2,G3,G4,G5
% sketch_G1,sketch_G2,sketch_G3,sketch_G4,sketch_G5;

%% *******************************************************************************************************


%%  *********************************ѭ������ÿһ��image**********************************************************************

fprintf('7.ѭ������ÿһ��ͼ���ƥ��ֵ\n');

%%  ��ȡͼ���local feature�ļ�
image_local_feature_list = textread('local_feature_after_quantization_list_test.txt', '%s'); %��ȡ�������local feature
len = size(image_local_feature_list);
len = len(1);
fprintf('len %d\n', len);
%%  ��ȡͼ��ı�Եͼ���ļ�
image_edge_list = textread('edge_full_list_test.txt', '%s');   %��ȡedge feature

%%  ************************��¼�������********************************************
retrieval_result = zeros(2,len); %��һ�м�¼ƥ��ֵ���ڶ��м�¼��Ӧ��image_id
%% ********************************************************************************

for i = 1:len
    %%   ��ȡimage��local feature
    local_feature_Path = image_local_feature_list{i};
    fprintf('%d local feature %s\n', i, local_feature_Path);
    image = load(local_feature_Path);
    image_local_feature = image.histogram; % image_local_feature:һ��1*65536�ľ���(ÿһ��ֵ��ʾ�ʵ��е�ĳһ������)
    
    %%   ��ȡimage��edge feature
    edge_Path = image_edge_list{i};
    fprintf('%d edge feature %s\n', i, edge_Path);
    edge = load(edge_Path);
    image_edge_feature = edge.a; % image_edge_feature:һ��256*256�ľ���(ÿһ������ֵ����ͼ���Ե)
    
    %%   ����sketch�ķָ��������image��global feature
     %    ����ԭ�ͣ�function [G1,G2,G3,G4,G5] = feature_extraction_global(image,D1,D2,D3,D4,D5)
    [image_G1,image_G2,image_G3,image_G4,image_G5] = feature_extraction_global(image_edge_feature,sketch_D1,sketch_D2,sketch_D3,sketch_D4,sketch_D5);
    
    %% ***************************����image������[global feature,local feature]***************
     % local feature:һ��1*65536�ľ���(ÿһ��ֵ��ʾ�ʵ��е�ĳһ������)
     % image_local_feature;
     % global feature:image_G1,image_G2,image_G3,image_G4,image_G5
     % image_G1,image_G2,image_G3,image_G4,image_G5;
     
    %%   ����sketch��image��ƥ���������¼ƥ��ֵ
    [similarity] = calculate_matching_cost(sketch_local_feature,image_local_feature,sketch_G1,sketch_G2,sketch_G3,sketch_G4,sketch_G5,image_G1,image_G2,image_G3,image_G4,image_G5,sketch_D1,sketch_D2,sketch_D3,sketch_D4,sketch_D5);
       
    %   [filethstr, name, ext] = fileparts(local_feature_Path);
    [~, name, ~] = fileparts(local_feature_Path); % nameΪ��1000004_edge_local_quan.mat��������ʽ
    
    image_id = str2double(strrep(name,'_edge_local_quan',''));
   
    %% ����ÿһ��image,��Ҫ��¼[similarity , name]
    retrieval_result(1,i) = similarity;
    retrieval_result(2,i) = image_id;
    
    
end

fprintf('8.����ƥ���� \n');

end % end of function




