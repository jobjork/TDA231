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
sampleIndices = randperm(1100);
partitionLength = floor(totalSamples/kFold);

samples = zeros(partitionLength, kFold);

for k=1:kFold
    samples(:,k) = sampleIndices(((k-1)*partitionLength +1):k*partitionLength);
    
end

validationSet = samples(1,:);
trainingSet = samples(2:end, :);


mu5 = mean(data(:, trainingSet', 5)');
mu8 = mean(data(:, trainingSet', 8)');
%%
classifications5 = new_classifier(data(:,validationSet,5), mu5, mu8);
classifications8 = new_classifier(data(:,validationSet,8), mu8, mu5);

[classDist5, types5] = hist(classifications5, unique(classifications5));
[classDist8, types8] = hist(classifications8, unique(classifications8));





