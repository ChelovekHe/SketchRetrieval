function [ hog_feature] = feature_extraction_local( imgPath )
%EXTRACT_LOCAL_FEATURE �˴���ʾ�йش˺�����ժҪ
%�������ܣ�����image����sketch��local feature
%���������image����sketch
%����������õ�image����sketctch��hog������һ��image��Ӧһ��.mat�ļ�
%
img = imgPath;
hog_feature = zeros(16384,36);
count = 1;

for i=1:size(img,1) % ѭ������ͼƬ��ÿһ�����ص�
    for j=1:size(img,1)
        if img(i,j) ~= 0  % ����ֵΪ��0�����ص���ȡhog����(��0�����ص㣬����hog������ֵ����Ϊ�յľ�������Ϊʲô��)
            [hog, ~, ~] = extractHOGFeatures(img, [i j]);
            len = size(hog);
            len = len(1);
            if (len ~= 0)   %����õ�����һ���ǿվ���,����ǿվ�������Ҫ���и��²�������Ϊ��ʼ�������ȫ0����
                hog_feature(count,:) = hog;
            end
        end
    end    
end

end

%                     ���ӻ�hog����
%                     if ((i == 16) && (j == 9))
%                         figure;
%                         imshow(img); hold on;
%                         plot(ptVis, 'Color','green');
%                     end