%
%�ļ����ܣ��������ڼ�����ͼƬ���ݿ⣨��Ҫ
%���������ͼƬ���ݿ⾭��extract_hog_feature_all_points������ݵ�ַ�б�һ��txt�ļ�������������ͼƬ��id��
%����������õ�һ��db.txt �ļ��������������ͼƬ���������������
%

images_list = textread('feature_database_list_2.txt', '%s');% ����extract_hog_feature_all_points��������б�
len = size(images_list);
len = len(1);
fprintf('len %d\n', len);
% fid = fopen('db.txt', 'w');
% fclose(fid);

fid = fopen('db.txt', 'a');
for i = 1:len %ѭ������ÿһ���ļ���һ���ļ���ʾһ��image����������ȡ������ݣ�
    imgPath = images_list{i};
    fprintf('creating database: %d processing %s\n', i, imgPath);
    histogram = quantize_image(imgPath); %��image����ȡ������ģ������������ôʵ��еĵ��ʱ�ʾһ��image
    fwrite(fid, histogram, 'single');
end
fclose(fid);


% fid = fopen('db.txt','r');
% db = fread(fid,'single'); % N*1
% db_2 = reshape(db,1000,[]); % 1000*M
% db_3 = db_2'; % M*1000
% fclose(fid);
