%% a)
clf;
load 'dataset1.mat';

mu = mean(x);
sigma = linspace(0.01, 4, 1000);
maxSigma = max(sigma);


xLength = length(x);
alphaPrior = 1;
betaPrior = 1;

alphaPosterior = alphaPrior + xLength ;
betaPosterior = betaPrior + (1/2)*sum(sum((x-repmat(mu, xLength, 1)).^2));

logPrior = LogInverseGamma(sigma, alphaPrior, betaPrior);
logPosterior = LogInverseGamma(sigma, alphaPosterior, betaPosterior);

hold on;
plot(sigma, exp(logPrior), 'r')
plot(sigma, exp(logPosterior), 'g')

integral(@(x) exp(LogInverseGamma(x, alphaPosterior, betaPosterior)), 1e-5, Inf)

%% b)

S=(1/2)*sum(sum((x-repmat(mu, xLength, 1)).^2));

% Model A
s_hat_a=MAP(xLength,S,1,1)

% Model B
s_hat_b=MAP(xLength,S,10,1)

%% c)

% Model A
alpha=1; beta=1; 
alphaPosterior = alpha + xLength ;
betaPosterior = beta + (1/2)*sum(sum((x-repmat(mu, xLength, 1)).^2));

MA=exp(LogInverseGamma(s_hat_a,alphaPosterior,betaPosterior));

% Model B
alpha=10; beta=1; 
alphaPosterior = alpha + xLength ;
betaPosterior = beta + (1/2)*sum(sum((x-repmat(mu, xLength, 1)).^2));

MB=exp(LogInverseGamma(s_hat_a,alphaPosterior,betaPosterior));

% Bayes factor
K=MA/MB
