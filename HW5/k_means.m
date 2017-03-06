function [res] = k_means(data, k, tol, iterLimit, numIters)

[n,m] = size(data);

if k > n
    error('Error: k cannot be larger than number of data points');
elseif k  <= 0
    error('Error: k must be positive')
elseif k == n
    res=1:n;
    return
end

minCoords = min(data);
maxCoords = max(data);

mu = (maxCoords-minCoords).*rand(k,m)+minCoords; 
term = false; 
iter = 0;

while term == false
    
    if iterLimit
        iter = iter+1;
    end
    
    squareDistance = zeros(n,k); 
    for i=1:n
        for j=1:k
            squareDistance(i,j) = dot((data(i,:)-mu(j,:)),data(i,:)-mu(j,:));
        end
    end
    
    [~,clusterIndex] = min(squareDistance');
    
    z = zeros(n,k);
    for clusterNumber=1:k
        z(:,clusterNumber) = (clusterIndex == clusterNumber);
    end
    
    muUpdate = z'*data./sum(z)';
    
    if norm(mu - muUpdate,2) < tol % Termination condition
        term = true;
    end
    
    if iterLimit && iter == numIters
        term = true;
    end
    
    mu = muUpdate;
    
end

res = clusterIndex;

end