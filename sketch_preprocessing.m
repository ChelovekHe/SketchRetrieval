function [ sketchFeature ] = sketch_preprocessing( sketchPath )
%%  SKETCH_PREPROCESSING �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

%   ���ж�sketch�����ͣ���RGB��gray��binary����������ô����
%   canny ��Ե�����ͼ����binary�͵�
%   �Ҷ�ͼ����ת��Ϊbinary�͵�gray2bin
%   GFHOG��RGB���ͣ�:33*10=330��image����>canny
%   Benchmark��RGB���ͣ�:31��sketch��ÿ��sketch��Ӧ40��image����image����>canny��Ե���
%   how��gray���ͣ�:250��sketch���ܹ�20000��
%   Tensor:image����>�Ҷ�ͼ��sketch����> binary
%   ARP��image����>canny��Ե��⡪��>Gaussian�任;sketch����> thinned version
%   ERH��image����>multiple resolution Canny edge detection.
%   Key shapes: image����> Canny operator in a multi scale manner; sketch����>a thinning operation instead of the Canny operator.
%   a thinning operation :edge(rgb2gray(gfhog),'zerocross');

%%
sketch = imresize(sketchPath,[256 256]);
fprintf('a thinning operation to sketch');
if ndims(sketch) == 3
    sketch = rgb2gray(sketch);
end
sketchFeature = edge(sketch,'zerocross');
end   %end of function
