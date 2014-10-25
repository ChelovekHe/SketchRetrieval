% Kmeans: Matlab Code
%
% My implementation of K means algorithm is highly customized. Initial cluster centroid can be selected in various of ways. Those are:
% Randomly initialized cluster centroid as one of the data row.
% Select first 3 data row was the three cluster center.
% Provide the cluster centroid as a parameter, it is specially helpful when you want to perform the cluster with the same initial data centers so that we don’t have to worry about K means naming different to the same cluster in different run.
%
function [class,centroid,counter,feature]=MyKMeans(data,k,option, init_centroid )
fprintf('begin processing! \n');
%1- Random
%2- First three
%4- Centroid passes as parameter

%ȥ��data�е�����Ԫ��ȫΪ0���У����ټ�����
feature = [];
[n,m]=size(data); % A = [1,2,3;4,5,6],[n,m]= size(A),n=2,m=3; n:����������HOG����������,m:����ά����ÿ��HOG������ά����
for i=1:n
    result = data(i,:);
    if sum(result,2) ~= 0
        feature = [feature;result];
    end
end
data = feature;
fprintf('data processing! \n');

centroid=[];
class=[];
[n,m]=size(data); % A = [1,2,3;4,5,6],[n,m]= size(A),n=2,m=3; n:����������HOG����������,m:����ά����ÿ��HOG������ά����


selected=[];
%get the K initial centroids
fprintf('get the K initial centroids! \n');
if (option==1)
    for i=1:k
        index=uint16((rand()*n));
        while(Exists(selected,index)==1) %��֤��ʼ��K���������Ĳ��ظ�
            index=uint16((rand()*n));
        end
        selected=[selected index]; %��N��������ѡ��K������һ����ȷ��������,B = [1,2,3],B = [B 4],B=[1,2,3,4]
        centroid(i,:)=data(index,:);%ѡ��K������
        fprintf('index: %d\n',index);
    end
elseif (option==2)
    centroid(1:3,:)=data(1:3,:);
else
    centroid=init_centroid;
end

flag=0;
count=0;
counter=[];


%classify the data

while(flag==0)
    fprintf('calculate MyDistance\n');
    [dist,class]=MyDistance(centroid,data);
    
    if(count~=0)%������ǵ�һ�ε���
        temp=(class==prevclass);%�ж�ǰ�����εĵ�������Ƿ�һ�£����������һ����������
        if( max(max(temp))==1 && min(min(temp))==1)
            flag=1;
            counter;
            break;
        end
    end
    
    prevclass=class;%��һ�ε���
    [centroid,counter]=CalculateCentroid(centroid,class,data);%���¼����������
    count=count+1;
    fprintf('iterator: %d \n',count);
end




%Calculate new Centroid
function [newCentroid,counter]=CalculateCentroid(centroid,class,data)
fprintf('Calculate new Centroiditerator\n');
[n,m]=size(data);
[k,l]=size(centroid);

newCentroid=zeros(k,l);
counter=zeros(k,1);

for j=1:k
    for i=1:n
        if(class(i,1)==j)
            for p=1:m
                newCentroid(j,p)=newCentroid(j,p)+data(i,p);
            end
            counter(j,1)=counter(j,1)+1;
        end
    end
end

for j=1:k
    for p=1:m
        newCentroid(j,p)= newCentroid(j,p)/counter(j,1);
    end
end



%Function to check if the item is already selected as one
% of the initial centroid
function [flag] = Exists(Arr, item)

flag=0;
[n,m]=size(Arr);
for i=1:m
    if(Arr(1,i)==item)
        flag=1;
        break;
    end
end



%Calculate the distance and assign the class
function [dist,classify]=MyDistance(centroid,data)

[n,m]=size(data);
[k,l]=size(centroid);
dist=[];
classify=[];

for i=1:k
    % fprintf('iterator:i: %d \n',i);
    for j=1:n
        % fprintf('iterator:j: %d \n',j);
        % calculate the distance from each centroid to the data
        % ����ÿ���������ĵ�data��ÿһ������֮��ľ���
        sum=0;
        
        
        %����data(j,:)��centroid(i,:)֮��ľ���
        for p=1:m
            % fprintf('iterator:p: %d \n',p);
            sum=sum+(data(j,p)-centroid(i,p))^2; %������������֮��ľ���          
        end
        dist(i,j)=sum^0.5;%distΪK*Nά����dist(i,j)Ϊ��������i��data�е�����j֮��ľ��룬distΪK*Nά����
    end
end

for j=1:n
    [minv,mindex]=min(dist(:,j));
    classify(j,1)=mindex; % classifyΪN*1ά������classify(j,1)��ʾ��j��������������
end