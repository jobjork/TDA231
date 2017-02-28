function [res] = k_means(data, k, tol, iterLimit, numIters)

[n,m]=size(data);

if k>n
    error('Error: k cannot be larger than number of data points');
elseif k<=0
    error('Error: kmust be positive')
elseif k==n
    res=1:n;
    return
end

minCoords = min(data);
maxCoords = max(data);

% Intilization of centroids
mu = (maxCoords-minCoords).*rand(k,m)+minCoords; % kxm
term = false; 
iter = 0;

while term == false
    
    if iterLimit
        iter = iter+1;
    end
    
    % Euclidean distances
    d = zeros(n,k); 
    for i=1:n
        for j=1:k
            d(i,j)=dot((data(i,:)-mu(j,:)),data(i,:)-mu(j,:));
        end
    end
    
    [minValue,minIndex] = min(d');
    
    % Assign each data point to closest mu
    z=zeros(n,k);
    for i=1:length(minIndex)
        z(i,minIndex(i))=1;
    end
    
   
    
    % Update mu
    muUpdate= z'*data./sum(z)';
    
    if norm(mu-muUpdate,2) < tol % Termination condition
        term = true;
    end
    
    if iterLimit && iter==numIters
        term=true;
    end
    
    mu=muUpdate;
    
end

res = minIndex;

end

