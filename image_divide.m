%%  Ԥ��������image����divide_fcuntion����
%    ���룺edge_full.list�ļ��к������о�����Ե��ȡ���image��ַ(һ��ͼ���Ӧһ��.mat�ļ�)��edge_full.list�ļ�λ�ڸ�Ŀ¼��
%    �����ÿһ��ͼ���Ӧһ��.mat�ļ����洢�ָ��������.mat�ļ�λ��image_matrix_after_divideĿ¼��
%    function [D,D1,D2,D3,D4,D5] = image_divide( image,cell_percent,image_percent)

%%  ��������
image_percent = 0.2;    % cell�з���Ԫ��ռ��һ��cell�з���Ԫ�صı���
cell_percent = 0.2;     % cell�з���Ԫ��ռ��ǰ��cellԪ�������ı���

%%  ��ȡͼ���б��ļ�
images_list = textread('edge_full_list.txt', '%s');
len = size(images_list);
len = len(1);
fprintf('len %d\n', len);

%%  ��ÿһ��ͼ����зָ��
for i = 1:len
  imgPath = images_list{i};
  fprintf('%d processing %s\n', i, imgPath);
  
  image = load(imgPath,'a');    % ��ȡͼ�񾭹���Ե��������ݣ�aΪ256*256�ľ���
  [D,D1,D2,D3,D4,D5] = divide_function( image.a,cell_percent,image_percent);
  
  [filethstr, name, ext] = fileparts(imgPath);
  str = strcat('image_matrix_after_divide/',name);
  filename = strcat(str,'_divide');
  save(filename,'D','D1','D2','D3','D4','D5');   %   ����ָ����
end
%% quit;
