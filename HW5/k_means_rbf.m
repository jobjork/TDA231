function [res] = k_means_rbf(data, k)

[n,~] = size(data);

if k>n
    error('Error: k cannot be larger than number of data points');
elseif k<=0
    error('Error: k must be positive')
elseif k==n
    res=1:n;
    return
end

term = false; 
sigma = 0.2;
clusters = floor(k*rand(n,1) + 1);
rbfKernel = @(xm, xn, sigma) exp(-(1/(2*sigma^2))*dot(xm-xn, xm-xn));

kernelMatrix = zeros(n);

for m=1:n
    for l=1:n
        kernelMatrix(m,l) = rbfKernel(data(m,:), data(l,:), sigma);
    end
end

while term == false

    d = zeros(n,k); 
    for i=1:n
        for j=1:k
            N = sum(clusters == j);
            term1 = kernelMatrix(i,i);
            term2 = (2/N)*(clusters==j)'*kernelMatrix(:,i);
            term3 = (1/N^2)*sum(sum((clusters == j).*(clusters == j)'.*kernelMatrix));           
            d(i,j) =  term1 - term2 + term3;

        end
    end
    
    [~, minIndex] = min(d');
    clusterUpdate = minIndex';
    
    if sum(clusterUpdate == clusters) == n
        term = true;
    end
  
    clusters = clusterUpdate;
end

res = clusters;

end
