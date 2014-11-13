function [ C] = image_divide( image,cell_percent,image_percent_1,image_percent_2)
%IMAGE_DIVIDE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%   �����������ͼ��ָ�������ͼ���Ϊ2*2��cell
%   C = mat2cell(image,[size(image,1)/2 size(image,1)/2],[size(image,1)/2 size(image,1)/2]);
%   256*256,128*128,64*64,32*32,16*16,8*8
%   length(find(A>0));�������A�з���Ԫ�صĸ���
%
%   ���������
%       image:ͼ�����
%       cell_percent:cell�з���Ԫ��ռ����cellԪ�صı���
%       image_percent_1:cell�з���Ԫ��ռ����image�з���Ԫ�صı���
%       image_percent_2:cell�з���Ԫ��ռ����imageԪ�صı���
%
%   cell_percent��image_percent_1��image_percent_2�����Ƿ������cell���зָ�
%
%   �ָ���C��C��ȡֵ������C{1,1}��C{1,2}��C{2,1}��C{2,2}
%
%
%   ������ָ��������Ҫ���ǵ����⣬��θ��ݷָ������image��ȡ������ľ�����л��֣������պ�����ʽ��֯����ͼ���������
%
%
%

[percent_1,percent_2,percent_3,percent_4,C]  = calculate(image);
%
%
%
%
%
%   divid_condition������һ���ָ���������cell������������ͽ��зָ����������������Ͳ��ָ
%
%
%
end

function [proportion_1,proportion_2,proportion_3,proportion_4,C] = calculate(image)
    C = mat2cell(image,[size(image,1)/2 size(image,1)/2],[size(image,1)/2 size(image,1)/2]);
    number_of_image = length(find(image>0));
    fprintf('number_of_image: %d \n ',number_of_image);

    number_of_cell_1 = length(find(C{1,1 }>0));
    proportion_1 =number_of_cell_1 /number_of_image;
    fprintf('number_of_cell_1: %d proportion_1:%d \n ',number_of_cell_1,proportion_1);

    number_of_cell_2 = length(find(C{1,2}>0));
    proportion_2 =number_of_cell_2 /number_of_image;
    fprintf('number_of_cell_2: %d proportion_2:%d \n ',number_of_cell_2,proportion_2);

    number_of_cell_3 = length(find(C{2,1}>0));
    proportion_3 =number_of_cell_3 /number_of_image;
    fprintf('number_of_cell_3: %d proportion_3:%d \n ',number_of_cell_3,proportion_3);

    number_of_cell_4 = length(find(C{2,2}>0));
    proportion_4 =number_of_cell_4 /number_of_image;
    fprintf('number_of_cell_1: %d proportion_1:%d \n ',number_of_cell_4,proportion_4);

end
%
% imwrite(a,'bird_wzm.png');
% imwrite(C{1,1},'bird_cell_1.png');
% imwrite(C{1,2},'bird_cell_2.png');
% imwrite(C{2,1},'bird_cell_3.png');
% imwrite(C{2,2},'bird_cell_3.png');