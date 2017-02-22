%% a) Soft margin SVM with linear kernel

load d2.mat;

model = svmtrain(X, Y, 'kernel_function', 'linear','boxconstraint', 1, 'ShowPlot',true);
set(model.FigureHandles{2}(1),'Color','blue')
set(model.FigureHandles{2}(2),'Color','red')

%% b) TODO: Add cross validation
%% Linear
clf;
C=10;
elapsedTimeLinear = zeros(2,1);

subplot(1,2,1)
tic;
model = svmtrain(X, Y, 'kernel_function', 'linear','boxconstraint', C, ...
    'method', 'SMO', 'ShowPlot',true);
toc;
elapsedTimeLinear(1) = toc;
set(model.FigureHandles{2}(1),'Color','blue')
set(model.FigureHandles{2}(2),'Color','red')

subplot(1,2,2)
tic;
model = svmtrain(X, Y, 'kernel_function', 'linear','boxconstraint', C, ...
    'method', 'QP', 'ShowPlot',true);
toc;
elapsedTimeLinear(2) = toc;
set(model.FigureHandles{2}(1),'Color','blue')
set(model.FigureHandles{2}(2),'Color','red')

%% Quadratic 
clf;
C=10;

elapsedTimeQuadratic = zeros(2,1);
subplot(1,2,1)
tic;
model = svmtrain(X, Y, 'kernel_function', 'quadratic','boxconstraint', C, ...
    'method', 'SMO', 'ShowPlot',true);
toc
elapsedTimeQuadratic(1) = toc;
set(model.FigureHandles{2}(1),'Color','blue')
set(model.FigureHandles{2}(2),'Color','red')

subplot(1,2,2)
tic
model = svmtrain(X, Y, 'kernel_function', 'quadratic', 'boxconstraint', C, ...
    'method', 'QP', 'ShowPlot',true);
toc
elapsedTimeQuadratic(2) = toc;
set(model.FigureHandles{2}(1),'Color','blue')
set(model.FigureHandles{2}(2),'Color','red')

%% RBF 
clf;
C=10;
elapsedTimeRBF = zeros(2,1);

subplot(1,2,1)
tic;
model = svmtrain(X, Y, 'kernel_function', 'RBF','boxconstraint', C, ...
    'method', 'SMO', 'ShowPlot',true);
toc;
elapsedTimeRBF(1) = toc;
set(model.FigureHandles{2}(1),'Color','blue')
set(model.FigureHandles{2}(2),'Color','red')

subplot(1,2,2)
tic;
model = svmtrain(X, Y, 'kernel_function', 'RBF', 'boxconstraint', C, ...
    'method', 'QP', 'ShowPlot',true);
toc;
elapsedTimeRBF(2) = toc;
set(model.FigureHandles{2}(1),'Color','blue')
set(model.FigureHandles{2}(2),'Color','red')
