%% Problem 1.1 b)
clear all, close all;
load hw5_p1a.mat;
k = 2;
tol = 1e-5;

twoIterClusters = k_means(X, k, tol, true, 2);
convergedClusters = k_means(X, k, tol, false, 0);
new_assign = convergedClusters ~= twoIterClusters;

plot(X(convergedClusters==1, 1), X(convergedClusters==1, 2), 'r.', 'MarkerSize', 10)
hold on
plot(X(convergedClusters==2, 1), X(convergedClusters==2, 2), 'b.', 'MarkerSize', 10)
scatter(X(new_assign,1), X(new_assign,2), 150, 'ks');
title('Cluster assignments at convergence ','Interpreter','LaTex')
leg = legend('Class 1', 'Class 2');
set(leg,'Interpreter','LaTex')
set(gca,'fontsize', 11)
xlabel('$x_{1}$','Interpreter', 'LaTex')
ylabel('$x_{2}$','Interpreter', 'LaTex')

%% Problem 1.1 d)
clear all, close all;
load hw5_p1b.mat;
k = 2;
tol = 1e-5;

linearClusters = k_means(X, k, tol, false, 0);
rbfClusters = k_means_rbf(X, k);

subplot(1,2,1)
plot(X(linearClusters == 1, 1), X(linearClusters == 1, 2), 'r.', 'MarkerSize', 10)
hold on
plot(X(linearClusters == 2, 1), X(linearClusters == 2, 2), 'b.', 'MarkerSize', 10)
title('Clustering using linear kernel','Interpreter','LaTex')
xlabel('$x_{1}$','Interpreter', 'LaTex')
ylabel('$x_{2}$','Interpreter', 'LaTex')

subplot(1,2,2)
plot(X(rbfClusters == 1, 1), X(rbfClusters == 1, 2), 'r.', 'MarkerSize', 10)
hold on
plot(X(rbfClusters == 2, 1), X(rbfClusters == 2, 2), 'b.', 'MarkerSize', 10)
title('Clustering using RBF kernel','Interpreter','LaTex')
xlabel('$x_{1}$','Interpreter', 'LaTex')
ylabel('$x_{2}$','Interpreter', 'LaTex')