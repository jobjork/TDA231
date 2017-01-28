function logInverseGammaOutput = LogInverseGamma(s, alpha, beta)

logInverseGammaOutput = alpha*log(beta) - log(gamma(alpha)) - ...
    (alpha + 1).*log(s) - beta./s;

end

