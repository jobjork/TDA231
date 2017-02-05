%% 2.1.d) Cross validation of new_classifier and sph_bayes
clear all;
load dataset2.mat

totalSamples = length(y);
kFold = 5;
bayesError=0;
newClError=0;

sampleIndices = randperm(totalSamples);
partitionLength = floor(totalSamples/kFold);
samples = zeros(partitionLength, kFold);

for k=1:kFold
    samples(:,k) = sampleIndices(((k-1)*partitionLength +1):k*partitionLength);
end

for k=1:kFold
    testX=x(samples(:,k),:);
    samp_train=samples;
    samp_train(:,k)=[];
    trainX=x(samp_train,:);
    trainY=y(samp_train,:);
    
    for n=1:partitionLength
        [P1,P2,Y]=sph_bayes(testX(n,:),trainX,trainY);
        Z = new_classifier(testX(n,:),mean(trainX),mean(trainY));
        if Y~=y(samples(n,k))
            bayesError=bayesError + 1;
        end
        
        if Z~=y(samples(n,k))
            newClError = newClError + 1;
        end
        
    end
end

BAYES_ERROR  = bayesError/(partitionLength);
NEW_CL_ERROR = newClError/(partitionLength);