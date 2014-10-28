%% matlabpool local 4;

addpath(genpath('E:\matlab\calc_scale\AnisotropicDetector\'));

%% Begin Operation
t = 30;
sigma = 2.7;

lowScale = 2:3:17;

images_list = textread('images_full.list', '%s');
len = size(images_list);
len = len(1);

fprintf('len %d\n', len);

for i = 1:len
  imgPath = images_list{i};
  fprintf('%d processing %s\n', i, imgPath);

%   img = imresize(imread(imgPath), [240 320]);
   img = imresize(imread(imgPath), [128 128]);


  [result] = andiff( img, linspace(1.2,16,t), sigma, 3, 1000, t);
  a = max(result.scaleMat, [], 3);

  [filethstr, name, ext] = fileparts(imgPath);

  fid = fopen(fullfile(filethstr, strcat(name, '._s')), 'w');
  fwrite(fid, a', 'uchar');
  fclose(fid);
end

%% quit;