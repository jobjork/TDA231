%% 2.2 a) Classification error rate for new_classifier
load digits.mat

mu5 = mean(data(:, :, 5)');
mu8 = mean(data(:, :, 8)');

classifications5 = new_classifier(data(:,:,5), mu5, mu8);
classifications8 = new_classifier(data(:,:,8), mu8, mu5);

[classDist5, types5] = hist(classifications5, unique(classifications5));
[classDist8, types8] = hist(classifications8, unique(classifications8));

newClError5 = classDist5(1)/length(data(1,:,1));
newClError8 = classDist8(1)/length(data(1,:,1));
averageNewClError = (newClError5 + newClError8)/2;

%% 2.2.c) Cross validation of new_classifier with elements in range [0, 255]
load digits.mat
totalSamples = length(data(1,:,1));
kFold = 5;
partitionLength = floor(totalSamples/kFold);

classifications5 = zeros(partitionLength, 1);
classifications8 = zeros(partitionLength, 1);


sampleIndices = randperm(totalSamples);
partitionLength = floor(totalSamples/kFold);

validationSet = sampleIndices(1:partitionLength);
trainingSet = sampleIndices(partitionLength+1:end);

mu5 = mean(data(:, trainingSet(1:end), 5)');
mu8 = mean(data(:, trainingSet(1:end), 8)');

classifications5(:, 1) ...
    = new_classifier(data(:,validationSet,5), mu5, mu8);
classifications8(:, 1) ...
    = new_classifier(data(:,validationSet,8), mu8, mu5);

[classDist5, types5] = hist(classifications5, unique(classifications5));
[classDist8, types8] = hist(classifications8, unique(classifications8));

newClError5 = classDist5(1)/partitionLength;
newClError8 = classDist8(1)/partitionLength;
averagenewClError = (newClError5 + newClError8)/2;

%% 2.2.c) Cross validation of new_classifier with variances in the feature vector

load digits.mat
totalSamples = length(data(1,:,1));
kFold = 5;
newClError5 = 0; 
newClError8 = 0;
bayesError5 = 0; 
bayesError8 = 0;

sampleIndices = randperm(totalSamples);
partitionLength = floor(totalSamples/kFold);
validationSample = sampleIndices(1:partitionLength);

trainingSample = sampleIndices(partitionLength+1:totalSamples);

validationSet = data(:,validationSample,:);
trainingSet = data(:,trainingSample,:);
numTrainingImages = length(trainingSet);

% Training variances
var_arr_5_train=zeros(32,numTrainingImages);
var_arr_8_train=zeros(32,numTrainingImages);

for n=1:numTrainingImages
    var_arr_5_train(:,n)=var_array(trainingSet,n,5);
    var_arr_8_train(:,n)=var_array(trainingSet,n,8);
end

mu5_train = mean(var_arr_5_train');
mu8_train = mean(var_arr_8_train');

% Test variances
numValidationImages=length(validationSet(1,:,1));
var_arr_5_test=zeros(32,numValidationImages);
var_arr_8_test=zeros(32,numValidationImages);

for n=1:numValidationImages
    var_arr_5_test(:,n) = var_array(validationSet,n,5);
    var_arr_8_test(:,n) = var_array(validationSet,n,8);
end

for b=1:numValidationImages
    
    if new_classifier(var_arr_5_test(:,b), mu5_train, mu8_train)~=1
        newClError5 = newClError5 + 1;
    elseif new_classifier(var_arr_8_test(:,b), mu8_train, mu5_train)~=1
        newClError8 = newClError8 + 1;
    end
    
    % 2.2.d) Classification with a multivariate Gaussian classifier
    % Will yield a lower classification error than 
    if MultivariateGaussian(var_arr_5_test(:,b)', var_arr_5_train', var_arr_8_train')~=1
        bayesError5 = bayesError5 + 1;
    end
    
    if MultivariateGaussian(var_arr_8_test(:,b)', var_arr_8_train', var_arr_5_train')~=1
        bayesError8 = bayesError8 + 1;
    end
end

averagenewClError5 = newClError5/partitionLength;
averagenewClError8 = newClError8/partitionLength;
averagenewClError = (averagenewClError5 + averagenewClError8)/2; 

averageSphBayesError5 = bayesError5/partitionLength;
averageSphBayesError8 = bayesError8/partitionLength;
averageSphBayesError = (averageSphBayesError5 + averageSphBayesError8)/2; 