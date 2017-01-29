%% Olof Ekborg, Johan Björk
clf, close all, clc, clear all;
load 'dataset1.mat';
%% a)
mu = mean(x);
sigma = linspace(0.01, 20, 1000);
maxSigma = max(sigma);

xLength = length(x);
alphaPriorA = 1;
betaPriorA = 1;
alphaPriorB = 10;
betaPriorB = 1;

alphaPosteriorA = alphaPriorA + xLength ;
betaPosteriorA = betaPriorA + (1/2)*sum(sum((x-repmat(mu, xLength, 1)).^2));
alphaPosteriorB = alphaPriorB + xLength ;
betaPosteriorB = betaPriorB + (1/2)*sum(sum((x-repmat(mu, xLength, 1)).^2));

logPriorA = LogInverseGamma(sigma, alphaPriorA, betaPriorA);
logPosteriorA = LogInverseGamma(sigma, alphaPosteriorA, betaPosteriorA);
logPriorB = LogInverseGamma(sigma, alphaPriorB, betaPriorB);
logPosteriorB = LogInverseGamma(sigma, alphaPosteriorB, betaPosteriorB);

priorA = exp(logPriorA);
posteriorA = exp(logPosteriorA);
priorB = exp(logPriorB);
posteriorB = exp(logPosteriorB);

subplot(1,2,1)
hold on;
plot(sigma, priorA, 'r')
plot(sigma, posteriorA, 'b')
set(gca,'fontsize', 15);
xlabel('$\sigma^2$','Interpreter', 'LaTex')
title('$\alpha_a=1$, $\beta_a=1$','Interpreter', 'LaTex')

subplot(1,2,2)
hold on;
plot(sigma, priorB, 'r')
plot(sigma, posteriorB, 'b')
set(gca,'fontsize', 15)
xlabel('$\sigma^2$','Interpreter', 'LaTex')
title('$\alpha_b=10$, $\beta_b=1$','Interpreter', 'LaTex')

%% b)

S=(1/2)*sum(sum((x-repmat(mu, xLength, 1)).^2));

% Model A
s_hat_a=MAP(xLength,S,1,1)

% Model B
s_hat_b=MAP(xLength,S,10,1)

%% c)

% Model A
alpha=1; beta=1; 
alphaPosteriorA = alpha + xLength ;
betaPosteriorA = beta + (1/2)*sum(sum((x-repmat(mu, xLength, 1)).^2));

MA=exp(LogInverseGamma(s_hat_a,alphaPosteriorA,betaPosteriorA));

% Model B
alpha=10; beta=1; 
alphaPosteriorA = alpha + xLength ;
betaPosteriorA = beta + (1/2)*sum(sum((x-repmat(mu, xLength, 1)).^2));

MB=exp(LogInverseGamma(s_hat_a,alphaPosteriorA,betaPosteriorA));

% Bayes factor
K=MA/MB
