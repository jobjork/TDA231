function [P1, P2, Ytest] = sph_bayes(Xtest,x,y)
p=length(Xtest(1,:)); % Dimension of Xtest 

x1=x(y==1,:); % Training data with label +1
n1=length(x1); % Number of training data with label +1
mu1=mean(x1);
Sigma1=sqrt(sum(sum((x1-repmat(mu1, n1, 1)).^2))/(p*n1))*eye(3);

x2=x(y==-1,:); % Training data with label -1
n2=length(x2); % Number of training data with label -1
mu2=mean(x2);
Sigma2=sqrt(sum(sum((x2-repmat(mu2, n2, 1)).^2))/(p*n2))*eye(3);

L1=mvnpdf(Xtest,mu1,Sigma1); % Likelihood that Xtest has label +1
L2=mvnpdf(Xtest,mu2,Sigma2); % Likelihood that Xtest has label +1

P1=L1/(L1+L2);
P2=L2/(L1+L2);

if P1>P2
    Ytest=1;
else
    Ytest=-1;
end

end

