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
[idx,C] = kmeans(wordembeddings,k,'Replicates',1);
c_index_calv = strfind(vocab, 'cavalry');
i_calvary=find(not(cellfun('isempty' ,c_index_calv)));
cluster_calv=idx(i);

wordIndices = find(idx == cluster_calv);

wordPairs = nchoosek(wordIndices, 2);

[idx2,C2] = kmeans(wordembeddings, k, 'Replicates', 1);

for cluster = 1:k
   
    wordIndices2 =  find(idx == k);
    wordPairs2 = nchoosek(wordIndices2, 2);
    
    numPairs = ismember(wordPairs2, wordPairs, 'cols');
    
end



