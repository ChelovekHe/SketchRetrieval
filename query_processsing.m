%% 
%   �ű����ܣ�����������sketch�ļ���������ͳ��ʵ��Ч��
%   ���룺sketch���б��ļ�
%   ���������sketch�Ĵ�����
%

%%  ����������

[retrieval_result] =retrieval(sketchPath);

%%  �Եõ�������ƥ��������rank������top K���Է��ؽ�����ڿ��Կ�����Re_rank��

[sv,si]=sort(retrieval_result,1,'descend'); %   �������
