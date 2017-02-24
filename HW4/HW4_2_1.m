%% Problem 2.1 a)
clf, close all, clc
load d1b.mat
C=10; % Box-constraint parameter

% Problem 2.1 b)
svmStruct=svmtrain(X,Y,'boxconstraint',C,'showplot',true,'autoscale',false);
hold on
set(svmStruct.FigureHandles{2}(1),'Color','b');
set(svmStruct.FigureHandles{2}(2),'Color','r');
support=svmStruct.SupportVectorIndices;
Xnew = svmclassify(svmStruct,X(support,:));
for i=1:length(support(:,1))
    if Xnew(i)~=Y(support(i))
        plot(X(support(i),1),X(support(i),2),'ms','MarkerSize',20);
    end
end

xlabel('$x_{1}$','Interpreter', 'LaTex')
ylabel('$x_{2}$','Interpreter', 'LaTex')
title(strcat('Problem 1.2, C=', num2str(C)),'Interpreter', 'LaTex')

% Problem 2.1 c)
bias=svmStruct.Bias

% Problem 2.1 d) 
w1=sum(svmStruct.SupportVectors(:,1).*svmStruct.Alpha);
w2=sum(svmStruct.SupportVectors(:,2).*svmStruct.Alpha);

margin=2/norm([w1 w2])