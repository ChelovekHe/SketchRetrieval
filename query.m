%% 
%�������ܣ�����������sketch���Ƶ�ͼƬ
%���������sketch��ַ
%����������õ�����ͼƬ
%

%%
function [sv,si,distance_vector,hog_feature,sketch_histogram] = query(sketchPath)

fid = fopen('db.txt', 'r'); %db.txtͼƬ���ݿ�
db = fread(fid,'single');
fclose(fid);
db = reshape(db,16384,[]);
db = db';    % db:N*16384
[length,~] = size(db);

%�ȶ�sketch��ȡ���ڵ����hog����
hog_feature = extract_sketch_hog_feature(sketchPath);

[~, name, ~] = fileparts(sketchPath);
sketch_feature_path = strcat(name, '._s'); %����������ȡ��������ļ�
fprintf('%s \n',sketch_feature_path);
%��sketch��������
sketch_histogram = quantize_image(sketch_feature_path); %��������

% [a,b] = size(sketch_histogram);
% fprintf('a: %d \n',a);
% fprintf('b: %d \n',b);
% % fid_1 = fopen('sketch_histogram.txt','w');
% % fwrite(fid_1,sketch_histogram,'single');
% % fclose(fid_1);

distance_vector = [];
for i=1:length
    image_histogram = db(i,:);
    distance = calculate_similarity(sketch_histogram,image_histogram);   % ����sketch�����ݿ��е�image�����ƶ�
    distance_vector = [distance_vector;distance];
end

[sv,si]=sort(distance_vector,1,'descend');


images_list = textread('images_from_benchmark_list.txt', '%s');% ͼƬ���ݿ��ͼƬ��ַ�б�
[si_length,~] = size(si); % si_lengthͼƬ���ݿ���ͼƬ������

fid = fopen('result.txt', 'w'); % �������д�뵽result.txt��
fclose(fid);

fid = fopen('result.txt', 'a');
for i=1:200 %��ȡ�����ǰ200������
    imgPath = images_list{si(i)};
    fprintf('%d processing %s\n', si(i),imgPath);
    fprintf(fid,'%s\n', imgPath);
%     figure;
%     imshow(imgPath);
end
fclose(fid);
% imshow(sketchPath);
end








