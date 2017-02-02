%% Code for assignment 2.2 a)

load digits.mat

mu5 = mean(data(:, :, 5)');
mu8 = mean(data(:, :, 8)');

classifications5 = new_classifier(data(:,:,5), mu5, mu8);

classifications8 = new_classifier(data(:,:,8), mu8, mu5);

[classDist5, types5] = hist(classifications5, unique(classifications5));
[classDist8, types8] = hist(classifications8, unique(classifications8));

%% Cross validation 

totalSamples = length(data(1,:,1));
kFold = 5;
numberOfTrials = 200;

classifications5 = zeros(numberOfTrials*kFold, 1);
classifications8 = zeros(numberOfTrials*kFold, 1);


for i=1:numberOfTrials
    
    sampleIndices = randperm(totalSamples);
    partitionLength = floor(totalSamples/kFold);
    
    samples = zeros(partitionLength, kFold);
    
    for k=1:kFold
        samples(:,k) = sampleIndices(((k-1)*partitionLength +1):k*partitionLength);
        
    end
    
    validationSet = samples(1,:);
    trainingSet = samples(2:end, :);
    
    mu5 = mean(data(:, trainingSet', 5)');
    mu8 = mean(data(:, trainingSet', 8)');
    
    classifications5((kFold*(i-1)+1):kFold*i, 1) = new_classifier(data(:,validationSet,5), mu5, mu8);
    classifications8((kFold*(i-1)+1):kFold*i, 1) = new_classifier(data(:,validationSet,8), mu8, mu5);
    
end
%%
[classDist5, types5] = hist(classifications5, unique(classifications5));
[classDist8, types8] = hist(classifications8, unique(classifications8));
 
subplot(1,2,1)
hist(classifications5, unique(classifications5));
title('Classicication of number 5 vs 8', 'Interpreter', 'latex')
subplot(1,2,2)
hist(classifications8, unique(classifications8));
title('Classicication of number 8 vs 5', 'Interpreter', 'latex')
