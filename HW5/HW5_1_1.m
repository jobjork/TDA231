%% Problem 1.1 a)
load hw5_p1a.mat
k=30;
tol=1e-4;
clusters=k_means(X,k,tol);