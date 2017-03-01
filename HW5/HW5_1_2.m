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
numPairsInitial = zeros(numRuns, 1);
numPairs = zeros(k, numRuns);
% This one will take a while
for count=1:numRuns
    disp('Run number')
    disp(count)
    [idx,C] = kmeans(wordembeddings,k,'Replicates',1);
    c_index_calv = strfind(vocab, 'cavalry');
    i_calvary=find(not(cellfun('isempty' ,c_index_calv)));
    cluster_calv=idx(i_calvary);
    
    wordIndices = find(idx == cluster_calv);
    wordPairs = nchoosek(wordIndices, 2);
    numPairsInitial(count) = length(wordPairs);
    
    [idx2,C2] = kmeans(wordembeddings, k, 'Replicates', 1);
    
    for cluster = 1:k
        
        wordIndices2 = find(idx2 == cluster);
        disp('Before pairs compute');
        wordPairs2 = nchoosek(wordIndices2, 2);
        disp('After pairs compute');
        disp('Before supercompute');
        disp(size(ismember(wordPairs2, wordPairs, 'rows')));
        numPairs(cluster, count) = sum(ismember(wordPairs2, wordPairs, 'rows'));
        disp('After supercompute');
        disp(numPairs(cluster));
        
    end
end

fVec = sum(numPairs)./numPairsInitial';
fMean = mean(fVec);

%%
numSamples = 1000;
[~, dims] = size(wordembeddings);
projDims = 2;
sampleIndices = randsample(numSamples, numSamples);
wordSample = vocab{sampleIndices};
wordCoords = wordembeddings(sampleIndices,:);
wordCluster = idx(sampleIndices);

projectedPoints = tsne(wordCoords, [], projDims, dims, 30);
%%
hold on
for plotCluster =1:k
    scatter(projectedPoints(wordCluster == plotCluster, 1), ...
        projectedPoints(wordCluster == plotCluster, 2))
end