function [Ytest] = MultivariateGaussian(Xtest, x1, x2)

mu1 = mean(x1);
Sigma1 = cov(x1);

mu2 = mean(x2);
Sigma2 = cov(x2);

P1 = mvnpdf(Xtest, mu1, Sigma1); % Likelihood that Xtest has label +1
P2 = mvnpdf(Xtest, mu2, Sigma2); % Likelihood that Xtest has label -1

if P1>P2
    Ytest = 1;
else
    Ytest = -1;
end

end