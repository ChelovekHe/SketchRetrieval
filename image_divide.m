function [ C] = image_divide( image,cell_percent,image_percent_1,image_percent_2)

%%IMAGE_DIVIDE �˴���ʾ�йش˺�����ժҪ
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


%%
%
%
%
%
%   divid_condition������һ���ָ���������cell������������ͽ��зָ����������������Ͳ��ָ
%
%
%


%%
end %   end of function
