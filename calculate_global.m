

%%  ****************************����ĳ��cell�е�ÿһ����Ȥ���global feature**************************
function [global_feature] =calculate_global(cell)

global_feature =zeros(size(cell,1),size(cell,1));   %��¼cell��ÿ�����global feature��ֵ������Ȥ���ֵΪ0

for i=1:size(cell,1)
    for j=1:size(cell,2)
        if cell(i,j)~=0 %   ֻ����cell�е���Ȥ���global feature,�����Ƿ���Ȥ��
            global_feature(i,j) = calculate_one_interest_ponit(cell,i,j);
        else
            global_feature(i,j) =0;
        end
    end
end

end %end of function

%%  **����ĳһ����Ȥ���global feature,��һ������Ϊ6�����飬����Ԫ����0����1��Ϊ�˷��㣬���ǰ���������ʾΪ��10������**************************************
function [return_feature] = calculate_one_interest_ponit(cell,i,j)

distance_array =zeros(1,length(find(cell>0))); %��¼����ֵ������ĳ��ȵ���cell����Ȥ��ĸ���
count = 1;
for m=1:size(cell,1)
    for n=1:size(cell,2)
        if cell(m,n)~=0
            distance_array(count) = norm([i,j]-[m,n]); %������Ȥ��֮���ŷʽ���룬�÷�������ʽ����
            count = count +1;
        end
    end
end

%   *************************�Դˣ��õ��˾������飬��������Ҫ������ι���global feature**********
mean_value = mean(distance_array);
interest_point_number = length(find(cell>0));

%   ����ÿһ��Բ�������е���Ȥ������������й�һ��
A = length(find(distance_array < (mean_value/8)))/interest_point_number;
B = (length(find(distance_array > (mean_value/8)))-length(find(distance_array> (mean_value/4))))/interest_point_number;
C = (length(find(distance_array> (mean_value/4)))-length(find(distance_array> (mean_value/2))))/interest_point_number;
D = (length(find(distance_array> (mean_value/2)))-length(find(distance_array> (mean_value))))/interest_point_number;
E = (length(find(distance_array> (mean_value)))- length(find(distance_array> (2*mean_value))))/interest_point_number;
F = length(find(distance_array> (2*mean_value)))/interest_point_number;
%   ������Ϊ�˷���洢�����������Ϊ6�����鵱���������������������������ת��Ϊ10����
% real_feature = [quantize_global_feature(A),quantize_global_feature(B),quantize_global_feature(C),quantize_global_feature(D),quantize_global_feature(E),quantize_global_feature(F)];
return_feature =bin2dec(strcat(int2str(quantize_global_feature(A)),int2str(quantize_global_feature(B)),int2str(quantize_global_feature(C)),int2str(quantize_global_feature(D)),int2str(quantize_global_feature(E)),int2str(quantize_global_feature(F))));

end %end of function
%% *************************************����global feature**********************************
function [return_value] = quantize_global_feature(value)
if value>0.1
    return_value = 1;
else
    return_value = 0;
end
end