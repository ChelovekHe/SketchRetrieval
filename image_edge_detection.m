%    Ԥ��������image����AnisotropicDetector���б�Ե��ȡ
%    ���룺images_full_list.txt�ļ��к���������ҪԤ�����image�ĵ�ַ��images_full_list.txt�ļ�λ�ڸ�Ŀ¼��
%    �����ÿһ��ͼ���Ӧһ��.mat�ļ�����ʾ���б�Ե��ȡ���ͼ������.mat�ļ�λ��image_after_edge_detectionĿ¼��

%%  imageԤ�������
%   �˴���ʾ��ϸ˵��
%   GFHOG��RGB���ͣ�:33*10=330��image����>canny
%   Benchmark��RGB���ͣ�:31��sketch��ÿ��sketch��Ӧ40��image����image����>canny��Ե���
%   how��gray���ͣ�:250��sketch���ܹ�20000��
%   Tensor:image����>�Ҷ�ͼ��sketch����> binary
%   ARP��image����>canny��Ե��⡪��>Gaussian�任;sketch����> thinned version
%   ERH��image����>multiple resolution Canny edge detection.
%   Key shapes: image����> Canny operator in a multi scale manner; sketch����>a thinning operation instead of the Canny operator.
%
%   BW = EDGE(I,'canny',THRESH,SIGMA) specifies the Canny method, using
%   SIGMA as the standard deviation of the Gaussian filter. The default
%   SIGMA is sqrt(2); the size of the filter is chosen automatically, based
%   on SIGMA.

%%
% addpath(genpath('F:\paper\experiment\sketch_retrieval_project\AnisotropicDetector\'));
addpath(genpath('G:\Sketch_retrieval\AnisotropicDetector\'));
% addpath(fullfile(pwd,'AnisotropicDetector'));

%% ************************��������**************************************************************************
t = 30;
sigma = 6;
lowScale = 2:3:17;
%% ***********************************************************************************************************

%%  ��ȡͼ���б��ļ�
images_list = textread('images_full_list.txt', '%s');
len = size(images_list);
len = len(1);
fprintf('len %d\n', len);

%%  ��ÿһ��ͼ����б�Ե��ȡ
for i = 1:len
  imgPath = images_list{i};
  fprintf('%d edge processing %s\n', i, imgPath);
  
  img = imresize(imread(imgPath), [256 256]);   %   resize����ͬ�ĳߴ�
  [result] = andiff( img, linspace(1.2,16,t), sigma, 3, 1000, t);
  a = max(result.scaleMat, [], 3);  %   aΪ���б�Ե��ȡ���ͼ��
  
  [filethstr, name, ext] = fileparts(imgPath);
  str = strcat('image_after_edge_detection/',name);
  filename = strcat(str,'_edge');
  save(filename,'a');   %   ����ÿһ����Ե��ȡ���ͼ��
end

