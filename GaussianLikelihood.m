function likelihood = GaussianLikelihood( x, mu, sigma )

xLength = length(x);

deviationSum = sum(sum((x-repmat(mu, xLength, 1)).^2));

likelihood = 1/(2*pi*sigma^2)*exp(-deviationSum/(2*sigma^2));

end

