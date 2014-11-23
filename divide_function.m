function [D,D1,D2,D3,D4,D5] = image_divide( image,cell_percent,image_percent)

%%IMAGE_DIVIDE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%   �����������ͼ��ָ�������ͼ���Ϊ���ɸ�cell
%   C = mat2cell(image,[size(image,1)/2 size(image,1)/2],[size(image,1)/2 size(image,1)/2]);
%   �ָ���C��C��ȡֵ������C{1,1}��C{1,2}��C{2,1}��C{2,2}
%   256*256,128*128,64*64,32*32,16*16,8*8
%   length(find(A>0));�������A�з���Ԫ�صĸ���
%
%   ���������
%       image:ͼ�����
%       image_percent:     cell�з���Ԫ��ռ��һ��cell�з���Ԫ�صı���
%       cell_percent:      cell�з���Ԫ��ռ��ǰ��cellԪ�������ı���
%
%   cell_percent��image_percent�����Ƿ������cell���зָ�
%
%
%
%   ������ָ��������Ҫ���ǵ����⣬��θ��ݷָ������image��ȡ������ľ�����л��֣������պ�����ʽ��֯����ͼ���������
%
%
%
%%
image_condition = cell_percent;
cell_condition = image_percent;

%% ����E�е�һ����image_percent,�ڶ�����cell_percent
[E1,E2,E3,E4,E5,F1,F2,F3,F4,F5] = calculate_interest_points_distribution(image); 
D =[1];
Q = matrix_expand(D);

%%
D1=[];  %   ��¼�ָ������Ԫ��ֵΪ1��ʾ�ָԪ��ֵΪ0��ʾ���ָ�
E1 = reshape(E1,[2 2])';
F1 = reshape(F1,[2 2])';
for i=1:size(E1,2)
    for j=1:size(E1,2)
        if (Q(i,j) == 0 || Q(i,j) ==-1)
            D1(i,j) = -1;
        else
            [result] = calculate_condition(E1(i,j),F1(i,j)); %����һ��image_percent,cell_percent�ж����Ƿ���Ҫ�ָ�
            D1(i,j) = result; 
        end 
    end
end
Q1 = matrix_expand(D1);

%%
D2=[];  %   ��¼�ָ������Ԫ��ֵΪ1��ʾ�ָԪ��ֵΪ0��ʾ���ָ�
E2 = reshape(E2,[4 4])';
F2 = reshape(F2,[4 4])';
for i=1:size(E2,2)
    for j=1:size(E2,2)
        if (Q1(i,j) == 0 || Q1(i,j) == -1)
            D2(i,j) = -1;
            fprintf('sadfasfa');
        else
            [result] = calculate_condition(E2(i,j),F2(i,j)); %����һ��image_percent,cell_percent�ж����Ƿ���Ҫ�ָ�
            D2(i,j) = result; 
        end 
    end
end
Q2 = matrix_expand(D2);

%%
D3=[];  %   ��¼�ָ������Ԫ��ֵΪ1��ʾ�ָԪ��ֵΪ0��ʾ���ָ�
E3 = reshape(E3,[8 8])';
F3 = reshape(F3,[8 8])';
for i=1:size(E3,2)
    for j=1:size(E3,2)
        if (Q2(i,j) == 0 || Q2(i,j) == -1)
            D3(i,j) = -1;
        else
            [result] = calculate_condition(E3(i,j),F3(i,j)); %����һ��image_percent,cell_percent�ж����Ƿ���Ҫ�ָ�
            D3(i,j) = result; 
        end 
    end
end
Q3 = matrix_expand(D3);
%%
D4=[];  %   ��¼�ָ������Ԫ��ֵΪ1��ʾ�ָԪ��ֵΪ0��ʾ���ָ�
E4 = reshape(E4,[16 16])';
F4 = reshape(F4,[16 16])';
for i=1:size(E4,2)
    for j=1:size(E4,2)
        if (Q3(i,j) == 0 || Q3(i,j) == -1)
            D4(i,j) = -1;
        else
            [result] = calculate_condition(E4(i,j),F4(i,j)); %����һ��image_percent,cell_percent�ж����Ƿ���Ҫ�ָ�
            D4(i,j) = result; 
        end 
    end
end
Q4 = matrix_expand(D4);

%%
D5=[];  %   ��¼�ָ������Ԫ��ֵΪ1��ʾ�ָԪ��ֵΪ0��ʾ���ָ�
E5 = reshape(E5,[32 32])';
F5 = reshape(F5,[32 32])';
for i=1:size(E5,2)
    for j=1:size(E5,2)
        if (Q4(i,j) == 0 || Q4(i,j) == -1)
            D5(i,j) = -1;
        else
            [result] = calculate_condition(E5(i,j),F5(i,j)); %����һ��image_percent,cell_percent�ж����Ƿ���Ҫ�ָ�
            D5(i,j) = result; 
        end 
    end
end
Q5 = matrix_expand(D5);


%% divid_condition������һ���ָ���������cell������������ͽ��зָ����������������Ͳ��ָ
    function [result] = calculate_condition(image_percent,cell_percent)
        result = 0;
        if ((image_percent>image_condition) || (cell_percent>cell_condition)) %�����ʽ�Ժ���Ϊ�ж��Ƿ�ָ������
            result =1;
        end     
    end


%%
end %   end of function
