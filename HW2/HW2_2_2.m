%% 2.2 a) Classification error rate for new_classifier
load digits.mat

mu5 = mean(data(:, :, 5)');
mu8 = mean(data(:, :, 8)');

classifications5 = new_classifier(data(:,:,5), mu5, mu8);
classifications8 = new_classifier(data(:,:,8), mu8, mu5);

[classDist5, types5] = hist(classifications5, unique(classifications5));
[classDist8, types8] = hist(classifications8, unique(classifications8));

error5 = classDist5(1)/length(data(1,:,1));
error8 = classDist8(1)/length(data(1,:,1));
averageError = (error5 + error8)/2;

%% 2.2.c) Cross validation of new_classifier
load digits.mat
totalSamples = length(data(1,:,1));
kFold = 5;
partitionLength = floor(totalSamples/kFold);

classifications5 = zeros(partitionLength, 1);
classifications8 = zeros(partitionLength, 1);


sampleIndices = randperm(totalSamples);
partitionLength = floor(totalSamples/kFold);

samples = zeros(partitionLength, kFold);

for k=1:kFold
    samples(:,k) = sampleIndices(((k-1)*partitionLength +1):k*partitionLength);
    
end

validationSet = samples(:,1);
trainingSet = samples(:, (2:end));

mu5 = mean(data(:, trainingSet(1:end), 5)');
mu8 = mean(data(:, trainingSet(1:end), 8)');

classifications5(:, 1) ...
    = new_classifier(data(:,validationSet,5), mu5, mu8);
classifications8(:, 1) ...
    = new_classifier(data(:,validationSet,8), mu8, mu5);

[classDist5, types5] = hist(classifications5, unique(classifications5));
[classDist8, types8] = hist(classifications8, unique(classifications8));

error5 = classDist5(1)/partitionLength;
error8 = classDist8(1)/partitionLength;
averageError = (error5 + error8)/2;

%% 2.2.c) Cross validation of new_classifier with variances in the feature vector

load digits.mat
totalSamples = length(data(1,:,1));
kFold = 5;
error5=0; error8=0;
bayesError5=0; bayesError8=0;
    
sampleIndices = randperm(totalSamples);
partitionLength = floor(totalSamples/kFold);

samples = zeros(partitionLength, kFold);

for k=1:kFold
    samples(:,k) = sampleIndices(((k-1)*partitionLength +1):k*partitionLength);
end

testSet=data(:,samples(:,k),:);
train=samples;
train(:,k)=[];
trainSet=data(:,train,:);
nbr_images=length(trainSet);

% Training variances
var_arr_5_train=zeros(32,nbr_images);
var_arr_8_train=zeros(32,nbr_images);
for n=1:nbr_images
    var_arr_5_train(:,n)=var_array(trainSet,n,5);
    var_arr_8_train(:,n)=var_array(trainSet,n,8);
end

mu5_train = mean(var_arr_5_train');
mu8_train = mean(var_arr_8_train');

% Test variances
nbr_images=length(testSet(1,:,1));
var_arr_5_test=zeros(32,nbr_images);
var_arr_8_test=zeros(32,nbr_images);

for n=1:nbr_images
    var_arr_5_test(:,n) = var_array(testSet,n,5);
    var_arr_8_test(:,n) = var_array(testSet,n,8);
end

for b=1:length(var_arr_5_test)
    
    if new_classifier(var_arr_5_test(:,b), mu5_train, mu8_train)~=1
        error5 = error5+1;
    elseif new_classifier(var_arr_8_test(:,b), mu8_train, mu5_train)~=1
        error8 = error8+1;
    end
    
    if new_classifier(var_arr_5_test(:,b), mu5_train, mu8_train)~=1
        bayesError5 = bayesError5+1;
    elseif new_classifier(var_arr_8_test(:,b), mu8_train, mu5_train)~=1
        bayesError8 = bayesError8+1;
    end
end

averageError5 = error5/partitionLength;
averageError8 = error8/partitionLength;
averageError = (averageError5 + averageError8)/2; 