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
c_index_calv = strfind(vocab, 'cavalry');
i_calvary=find(not(cellfun('isempty' ,c_index_calv)));
f=zeros(numRuns,1);

for count=1:numRuns
    %disp('Run number')
    %disp(count)
    [idx,C] = kmeans(wordembeddings,k,'Replicates',1);
    cluster_calv=idx(i_calvary);
    
    wordIndices = find(idx == cluster_calv);
    nbr_pairs = length(wordIndices);
    wordPairs = nbr_pairs*(nbr_pairs-1)/2;
    
    [idx2,C2] = kmeans(wordembeddings, k, 'Replicates', 1);
    
    wordPairs2=zeros(k,1);
    for cluster = 1:k
        wordIndices2 = find(idx2 == cluster);
        nbr_pairs2=sum(ismember(wordIndices2, wordIndices, 'rows')); % number of pairs both in C1 and C2
        if nbr_pairs2>=2
            wordPairs2(cluster) = nbr_pairs2*(nbr_pairs2-1)/2;
        else
            nbr_pairs2=0;
        end
        %         disp('Before pairs compute');
        %         wordPairs2 = nchoosek(wordIndices2, 2);
        %         disp('After pairs compute');
        %         disp('Before supercompute');
        %         disp(size(ismember(wordPairs2, wordPairs, 'rows')));
        %         numPairs(cluster, count) = sum(ismember(wordPairs2, wordPairs, 'rows'));
        %         disp('After supercompute');
        %         disp(numPairs(cluster));
        %
    end
    
    f(count)=sum(wordPairs2)/wordPairs;
end

average_fraction=mean(f);