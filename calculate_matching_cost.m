function   [similarity_1,similarity_2,similarity_3,similarity_4,similarity_5] = calculate_matching_cost(sketch_local_feature,image_local_feature,sketch_G1,sketch_G2,sketch_G3,sketch_G4,sketch_G5,image_G1,image_G2,image_G3,image_G4,image_G5,sketch_D1,sketch_D2,sketch_D3,sketch_D4,sketch_D5);

%%  CALCULATE_MATCHING_COST �˴���ʾ�йش˺�����ժҪ
%   �ű����ܣ�����sketch��image��ƥ��ֵ
%   ���������
%%     local_feature����ʽ��:   һ��1*65536�ľ���(ÿһ��ֵ��ʾ�ʵ��е�ĳһ������)
%       sketch��local_feature:   sketch_local_feature
%       image��local_feature:    image_local_feature

%%     global feature����ʽ��   G1 = mat2cell(image,[128 128],[128 128]);% ������һ�����Ȥ���global feature��ֵ
%       sketch��global feature:  sketch_G1,sketch_G2,sketch_G3,sketch_G4,sketch_G5
%       image��global feature:   image_G1,image_G2,image_G3,image_G4,image_G5

%%     sketch�ķָ��������ʽ��һ������
%       sketch�ķָ����: sketch_D1,sketch_D2,sketch_D3,sketch_D4,sketch_D5

%   ���������
%       sketch��image��ƥ��ֵ

%%  ����local feature

sketch_local_feature = reshape(sketch_local_feature,256,[])';   %sketch��local feature:256*256
image_local_feature = reshape(image_local_feature,256,[])';     %image��local feature:256*256

%% *****************************�����1���ƥ��ֵ��2*2   ***************************************
% sketch:sketch_local_feature,sketch_G1
% image:image_local_feature,image_G1
%
fprintf('�����1���ƥ��ֵ \n');
sketch_local_feature_1 = mat2cell(sketch_local_feature,[128 128],[128 128]);
image_local_feature_1 = mat2cell(image_local_feature,[128 128],[128 128]);

similarity_1 = 0; %��¼��1���ƥ��ֵ
for i=1:2
    for j=1:2
        if sketch_D1(i,j)==0    %D(i,j)=0����ʾ��Ҫ�������cell�е���Ȥ���ƥ��ֵ
            [result] = similarity_calculate_per_cell(sketch_local_feature_1{i,j},image_local_feature_1{i,j},sketch_G1{i,j},image_G1{i,j});
            similarity_1 = similarity_1+result;
        end
    end
end


%% *****************************�����2���ƥ��ֵ��4*4   ***************************************

fprintf('�����2���ƥ��ֵ \n');
sketch_local_feature_2 = mat2cell(sketch_local_feature,[64 64 64 64],[64 64 64 64]);
image_local_feature_2 = mat2cell(image_local_feature,[64 64 64 64],[64 64 64 64]);

similarity_2 = 0; %��¼��2���ƥ��ֵ
for i=1:4
    for j=1:4
        if sketch_D2(i,j)==0    %D(i,j)=0����ʾ��Ҫ�������cell�е���Ȥ���ƥ��ֵ
            [result] = similarity_calculate_per_cell(sketch_local_feature_2{i,j},image_local_feature_2{i,j},sketch_G2{i,j},image_G2{i,j});
            similarity_2 = similarity_2+result;
        end
    end
end


%% *****************************�����3���ƥ��ֵ��8*8   ***************************************

fprintf('�����3���ƥ��ֵ \n');
sketch_local_feature_3 = mat2cell(sketch_local_feature,[32 32 32 32 32 32 32 32],[32 32 32 32 32 32 32 32]);
image_local_feature_3 = mat2cell(image_local_feature,[32 32 32 32 32 32 32 32],[32 32 32 32 32 32 32 32]);

