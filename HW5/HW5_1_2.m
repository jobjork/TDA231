%% Problem 1.2 a)
clear all
load medium_100_10k.mat;
k=10;
[idx,C,sumd,D] = kmeans(wordembeddings,k);

[value,closest] = min(D);

centroid_word = cell(k,1);
for i=1:length(closest)
    centroid_word{i}=vocab{closest(i)};
end

%% b)
k=10;
numRuns = 10;
numPairs = zeros(k, numRuns);

c_index_calv = strfind(vocab, 'cavalry');
i_calvary=find(not(cellfun('isempty' ,c_index_calv)));
f=zeros(numRuns,1);

for count=1:numRuns

    [idx1, C1] = kmeans(wordembeddings,k,'Replicates',1);
    cluster_cav = idx(i_calvary);
    
    wordIndices = find(idx1 == cluster_cav);
    nbr_pairs = length(wordIndices);
    wordPairs = nbr_pairs*(nbr_pairs-1)/2;
    
    [idx2, C2] = kmeans(wordembeddings, k, 'Replicates', 1);
    
    wordPairs2 = zeros(k,1);
    for cluster = 1:k
        wordIndices2 = find(idx2 == cluster);
        % compute number of pairs both in C1 and C2
        nbr_pairs2 = sum(ismember(wordIndices2, wordIndices, 'rows'));
        if nbr_pairs2 >= 2
            wordPairs2(cluster) = nbr_pairs2*(nbr_pairs2-1)/2;
        else
            nbr_pairs2 = 0;
        end

    end
    
    f(count) = sum(wordPairs2)/wordPairs;
end

average_fraction = mean(f);

%% c) Sampling 1000 words for visualization 
numSamples = 1000;
[~, dims] = size(wordembeddings);
projDims = 2;
sampleIndices = randsample(numSamples, numSamples);
wordSample = vocab{sampleIndices};
wordCoords = wordembeddings(sampleIndices,:);
wordCluster = idx(sampleIndices);

projectedPoints = tsne(wordCoords, [], projDims, dims, 30);
%% Plotting the samples
hold on;

for plotCluster = 1:k
    if plotCluster <= 5
    scatter(projectedPoints(wordCluster == plotCluster, 1), ...
        projectedPoints(wordCluster == plotCluster, 2), 'x')
    else
    scatter(projectedPoints(wordCluster == plotCluster, 1), ...
        projectedPoints(wordCluster == plotCluster, 2), '*')        
    end
end

legend({'1','2','3','4','5','6','7','8','9','10'})