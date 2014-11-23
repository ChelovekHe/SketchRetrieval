%%  ����ÿ��ͼ���������feature_extraction����
%    ���룺edge_full.list�ļ��к���������ҪԤ�����image�ĵ�ַ��edge_full.list�ļ�λ�ڸ�Ŀ¼��
%    �����ÿһ��ͼ���Ӧһ��.mat�ļ�����ʾͼ�������������.mat�ļ�λ��image_featureĿ¼��


%%  ��ȡͼ���б��ļ�
images_list = textread('edge_full.list', '%s');
len = size(images_list);
len = len(1);
fprintf('len %d\n', len);

%%  ��ÿһ��ͼ����б�Ե��ȡ
for i = 1:len
  imgPath = images_list{i};
  fprintf('%d feature extraction %s\n', i, imgPath);
  
  feature = feature_extraction(imgpath);    %����ÿ��ͼ���feature(global_feature+local feature)
  
  [filethstr, name, ext] = fileparts(imgPath);
  str = strcat('image_after_edge_detection/',name);
  filename = strcat(str,'_edge');
  save(filename,'a');   %   ����ÿһ����Ե��ȡ���ͼ��

end
%% quit;
