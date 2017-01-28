function gammaOutput = InverseGamma(s, alpha, beta)

gammaOutput = beta^alpha/gamma(alpha)*s.^-(alpha + 1).*exp(-beta./s);

end

