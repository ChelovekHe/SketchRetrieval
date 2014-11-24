function [ hog_feature] = feature_extraction_local_old_version( imgPath )
%FEATURE_EXTRACTION_LOCAL_OLD_VERSION �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    img = imgPath;
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

end

