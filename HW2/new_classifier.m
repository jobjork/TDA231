function [Ytest] = new_classifier(Xtest, mu1, mu2)
% TODO: How to handle when f(x)=0?
b = 0.5*(mu1 + mu2);

Ytest = sign(((mu1 - mu2)*(Xtest - repmat(b, 1100, 1)'))/norm(mu1 - mu2, 2));

end