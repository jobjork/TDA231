% a)
load 'dataset1.mat';

mu = mean(x);
sigma = linspace(0, 5, 1000);
xLength = length(x);
alphaPrior = 1;
betaPrior = 1;

alphaPosterior = alphaPrior + xLength;
betaPosterior = betaPrior + (1/2)*sum(sum((x-repmat(mu, xLength, 1)).^2));

logPrior = LogInverseGamma(sigma, alphaPrior, betaPrior);
logPosterior = LogInverseGamma(sigma, alphaPosterior, betaPosterior);



% b)

% c)