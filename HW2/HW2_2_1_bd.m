%% Cross validation of new_classifier
clear all;
load dataset2.mat

classLength = 1000;

%mu1 = mean(x(1:classLength, :));
%mu2 = mean(x((classLength+1):2*classLength, :));

%yClasses = new_classifier(x', mu1, mu2);

%% Cross validation 

totalSamples = length(x(:,1));
kFold = 5;
numberOfTrials = 200;

classifications1 = zeros(numberOfTrials*kFold, 1);
classifications2 = zeros(numberOfTrials*kFold, 1);

verifications1 = zeros(numberOfTrials*kFold, 1);
verifications2 = zeros(numberOfTrials*kFold, 1);


for i=1:numberOfTrials
    
    sampleIndices = randperm(totalSamples);
    partitionLength = floor(totalSamples/kFold);
    
    samples = zeros(partitionLength, kFold);
    
    for k=1:kFold
        samples(:,k) = sampleIndices(((k-1)*partitionLength +1):k*partitionLength);
        
    end
    
    validationSet = samples(1,:);
    trainingSet = samples(2:end, :);
    
    mu1 = mean(x(1:classLength, :));
    mu2 = mean(x((classLength+1):2*classLength, :));
    
    classifications1((kFold*(i-1)+1):kFold*i, 1) =  ...
        new_classifier(x(validationSet, :)', mu1, mu2)';
    classifications2((kFold*(i-1)+1):kFold*i, 1) = ...
        new_classifier(x(validationSet, :)', mu1, mu2)';
    
    verifications1((kFold*(i-1)+1):kFold*i, 1) = ... 
        classifications1((kFold*(i-1)+1):kFold*i, 1) == y(validationSet);
    verifications2((kFold*(i-1)+1):kFold*i, 1) = ... 
        classifications2((kFold*(i-1)+1):kFold*i, 1) == y(validationSet);
    
end
%%
[classDist1, types1] = hist(verifications1, unique(verifications1));
[classDist2, types2] = hist(verifications2, unique(verifications2));
 
subplot(1,2,1)
hist(verifications1, unique(verifications1));
title('Classicication of number 1 vs 2', 'Interpreter', 'latex')
subplot(1,2,2)
hist(verifications2, unique(verifications2));
title('Classicication of number 1 vs 2', 'Interpreter', 'latex')


