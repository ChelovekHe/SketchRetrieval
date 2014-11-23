function [E1,E2,E3,E4,E5,F1,F2,F3,F4,F5,D1,D2,D3,D4,D5] = calculate_interest_points_distribution(image)
%%  ����ÿ��cell����������
%    image_percent:     cell�з���Ԫ��ռ��һ��cell�з���Ԫ�صı���
%    cell_percent:      cell�з���Ԫ��ռ��ǰ��cellԪ�������ı���
%    ���������������Ե��ȡ���image����sketch
%    ���������E1,E2,E3,E4��E5��ÿ�������ж������˶�Ӧ�Ĳ�����,����E�е�һ����image_percent,�ڶ�����cell_percent

%% 0.ԭʼͼ��,δ�ָ�
C = image;
D = length(find(C>0));
Q = matrix_expand(D);

%% 1.�ָ�Ϊ��2*2    ÿ����СΪ��128*128
C1 = mat2cell(image,[128 128],[128 128]);
D1 = [];    %   ��¼��ǰcell�з���Ԫ�صĸ���
E1 = [];    %   ��¼��ǰcell��image_percent
F1 = [];    %   ��¼��ǰcell��cell_percent
for i=1:2
    for j=1:2
        count_interest_point = length(find(C1{i,j}>0)); %   ���㵱ǰcell�з���Ԫ�صĸ���
        D1(i,j)= count_interest_point;
        if Q(i,j)==0 %  ��һ��cell��ȫΪ0
            image_percent = -1;
            cell_percent = -1;
        else
            image_percent = D1(i,j) / Q(i,j);   %   ���㵱ǰcell����������....Q(i,j)����Ϊ0
            cell_percent = D1(i,j) / (128*128);
        end
        E1 = [E1 image_percent];
        F1 = [F1 cell_percent];
%         fprintf('C1 %d %d: %d\n',i,j,count_interest_point);
        
    end
end
Q1 = matrix_expand(D1);    %    ��չD1������һ������

%% 2.�ָ�Ϊ��4*4    ÿ����СΪ��64*64
C2 = mat2cell(image,[64 64 64 64],[64 64 64 64]);
D2 = [];
E2 = [];
F2 = [];
for i=1:4
    for j=1:4
        count_interest_point = length(find(C2{i,j}>0)); %   ���㵱ǰcell�з���Ԫ�صĸ���
        D2(i,j)= count_interest_point;
        if Q1(i,j) == 0
            image_percent = -1;
            cell_percent = -1;
        else
            image_percent = D2(i,j) / Q1(i,j);   %   ���㵱ǰcell����������
            cell_percent = D2(i,j) / (64*64);
        end
        E2 = [E2 image_percent];
        F2 = [F2 cell_percent];
%         fprintf('C2 %d %d: %d\n',i,j,count_interest_point);
    end
end
Q2 = matrix_expand(D2);    %    ��չD2������һ������

%% 3.�ָ�Ϊ��8*8    ÿ����СΪ��32*32
C3 = mat2cell(image,[32 32 32 32 32 32 32 32],[32 32 32 32 32 32 32 32]);
D3 = [];
E3 = [];
F3 = [];
for i=1:8
    for j=1:8
        count_interest_point = length(find(C3{i,j}>0));
        D3(i,j)= count_interest_point;
        if Q2(i,j)==0
            image_percent = -1;
            cell_percent = -1;
        else
            
            image_percent = D3(i,j) / Q2(i,j);   %   ���㵱ǰcell����������
            cell_percent = D3(i,j) / (32*32);
        end
        E3 = [E3 image_percent];
        F3 = [F3 cell_percent];
%         fprintf('C3 %d %d: %d\n',i,j,count_interest_point);
    end
end
Q3 = matrix_expand(D3);    %    ��չD3������һ������

%% 4.�ָ�Ϊ: 16*16   ÿ����СΪ��16*16
C4 = mat2cell(image,[16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16],[16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16]);
D4 = [];
E4 = [];
F4 = [];
for i=1:16
    for j=1:16
        count_interest_point = length(find(C4{i,j}>0));
        D4(i,j)= count_interest_point;
        if Q3(i,j) == 0
            image_percent = -1;
            cell_percent = -1;
        else
            
            image_percent = D4(i,j) / Q3(i,j);   %   ���㵱ǰcell����������
            cell_percent = D4(i,j) / (16*16);
        end
        E4 = [E4 image_percent];
        F4 = [F4 cell_percent];
%         fprintf('C4 %d %d: %d\n',i,j,count_interest_point);
    end
end
Q4 = matrix_expand(D4);    %    ��չD4������һ������

%% 5.�ָ�Ϊ��32*32  ÿ����СΪ��8*8
C5 = mat2cell(image,[8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8],[8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8]);
D5 = [];
E5 = [];
F5 = [];
for i=1:32
    for j=1:32
        count_interest_point = length(find(C5{i,j}>0));
        D5(i,j)= count_interest_point;
        if Q4(i,j) == 0
            image_percent = -1;
            cell_percent = -1;
        else
            
            image_percent = D5(i,j) / Q4(i,j);   %   ���㵱ǰcell����������
            cell_percent = D5(i,j) / (8*8);
        end
        E5 = [E5 image_percent];
        F5 = [F5 cell_percent];
%         fprintf('C5 %d %d: %d\n',i,j,count_interest_point);
    end
end

%%

end %   end of function
