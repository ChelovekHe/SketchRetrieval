%
%�������ܣ�����sketch��image�����ƶ�
%���������sketch��image�������histogram
%�������������õ��ľ���
%


function [ distance ] = calculate_similarity(sketch_histogram,image_histogram )
% sketch:1*16384
% image:1*16384
distance = 0;
[~,w] = size(sketch_histogram);

%   fid = fopen('0._scale', 'r');
%   scale = fread(fid,'uchar');
%   fclose(fid);
%   scale = scale';

for i=1:w
    if(image_histogram(1,i)==sketch_histogram(1,i)) %��sketch��image��Ӧλ������ͬһ�����ʣ���Ȩ�ؼ�һ��
        distance = distance +1;
    end
end

end

