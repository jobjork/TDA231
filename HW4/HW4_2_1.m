%% Problem 2.1 a)
clear all, close all
load d1b.mat
C=1; % Box-constraint parameter

% Problem 2.1 b)
svmStruct=svmtrain(X,Y,'boxconstraint',C,'showplot',true);
set(svmStruct.FigureHandles{2}(1),'Color','b');
set(svmStruct.FigureHandles{2}(2),'Color','r');
support=svmStruct.SupportVectorIndices;
for i=1:length(support(:,1))
    if svmStruct.GroupNames(support(i))~=Y(support(i))
        disp('Hello')
    end
end
%Xwrong= % Points not seperated correctly
%plot(Xwrong(:,1),Xwrong(:,2),'ks','MarkerSize',10);

% Problem 2.1 c)
svmStruct.Bias;