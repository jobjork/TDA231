%% Problem 1.1 b)
load hw5_p1a.mat;
k=2;
tol=1e-5;

clusters1=k_means(X, k, tol, false, 0);
clusters2=k_means(X, k, tol, true, 2);

subplot(1,2,1)
plot(X(clusters1==1, 1), X(clusters1==1, 2), 'r.', 'MarkerSize', 10)
hold on
plot(X(clusters1==2, 1), X(clusters1==2, 2), 'b.', 'MarkerSize', 10)

subplot(1,2,2)
plot(X(clusters2==1, 1), X(clusters2==1, 2), 'r.', 'MarkerSize', 10)
hold on
plot(X(clusters2==2, 1), X(clusters2==2, 2), 'b.', 'MarkerSize', 10)
