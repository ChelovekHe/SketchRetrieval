%
%�ļ����ܣ��ڹ���ʵ�����У���extract_hog_feature_all_points.m�����õ���������������з��࣬I(x,y)���ൽһ��
%����������������ݵ�ַ�б�һ��txt�ļ�������������������id��
%����������õ��������������ݣ�һ��(x,y)��Ӧһ��_.f�ļ���
%

features_list = textread('features_from_benchmark_list.txt', '%s'); %features_from_benchmark_list.txt ���������б�
len = size(features_list);
len = len(1);
fprintf('len %d\n', len);
for n = 1:len  % ѭ������ÿһ�������ļ���һ��image��Ӧһ�������ļ���
    featurePath = features_list{n};
    fprintf('%d processing %s\n', n, featurePath);
    fid = fopen(featurePath);
    I = fread(fid,'single');
    I_2 = reshape(I,36,[]);
    I_3 = I_2';
    [i,j] = size(I_3);
    for k = 1:i % ѭ������ÿһ��λ���ϵ�����
        name = num2str(k);
        fid_f = fopen(fullfile('classify_data',strcat(name, '._f')), 'a');
        feature = I_3(k,:);
        fwrite(fid_f, feature, 'single');
        fclose(fid_f);
    end
    fclose(fid);
end

