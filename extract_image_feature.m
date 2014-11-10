%
%�������ܣ�����image������
%���������image�ĵ�ַ
%���������image������
%

function [ img_feature ] = extract_image_feature( imgPath )
    fprintf('Extracting image feature: %s\n', imgPath);
    I1 = imresize(imread(imgPath), [128 128]);
    
    %����1����ȡ����ʱ�Ƚ��б�Ե���
    mysize=size(I1);
    if numel(mysize)>2
        img=rgb2gray(I1);
    else
        img=I1;
    end
    img = edge(img,'canny'); %����cannny��Ե���ǰ�����Ȱ�ͼ��ת��Ϊ�Ҷ�ͼ
    
    % ����2����ȡ����ʱ�����б�Ե���
    %     img = I1;
    
    hog_feature = [];
    for i=1:128 % ѭ������ͼƬ��ÿһ�����ص�
        for j=1:128
            [hog, validPoints, ptVis] = extractHOGFeatures(img, [i j]);
            %���ӻ�hog����
            %             if ((i == 16) && (j == 9))
            %                 figure;
            %                 imshow(img); hold on;
            %                 plot(ptVis, 'Color','green');
            %             end
            len = size(hog);
            len = len(1);
            if (len == 0)
                hog_feature = vertcat(hog_feature,zeros(1,36));
            else
                hog_feature = vertcat(hog_feature,hog);
            end
        end
    end
    
    [filethstr, name, ext] = fileparts(imgPath);
    fid = fopen(fullfile(filethstr, strcat(name, '._s')), 'w');%�������������image._s��
    hog_feature_2 = hog_feature';
    fwrite(fid, hog_feature_2, 'single');
    fclose(fid);

end