similarity_3 = 0; %��¼��һ���ƥ��ֵ
for i=1:8
    for j=1:8
        if sketch_D3(i,j)==0    %D(i,j)=0����ʾ��Ҫ�������cell�е���Ȥ���ƥ��ֵ
            [result] = similarity_calculate_per_cell(sketch_local_feature_3{i,j},image_local_feature_3{i,j},sketch_G3{i,j},image_G3{i,j});
            similarity_3 = similarity_3+result;
        end
    end
end


%% *****************************�����4���ƥ��ֵ��16*16 ***************************************
fprintf('�����4���ƥ��ֵ \n');
sketch_local_feature_4 = mat2cell(sketch_local_feature,[16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16],[16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16]);
image_local_feature_4 = mat2cell(image_local_feature,[16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16],[16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16]);

similarity_4 = 0; %��¼��һ���ƥ��ֵ
for i=1:16
    for j=1:16
        if sketch_D4(i,j)==0    %D(i,j)=0����ʾ��Ҫ�������cell�е���Ȥ���ƥ��ֵ
            [result] = similarity_calculate_per_cell(sketch_local_feature_4{i,j},image_local_feature_4{i,j},sketch_G4{i,j},image_G4{i,j});
            similarity_4 = similarity_4+result;
        end
    end
end


%% *****************************���������ƥ��ֵ��32*32 ***************************************

fprintf('�����5���ƥ��ֵ \n');
sketch_local_feature_5 =  mat2cell(sketch_local_feature,[8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8],[8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8]);
image_local_feature_5 =  mat2cell(image_local_feature,[8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8],[8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8]);

similarity_5 = 0; %��¼��һ���ƥ��ֵ
for i=1:32
    for j=1:32
        if sketch_D5(i,j)==0    %D(i,j)=0����ʾ��Ҫ�������cell�е���Ȥ���ƥ��ֵ
            [result] = similarity_calculate_per_cell(sketch_local_feature_5{i,j},image_local_feature_5{i,j},sketch_G5{i,j},image_G5{i,j});
            similarity_5 = similarity_5+result;
        end
    end
end


end %end of function

%% ƥ��ֵ���㺯��
function  [similarity_value] = similarity_calculate_per_cell(sketch_local_feature,image_local_feature,sketch_global_feature,image_global_feature)
%�����4����������N*N����ʽ����128*128,64*64,32*32��16*16��8*8

sketch_global_feature = sketch_global_feature+1; %��global feature��ȡֵ��Χ��0~63��Ϊ1~64
image_global_feature = image_global_feature+1;   %��global feature��ȡֵ��Χ��0~63��Ϊ1~64

%% *********************��image��sketch�����������ֱ��ͼ����ʽ*************************************************

% ����2000Ϊ�ʵ�Ĵ�С��histogram(i,j)��ʾglobal featureΪi,local featureΪj��feature�ĸ���
histogram_sketch = zeros(64,2000);
histogram_image = zeros(64,2000);
len = size(sketch_local_feature,1);

%����sketch
for i=1:len
    for j=1:len
        if sketch_local_feature(i,j)>0 %ֻ������Ȥ��
            histogram_sketch(sketch_global_feature(i,j),sketch_local_feature(i,j)) =  histogram_sketch(sketch_global_feature(i,j),sketch_local_feature(i,j))+1;
        end
    end
end


%����image
for i=1:len
    for j=1:len
        if image_local_feature(i,j)>0 %ֻ������Ȥ��
            histogram_sketch(image_global_feature(i,j),image_local_feature(i,j)) =  histogram_image(image_global_feature(i,j),image_local_feature(i,j))+1;
        end
    end
end

%����ƥ��ֵ
similarity_value = 0;
for i=1:64
    for j=1:2000 %��Ҫ���ݴʵ��С�޸�
        similarity_value =  similarity_value+ min(histogram_image(i,j),histogram_sketch(i,j));
    end
end

end



