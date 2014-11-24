%
%�������ܣ���ͼƬ�����������ôʵ��еĵ��ʱ�ʾͼƬ��
%���������ͼƬ����������ȡ�������
%����������õ�����ͼƬ��hog������һ��image��Ӧһ��_.s�ļ�����������ͼƬ��_.s�ļ���
%

function [histogram] = quantize_image(imgPath) % imgPath ����������ȡ�������

fprintf('quantize:  %s\n',imgPath);
fid = fopen(imgPath, 'r');
feature_1 = fread(fid,'single');
fclose(fid); %ע�⣺��ʱ�ر��Ѿ��򿪵��ļ����

feature_2 = reshape(feature_1,36,[]);
feature_3 = feature_2'; % image_feture 16384*36
[i,j] =size(feature_3);
histogram = zeros(1,i) ;


for k = 1:i %ѭ����ÿһ�������������
    name = num2str(k);
    fid_v = fopen(fullfile('all_vocabulary',strcat(name, '._v')), 'r'); % һ��������Ҫ�ø������ض��Ĵʵ��������
    vocabulary = fread(fid_v,'single');
    fclose(fid_v);
    vocabulary_2 = reshape(vocabulary,36,[]);
    vocabulary_3 = vocabulary_2';
    
    % ����Ӧ��Ȩ�����������뵥�ʵľ���
    % ��ô����е�ÿһ��������ֵ
    adaptive_vector = [];
    if((k>=1)&&(k<=128)) %image�ĵ�һ��
        if(k==1)
            adaptive_vector =[zeros(1,36);zeros(1,36);zeros(1,36);zeros(1,36);feature_3(1,:);feature_3(2,:);zeros(1,36);feature_3(129,:);feature_3(130,:)];
        elseif(k==128)
            adaptive_vector =[zeros(1,36);zeros(1,36);zeros(1,36);feature_3(127,:);feature_3(128,:);zeros(1,36);feature_3(255,:);feature_3(256,:);zeros(1,36)];
        else
            adaptive_vector = [zeros(1,36);zeros(1,36);zeros(1,36);feature_3(k-1,:);feature_3(k,:);feature_3(k+1,:);feature_3(k+127,:);feature_3(k+128,:);feature_3(k+129,:)];
        end
    end
    
    
    if((k>=16257)&&(k<=16384))% image�����һ��
        if(k==16257)
            adaptive_vector = [zeros(1,36);feature_3(16129,:);feature_3(16130,:);zeros(1,36);feature_3(16257,:);feature_3(16258,:);zeros(1,36);zeros(1,36);zeros(1,36)];
        elseif(k==16384)
            adaptive_vector = [feature_3(16255,:);feature_3(16256,:);zeros(1,36);feature_3(16383,:);feature_3(16384,:);zeros(1,36);zeros(1,36);zeros(1,36);zeros(1,36)];
        else
            adaptive_vector = [feature_3(k-129,:);feature_3(k-128,:);feature_3(k-127,:);feature_3(k,:);feature_3(k-1,:);feature_3(k+1,:);zeros(1,36);zeros(1,36);zeros(1,36)];
        end
    end
    
    if((k>128)&&(k<16257))%image���м���
        if (rem(k,128)==1) %ÿһ�еĵ�һ��Ԫ��
            adaptive_vector = [zeros(1,36);feature_3(k-128,:);feature_3(k-127,:);zeros(1,36);feature_3(k,:);feature_3(k+1,:);zeros(1,36);feature_3(k+128,:);feature_3(k+129,:)];
        elseif(rem(k,128)==0) %ÿһ�е����һ��Ԫ��
            adaptive_vector = [feature_3(k-129,:);feature_3(k-128,:);zeros(1,36);feature_3(k-1,:);feature_3(k,:);zeros(1,36);feature_3(k+127,:);feature_3(k+128,:);zeros(1,36)];
        else
            adaptive_vector = [feature_3(k-129,:);feature_3(k-128,:);feature_3(k-127,:);feature_3(k-1,:);feature_3(k,:);feature_3(k+1,:);feature_3(k+127,:);feature_3(k+128,:);feature_3(k+129,:)];
        end
    end
    
    % calculate distance��9*50 �����贰��Ϊ3*3,ÿһ������Ĵʵ��СΪ50
    E = pdist2(adaptive_vector,vocabulary_3,'euclidean'); 
    [~,v] = size(E);
    distance_vector = zeros(1,50);
    for j=1:v
        % �����еĸ�������Ľ��м�Ȩ����
        d = (E(1,j)+E(2,j)+E(3,j)+E(4,j)+E(5,j)+E(6,j)+E(7,j)+E(8,j)+E(9,j))/9;
        distance_vector(j) = d;
    end
    [~,I] = min(distance_vector,[],2); % ȡ��������ĵ�����Ϊ��Ӧ�����������Ӧ�ĵ���
    histogram(k) = I;
end
end