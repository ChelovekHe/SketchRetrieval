function [G1,G2,G3,G4,G5] = feature_extraction_global(image,D1,D2,D3,D4,D5)

%EXTRACT_GLOBAL_FEATURE �˴���ʾ�йش˺�����ժҪ
%   �ű����ܣ�����image����image��global feature
%   ���������image����sketch�ı�Եͼ��sketch�ķָ���󣨴����ǵ㣬����image�ķָ����
%   ���������image����sketch��global feature
%            ÿһ���global feature:G1,G2,G3,G4,G5   
%
%

%% ************************************************************************************
%                    ����ÿһ��cell�е�ÿ��Ԫ�ص�global feture
%% ************************************************************************************

% *********************************��1�㣬2*2*******************************************************
C1 = mat2cell(image,[128 128],[128 128]);
G1 = mat2cell(image,[128 128],[128 128]);   % ������һ�����Ȥ���global feature��ֵ
for i=1:2
    for j=1:2
        if D1(i,j)==0    %D(i,j)=0����ʾ��Ҫ�������cell�е���Ȥ���global feature
            [result] = calculate_global(C1{i,j});
            G1{i,j} = result;
        else
            G1{i,j} = zeros(size(C1{1,1},1),size(C1{1,1},1));
        end
    end
end


% *********************************��2�㣬4*4*******************************************************
C2 = mat2cell(image,[64 64 64 64],[64 64 64 64]);
G2 = mat2cell(image,[64 64 64 64],[64 64 64 64]); % ������һ�����Ȥ���global feature��ֵ
for i=1:4
    for j=1:4
        if D2(i,j)==0    %D(i,j)=0����ʾ��Ҫ�������cell�е���Ȥ���global feature
            [result] = calculate_global(C2{i,j});
            G2{i,j} = result;
        else
            G2{i,j} = zeros(size(C2{1,1},1),size(C2{1,1},1));
        end
    end
end

% *********************************��3�㣬8*8*******************************************************
C3 = mat2cell(image,[32 32 32 32 32 32 32 32],[32 32 32 32 32 32 32 32]);
G3 = mat2cell(image,[32 32 32 32 32 32 32 32],[32 32 32 32 32 32 32 32]); % ������һ�����Ȥ���global feature��ֵ
for i=1:8
    for j=1:8
        if D3(i,j)==0    %D(i,j)=0����ʾ��Ҫ�������cell�е���Ȥ���global feature
            [result] = calculate_global(C3{i,j});
            G3{i,j} = result;
        else
            G3{i,j} = zeros(size(C3{1,1},1),size(C3{1,1},1));
        end
    end
end

% *********************************��4�㣬16*16*******************************************************
C4 = mat2cell(image,[16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16],[16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16]);
G4 = mat2cell(image,[16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16],[16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16]);
for i=1:16
    for j=1:16
        if D4(i,j)==0    %D(i,j)=0����ʾ��Ҫ�������cell�е���Ȥ���global feature
            [result] = calculate_global(C4{i,j});
            G4{i,j} = result;
        else
            G4{i,j} = zeros(size(C4{1,1},1),size(C4{1,1},1));
        end
    end
end

% *********************************��5�㣬32*32*******************************************************
C5 = mat2cell(image,[8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8],[8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8]);
G5 = mat2cell(image,[8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8],[8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8]);
for i=1:32
    for j=1:32
        if D5(i,j)==0    %D(i,j)=0����ʾ��Ҫ�������cell�е���Ȥ���global feature
            [result] = calculate_global(C5{i,j});
            G5{i,j} = result;
        else
            G5{i,j} = zeros(size(C5{1,1},1),size(C5{1,1},1));
        end
    end
end

end %end of function



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