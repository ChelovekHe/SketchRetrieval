function [P] = matrix_expand(matrix)
Q =[];
%   ��չ��
for i=1:size(matrix,2)
    Q = [Q matrix(:,i) matrix(:,i)];
end
P = [];
%   ��չ��  
for i=1:size(matrix,1)
    P = vertcat(P,Q(i,:));
    P = vertcat(P,Q(i,:));
end

end