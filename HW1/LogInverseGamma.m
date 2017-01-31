function logInverseGammaOutput = LogInverseGamma(s, alpha, beta)
% Logarithm funcion of the Inverse-Gamma probability density function 
logVal1 = alpha*log(beta);
logVal2 = -(alpha + 1).*log(s);
logVal3 = -beta./s;

logInverseGammaOutput = logVal1 + logVal2 + logVal3 - gammaln(alpha);


end

