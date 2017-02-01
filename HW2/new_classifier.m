function [Ytest] = new_classifier(Xtest, mu1, mu2)
% TODO: How to handle when f(x)=0?
b = 0.5*(mu1 + mu2);

f = @(x) sign((mu1 - mu2)'*(x - b)/norm(mu1 - mu2, 2));

Ytest = f(Xtest);

end