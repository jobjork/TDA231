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
xlabel('$x_{1}$','Interpreter', 'LaTex')
ylabel('$x_{2}$','Interpreter', 'LaTex')
