%
%�������ܣ���ͼƬ�����������ôʵ��еĵ��ʱ�ʾͼƬ��
%���������ͼƬ����������ȡ������ݡ�
%����������õ�����ͼƬ�ľ����������������һ��image��Ӧһ��.mat�ļ���
%

function [histogram] = quantize_local_feature(local_feature,edge_feature,visual_vocabulary)

% local_feature:65536*36
% edge_feature:256*256
% visual_vocabulary:2000*36

%% **********************************************************************************************************************
%   ����local featureʱֻ������edge feature�е���Ȥ�㣨ֵΪ����ĵ㣩
%   ͬ������local featureʱҲֻ��Ҫ����������local feature����Ȥ�㼴��
%% **********************************************************************************************************************

%PDIST2 Pairwise distance between two sets of observations.
%   D = PDIST2(X,Y) returns a matrix D containing the Euclidean distances
%   between each pair of observations in the MX-by-N data matrix X and
%   MY-by-N data matrix Y. Rows of X and Y correspond to observations,
%   and columns correspond to variables. D is an MX-by-MY matrix, with the
%   (I,J) entry equal to distance between observation I in X and
%   observation J in Y.


%% Ϊ�˼��㷽�㣬���� edge_feature:256*256����> 1*65536
% A =
%
%      1     2     3     4
%      5     6     7     8
%      9    10    11    12
%     13    14    15    16
%
% reshape(A',1,[])
% ans =
%
%      1     2     3     4     5     6     7     8     9    10    11    12    13    14    15    16
edge_feature = reshape(edge_feature',1,[]);

%%
histogram = zeros(1,size(visual_vocabulary,1));

%%
for i=1:size(edge_feature,2)
    %     fprintf('%d \n', i);
    if edge_feature(i)~=0  %����ǰ��Ϊ��Ȥ��
        E = pdist2(local_feature(i,:),visual_vocabulary); %  E��65536*2000
        [~,I] = min(E,[],2); % IΪ��������ĵ��ʵ�������1~2000�е�ĳһ����
        histogram(i) = I; % ��¼��ǰ��Ȥ���������������
    else
        histogram(i) = 0;
    end
end



%%
end % end of function