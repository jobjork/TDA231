%% 2.1 d) cross-validation of b)

totalSamples = length(y);
kFold = 5;
sampleIndices = randperm(totalSamples);
partitionLength = floor(totalSamples/kFold);

samples = zeros(partitionLength, kFold);

for k=1:kFold
    samples(:,k) = sampleIndices(((k-1)*partitionLength +1):k*partitionLength);
end


for k=1:kFold
    test=x(samples(:,k),:);
    train=x(-samples(:,k),:);



