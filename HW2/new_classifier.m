function [Ytest] = new_classifier(Xtest, mu1, mu2)

b = 0.5*(mu1 + mu2);
vectorLength = length(Xtest(1,:));
Ytest = sign(((mu1 - mu2)*(Xtest' - repmat(b, vectorLength, 1))')/norm(mu1 - mu2, 2));

end