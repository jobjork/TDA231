%% Problem 1.2 a)
clear all
load medium_100_10k.mat;
k=10;
nbr_closest_words=10;
[idx,C,sumd,D] = kmeans(wordembeddings,k);

[sorted, index]=sort(D,'ascend');

closest_index=index(1:nbr_closest_words,:);

centroid_words = cell(nbr_closest_words,k);

for i=1:k
    for j=1:nbr_closest_words
    centroid_words{i,j}=vocab{closest_index(i,j)};
    end
end

%% b)
k=10;
numRuns = 10;
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
