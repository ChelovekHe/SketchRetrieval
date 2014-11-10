%
%�������ܣ���ȡ����sketch������
%���������sketch�ĵ�ַ
%���������sketch������,һ����N*N��*36�ľ�������N*NΪͼ��Ĵ�С��36Ϊ������ά�ȣ�HOG������
%

function [ hog_feature ] = extract_sketch_feature( sketchPath )
    fprintf('extract sketch hog feature:  %s\n',sketchPath);
    I = imresize(imread(sketchPath), [128 128]);
    
    %   Ԥ���ж�sketch�����͡�sketch�ǻҶ�ͼ����ֵͼ��
    
    % 
    %   sketchԤ����������һ��swith case��Ӧ���������Ԥ����ѡ��
    %
    %   Ԥ������1����ȡ����ǰ�Ƚ��б�Ե��⣨����cannny��Ե���ǰ���Ȱ�RGBͼ��ת��Ϊ�Ҷ�ͼ��
    mysize=size(I);
    if numel(mysize)>2
        img=rgb2gray(I);
    else
        img=I;
    end
    img = edge(img,'canny'); 
    
    %   Ԥ������2����ȡ����ǰ�����б�Ե���
    %     img = I;
    
    % 
    %   HOG������ȡ����sketch�ϵ�ÿһ���������ص����HOG������������������ص�Ϊ���ĵĴ��ڼ���һ��HOG������
    %
    hog_feature = []; % ��ȡ��sketch��HOG����
    for i=1:128
        for j=1:128
            [hog, ~, ~] = extractHOGFeatures(img, [i j]); % ������[i,j]Ϊ���ĵ�HOG����
            len = size(hog);
            len = len(1);
            if (len == 0) 
                hog_feature = vertcat(hog_feature,zeros(1,36));
            else
                hog_feature = vertcat(hog_feature,hog);
            end
        end
    end
    %   HOG�������浽ͬsketch��ͬ�ļ������ļ���׺Ϊ.hog��Ϊ�ļ���
    
    
    [filethstr, name, ~] = fileparts(sketchPath);
    save(fullfile(filethstr, strcat(name, '_HogFeature.mat')),'hog_feature');
    
%     [filethstr, name, ext] = fileparts(sketchPath);
%     fid = fopen(fullfile(filethstr, strcat(name, '.hog')), 'w');
%     hog_feature_2 = hog_feature';
%     fwrite(fid, hog_feature_2, 'single');
%     fclose(fid);
    
end

