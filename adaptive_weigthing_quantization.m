function [ output_args ] = adaptive_weigthing_quantization(local_feature,edge_feature,visual_vocabulary,window_size,paramater_orientation,paramater_distance )
%ADAPTIVE_WEIGTHING_QUANTIZATION �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��


% local_feature:65536*36
% edge_feature:256*256
% visual_vocabulary:2000*36
% histogram:1*65536(ÿһ��ֵ��ʾ�ʵ��е�ĳһ������)

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

%% �����ݶ�ֵ

[~,~,~,gradient_orientation] = calculate_gradient(edge_feature); %���ص���һ��256*256���󣬾����е�Ԫ�ص�ֵ���ݶȵķ���
edge_map = edge_feature; % һ��256*256�ľ���
codebook = visual_vocabulary; %һ��N*36ά�ľ���

local_feature_index_matrix = zeros(1,size(local_feature,2));
for k = 1:size(local_feature,2)
    local_feature_index_matrix(k)=k;
end
local_feature_index_matrix = reshape(local_feature_index_matrix',[256 256]);
%%

%% ��¼�������������256*256�ľ���
histogram = zeros(size(edge_feature,1), size(edge_feature,2));

%%
for i=1:size(edge_map,1)
    for j=1:size(edge_map,2)
        %     fprintf('%d \n', i);
        if edge_map(i,j)~=0     %����ǰ��Ϊ��Ȥ��,���㵱ǰ���local featureӦ�ñ�����Ϊ�ĸ�codeword
            
            %% ���㴰�ڴ�С
            row_start = i-window_size; %��ʼ��
            if(row_start<1)
                row_start=1;
            end
            
            row_end = i+window_size; %��ֹ��
            if(row_end>size(gradient_orientation,1))
                row_end=size(gradient_orientation,1);
            end
            
            column_start = j-window_size;%��ʼ��
            if(column_start<1)
                column_start=1;
            end
            
            column_end = j+window_size;%��ֹ��
            if(column_end>size(gradient_orientation,2))
                column_end=size(gradient_orientation,2);
            end
            
            %% ����ݶȷ������һ�����ڴ�С
            gradient_orientation_matrix = gradient_orientation(row_start:row_end,column_start:column_end);
            
            %% �����ݶȷ���������һ�����ڴ�С
            % ���µĴ����У���ǰ��Ȥ�������Ϊ����i-row_start+1,j-colume_start+1��
            row_index =  i-row_start+1;
            column_index = j-column_start+1;
            
            gradient_orientation_distance_matrix =zeros(size(gradient_orientation,1),size(gradient_orientation,2));
            for m=1:size(gradient_orientation,1)
                for n=1:size(gradient_orientation,2)
                    %�����ݶȷ����ֵ:�����ֵ��ƽ�����û��ȼ��㣩
                    gradient_orientation_distance_matrix(m,n)= ((gradient_orientation_matrix(m,n) - gradient_orientation_matrix(row_index,column_index))/(2*pi))^2;
                end
            end
            
            %% ������Ȥ��������һ�����ڴ�С
            distance_matrix = zeros(size(gradient_orientation,1),size(gradient_orientation,2));
            for m=1:size(gradient_orientation,1)
                for n=1:size(gradient_orientation,2)
                    %��������ֵ������������ֵ��ƽ��
                    distance_matrix(m,n)=(m-row_index)^2 +(n-column_index)^2;
                end
            end
            
            %% ����Ȩ�ؾ���һ�����ڴ�С
            weigthing_matrix = zeros(size(gradient_orientation,1),size(gradient_orientation,2));
            for m=1:size(gradient_orientation,1)
                for n=1:size(gradient_orientation,2)
                    weigthing_matrix(m,n)=( exp(-gradient_orientation_distance_matrix(m,n)/(paramater_orientation^2)) * exp(-distance_matrix(m,n)/(paramater_distance^2)))/N;
                    %��������ֵ:paramater_orientation��paramater_distance�ǹ�ʽ�е�����������N��һ��������
                end
            end
            
            %% ��ȡ��Ե����:һ�����ڴ�С
            edge_map_matrix_window = edge_map(row_start:row_end,column_start:column_end);
            
            %% ��ȡ�ֲ�������������һ�����ڴ�С
            local_feature_index_matrix_window = local_feature_index_matrix(row_start:row_end,column_start:column_end);
            
            %% ��������
            codeword_index = quantize_local_feature(weigthing_matrix,local_feature_index_matrix_window,edge_map_matrix_window);
            %% ��¼codeword��������
            histogram(i,j) = codeword_index; % ��¼��ǰ��Ȥ���������������
            
            
        else
            histogram(i,j) = 0;  %����Ȥ�㲻��Ҫ��������ֱ�ӱ�ʶΪ0
        end
    end
end


    function [distance] = quantize_local_feature(weigthing_matrix,local_feature_index_matrix_window,edge_map_matrix_window)
        
        
        % ���㴰���е�ֵ����to do list
        E = pdist2(local_feature(i,:),visual_vocabulary); %  E��65536*2000
        [~,I] = min(E,[],2); % IΪ��������ĵ��ʵ�������1~2000�е�ĳһ����
        
    end

end

