function [Ytest] = new_classifier(Xtest, mu1, mu2)

b = 0.5*(mu1 + mu2);
Ytest = sign(((mu1 - mu2)*(Xtest - b)')/norm(mu1 - mu2, 2));

end