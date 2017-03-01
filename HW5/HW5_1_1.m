%% Problem 1.1 b)
clear all, close all;
load hw5_p1a.mat;
k=2;
tol=1e-5;

clusters1=k_means(X, k, tol, false, 0);
clusters2=k_means(X, k, tol, true, 2);
new_assign=clusters1~=clusters2;

plot(X(clusters1==1, 1), X(clusters1==1, 2), 'r.', 'MarkerSize', 10)
hold on
plot(X(clusters1==2, 1), X(clusters1==2, 2), 'b.', 'MarkerSize', 10)
scatter(X(new_assign,1), X(new_assign,2), 150, 'ks');
title('Cluster assignment at convergence ','Interpreter','LaTex')
leg = legend('Class 1', 'Class 2');
set(leg,'Interpreter','LaTex')
set(gca,'fontsize', 11)
xlabel('$x_{1}$','Interpreter', 'LaTex')
ylabel('$x_{2}$','Interpreter', 'LaTex')

%% Problem 1.1 d)
load hw5_p1b.mat;
k=2;
clusters3=k_means_rbf(X, k);

plot(X(clusters3==1, 1), X(clusters3==1, 2), 'r.', 'MarkerSize', 10)
hold on
plot(X(clusters3==2, 1), X(clusters3==2, 2), 'b.', 'MarkerSize', 10)
title('Clustering using RBF kernel','Interpreter','LaTex')
leg = legend('Class 1', 'Class 2');
set(leg,'Interpreter','LaTex')
set(gca,'fontsize', 11)
xlabel('$x_{1}$','Interpreter', 'LaTex')
ylabel('$x_{2}$','Interpreter', 'LaTex')