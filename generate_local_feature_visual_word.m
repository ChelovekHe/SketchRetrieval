%
%�ű����ܣ��Ծ���local feture��ȡ����������о���
%������������е�local feature
%�����������������(���ʵ�)
%

%%
features_list = textread('local_feature_full_list.txt', '%s'); % local feature�б�
len = size(features_list);
len = len(1);
fprintf('len %d\n', len);

feature = zeros(10000000,36);   %�洢����local feature�ľ���
zero_feature = zeros(1,36);

fprintf('collecting feature');

count = 1;
for n = 1:len   % ��������local feature�ļ�
    if count~= 10000000
        memory
        count %��ӡ����ִ�н���
        featurePath = features_list{n};
        %         fprintf('%d processing %s\n', n, featurePath);
        local_feature = load(featurePath,'hog_feature');
        hog_feature = local_feature.hog_feature;
        for i=1:size(hog_feature,1)
            if hog_feature(i,:) ~= zero_feature
                feature(count,:) = hot_feature(i,:);
                count = count + 1;
            end
        end
        clear local_feature;
        clear hog_feature;
    end
end

fprintf('finished collecting feature');
%%  ����õ��ʵ�

% idx = kmeans(X,k),partition the observations of the n-by-p data matrix X into k clusters,
% and returns an n-by-1 vector (idx) containing cluster indices of each observation.
% Rows of X correspond to points and columns correspond to variables.
% By default, kmeans uses the squared Euclidean distance measure and the k-means++ algorithm for cluster center initialization.
% ����X��ÿһ�д���һ���㣬ÿһ�д���ÿ����ı���
%
[IDX,C] = kmeans(feature,200,'MaxIter',100); % ����������kmeans���࣬�������ĸ�����ʵ��Ч��ȷ����I_3Ϊ�������50Ϊ�������ĸ�����100Ϊ���ĵ���������
filename = strcat('visual vocabulary/',vocabulary);
save(filename,'IDX','C');   %   �������ɵĴʵ�






