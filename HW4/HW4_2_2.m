%% a) Soft margin SVM with linear kernel

load d2.mat;
hold on;
C=10;
model = svmtrain(X, Y, 'kernel_function', 'RBF','boxconstraint', C,...
    'ShowPlot',true, 'autoscale', false);
set(model.FigureHandles{2}(1),'Color','blue')
set(model.FigureHandles{2}(2),'Color','red')
xlabel('$x_1$', 'interpreter', 'latex')
ylabel('$x_2$', 'interpreter', 'latex')

classified = svmclassify(model, X);
misClassified = classified ~= Y;
hold on;
scatter(X(misClassified, 1), X(misClassified, 2), 150, 'ks')
leg = legend('-1','1','Support vector', 'Decision boundary','Misclassified');
set(leg,'Interpreter','latex')
set(gca,'fontsize', 9)

%% b) 
%% 5-fold cross validation for the two solvers, with all three kernels

C=1;
elapsedTimes= zeros(6,1);
results = zeros(6,1);
numDataPoints = length(X);
numTrainingPoints = floor((4/5)*numDataPoints);
numValidationPoints = numDataPoints - numTrainingPoints;

cvData = randsample(1:numDataPoints, numDataPoints);
cvTraining = cvData(1:numTrainingPoints);
cvValidation = cvData(numTrainingPoints+1:end);

%% Linear SMO
tic;
model1Train = svmtrain(X(cvTraining, :), Y(cvTraining), 'kernel_function',...
    'linear','boxconstraint', C, 'method', 'SMO', 'ShowPlot',false, 'autoscale', false);
model1Validation = svmclassify(model1Train, X(cvValidation, :));
results(1) = 1 - sum(model1Validation == Y(cvValidation))/numValidationPoints;
toc;
elapsedTimes(1) = toc;
%% Linear QP
tic;
model2Train = svmtrain(X(cvTraining, :), Y(cvTraining), 'kernel_function', ...
    'linear','boxconstraint', C, 'method', 'QP', 'ShowPlot',false, 'autoscale', false);
model2Validation = svmclassify(model2Train, X(cvValidation, :));
results(2) = 1 - sum(model2Validation == Y(cvValidation))/numValidationPoints;
toc;
elapsedTimes(2) = toc;
%% Quadratic SMO
tic;
model3Train = svmtrain(X(cvTraining, :), Y(cvTraining), 'kernel_function', ...
    'quadratic','boxconstraint', C, 'method', 'SMO', 'ShowPlot',false, 'autoscale', false);
model3Validation = svmclassify(model3Train, X(cvValidation, :));
results(3) = 1 - sum(model3Validation == Y(cvValidation))/numValidationPoints;
toc;
elapsedTimes(3) = toc;
%% Quadratic QP
tic;
model4Train = svmtrain(X(cvTraining, :), Y(cvTraining), 'kernel_function', ...
    'quadratic','boxconstraint', C, 'method', 'QP', 'ShowPlot',false, 'autoscale', false);
model4Validation = svmclassify(model4Train, X(cvValidation, :));
results(4) = 1 - sum(model4Validation == Y(cvValidation))/numValidationPoints;
toc;
elapsedTimes(4) = toc;
%% RBF SMO
tic;
model5Train = svmtrain(X(cvTraining, :), Y(cvTraining), 'kernel_function', ...
    'RBF','boxconstraint', C, 'method', 'SMO', 'ShowPlot',false, 'autoscale', false);
model5Validation = svmclassify(model5Train, X(cvValidation, :));
results(5) = 1 - sum(model5Validation == Y(cvValidation))/numValidationPoints;
toc;
elapsedTimes(5) = toc;
%% RBF QP
tic;
model6Train = svmtrain(X(cvTraining, :), Y(cvTraining), 'kernel_function', ...
    'RBF','boxconstraint', C, 'method', 'QP', 'ShowPlot',false, 'autoscale', false);
model6Validation = svmclassify(model6Train, X(cvValidation, :));
results(6) = 1 - sum(model6Validation == Y(cvValidation))/numValidationPoints;
toc;
elapsedTimes(6) = toc;