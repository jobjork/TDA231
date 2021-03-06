%% 2.1.d) Cross validation of new_classifier and sph_bayes
clear all;
load dataset2.mat

totalSamples = length(y);
kFold = 5;
bayesError=0;
newClError=0;

sampleIndices = randperm(totalSamples);
partitionLength = floor(totalSamples/kFold);
sample= sampleIndices(1:partitionLength);

testX = x(sample,:);
samp_train = sampleIndices(partitionLength+1:totalSamples);
trainX = x(samp_train,:);
trainY = y(samp_train);

for n=1:partitionLength

    [P1,P2,Y]=sph_bayes(testX(n,:),trainX,trainY);
    if Y~=y(sample(n))
        bayesError=bayesError + 1;
    end
    
    Z = new_classifier(testX(n,:),mean(trainX(trainY==1,:)),mean(trainX(trainY==-1,:)));
    if Z~=y(sample(n))
        newClError = newClError + 1;
    end
    
end

BAYES_ERROR  = bayesError/(partitionLength);
NEW_CL_ERROR = newClError/(partitionLength);