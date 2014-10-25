%
%�ļ����ܣ��Ծ���calssify_features.m�������������о��ࣨ��Ҫ����128*128�Σ�
%����������������������ݣ�һ��txt�ļ�������������������id��
%����������õ�128*128���ʵ䣬һ��λ�ö�Ӧһ��_.v�ļ�
%

features_list = textread('test.txt', '%s'); %classify_data_list.txt ���������������б�
len = size(features_list);
len = len(1);
fprintf('len %d\n', len);
for n = 1:len %ѭ������ÿ���ļ�
    featurePath = features_list{n};
    fprintf('%d processing %s\n', n, featurePath);
    fid = fopen(featurePath,'r');
    I = fread(fid,'single');
    fclose(fid);
    I_2 = reshape(I,36,[]);
    I_3 = I_2';
    [IDX,C] = kmeans(I_3,200,'MaxIter',100); % ����������kmeans���࣬�������ĸ�����ʵ��Ч��ȷ����I_3Ϊ�������50Ϊ�������ĸ�����100Ϊ���ĵ���������
    
    D = C';
    vocabulary = reshape(D,1,[]);
    [filethstr, name, ext] = fileparts(featurePath);
    fid_f = fopen(fullfile('test',strcat(name, '._v')), 'w'); %�����������ʵ䣩д��_.v�ļ���
    fwrite(fid_f, vocabulary, 'single');
    fclose(fid_f);
end