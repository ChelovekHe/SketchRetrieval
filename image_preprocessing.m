function [ output_args ] = image_preprocessing( input_args )
%IMAGE_PREPROCESSING �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%   GFHOG��RGB���ͣ�:33*10=330��image����>canny
%   Benchmark��RGB���ͣ�:31��sketch��ÿ��sketch��Ӧ40��image����image����>canny��Ե���
%   how��gray���ͣ�:250��sketch���ܹ�20000��
%   Tensor:image����>�Ҷ�ͼ��sketch����> binary
%   ARP��image����>canny��Ե��⡪��>Gaussian�任;sketch����> thinned version
%   ERH��image����>multiple resolution Canny edge detection.
%   Key shapes: image����> Canny operator in a multi scale manner; sketch����>a thinning operation instead of the Canny operator.
%
%   BW = EDGE(I,'canny',THRESH,SIGMA) specifies the Canny method, using
%   SIGMA as the standard deviation of the Gaussian filter. The default
%   SIGMA is sqrt(2); the size of the filter is chosen automatically, based
%   on SIGMA.



end

