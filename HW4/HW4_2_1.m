%% Problem 2.1 a)
clear all, clf, close all, clc;
load d1b.mat
C = 10; % Box-constraint parameter

% Problem 2.1 b)
model = svmtrain(X,Y,'boxconstraint',C,'ShowPlot',true,'autoscale',false);
hold on
set(model.FigureHandles{2}(1),'Color','b');
set(model.FigureHandles{2}(2),'Color','r');
classified = svmclassify(model, X);

misClassified = classified ~= Y;
scatter(X(misClassified,1), X(misClassified,2), 150, 'ks');

xlabel('$x_{1}$','Interpreter', 'LaTex')
ylabel('$x_{2}$','Interpreter', 'LaTex')
title(strcat('Problem 1.2, C=', num2str(C)),'Interpreter', 'LaTex')
leg = legend('-1','1','Support vector', 'Decision boundary');
set(leg,'Interpreter','latex')
set(gca,'fontsize', 9)

% Problem 2.1 c)
bias=model.Bias;

% Problem 2.1 d) 
w1=sum(model.SupportVectors(:,1).*model.Alpha);
w2=sum(model.SupportVectors(:,2).*model.Alpha);

margin=2/norm([w1 w2]);