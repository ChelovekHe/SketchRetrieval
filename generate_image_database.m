%
%�ļ����ܣ��������ڼ�����ͼƬ���ݿ�
%�������������ͼ�񾭹��������local feature������ͼ��ķָ����
%����������õ�һ��db.txt �ļ��������������ͼƬ���������������
%

%%  ����local feature�����ݿ�
local_feature_list = textread('local_feature_after_quantization_list.txt', '%s');% ����extract_hog_feature_all_points��������б�
len = size(local_feature_list);
len = len(1);
fprintf('len %d\n', len);
% fid = fopen('db.txt', 'w');
% fclose(fid);
len
local_feature_database = zeros(len*65536,36);   %   �ڴ治��


% fid = fopen('db.txt', 'a');
% for i = 1:len %ѭ������ÿһ���ļ���һ���ļ���ʾһ��image����������ȡ������ݣ�
%     imgPath = local_feature_list{i};
%     fprintf('creating database: %d processing %s\n', i, imgPath);
%     histogram = quantize_image(imgPath); %��image����ȡ������ģ������������ôʵ��еĵ��ʱ�ʾһ��image
%     fwrite(fid, histogram, 'single');
% end
% fclose(fid);

% fid = fopen('db.txt','r');
% db = fread(fid,'single'); % N*1
% db_2 = reshape(db,1000,[]); % 1000*M
% db_3 = db_2'; % M*1000
% fclose(fid);

%%  �����ָ���������ݿ�


