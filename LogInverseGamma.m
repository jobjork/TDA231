function logInverseGammaOutput = LogInverseGamma(s, alpha, beta)

if alpha <=1
    logInverseGammaOutput = alpha*log(beta) - log(gamma(alpha)) - ...
        (alpha + 1).*log(s) - beta./s;
elseif alpha > 1
    
        logInverseGammaOutput = alpha*log(beta) - log(gamma(1)) + sum(log(1:(alpha -1))) - ...
        (alpha + 1).*log(s) - beta./s;
    
end

end

