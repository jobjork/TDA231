%% 2.1 d) cross-validation of b)

totalSamples = length(y);
kFold = 5;
sampleIndices = randperm(totalSamples);
partitionLength = floor(totalSamples/kFold);

samples = zeros(partitionLength, kFold);

for k=1:kFold
    samples(:,k) = sampleIndices(((k-1)*partitionLength +1):k*partitionLength);
end

%%
tot_error=zeros(1,kFold);

for k=1:kFold
    testX=x(samples(:,k),:);
    samp_train=samples;
    samp_train(:,k)=[];
    trainX=x(samp_train,:);
    trainY=y(samp_train,:);

    error=zeros(1,length(testX));
    for n=1:length(testX)
        [P1,P2,Y]=sph_bayes(testX(n,:),trainX,trainY);
        error(n)=Y-y(samples(n,k));
    end
    tot_error(k)=mean(error);

end
tot_error