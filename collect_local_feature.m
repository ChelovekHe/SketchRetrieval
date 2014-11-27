%%
%�ű����ܣ��Ծ���local feture��ȡ����������о���
%������������е�local feature
%�����������������(���ʵ�)
%

%%
clc;
clear;

%%
features_list = textread('local.txt', '%s'); % local feature�б�
len = size(features_list);
len = len(1);
fprintf('len %d\n', len);

feature = zeros(10000,36);   %�洢����local feature�ľ���
zero_feature = zeros(1,36);
fprintf('start collecting feature \n');

count = 1;
for n = 1:len   % ��������local feature�ļ�
        fprintf('���ڶ�ȡ�� %d ���ļ�\n',n);
        featurePath = features_list{n};
        local_feature = load(featurePath,'hog_feature');
        hog_feature = local_feature.hog_feature;
        for i=1:size(hog_feature,1)
            if hog_feature(i,:) ~= zero_feature
                feature(count,:) = hog_feature(i,:);
                count = count + 1;
            end
        end
        clear local_feature;
        clear hog_feature;
end   % end of for n=1:len

fprintf('finished collecting feature \n');
filename = strcat('visual_vocabulary/','feature');
save(filename,'feature');   %   ����feature