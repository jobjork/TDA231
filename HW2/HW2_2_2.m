%% Plot of data
load dataset2.mat
x1=x(y==1,:);
x2=x(y==-1,:);
plot3(x1(:,1),x1(:,2),x1(:,3),'r*','DisplayName','$y=1$')
hold on
plot3(x2(:,1),x2(:,2),x2(:,3),'bo','DisplayName','$y=-1$')
set(gca,'fontsize', 15);
xlabel('$x_1$','Interpreter', 'LaTex')
ylabel('$x_2$','Interpreter', 'LaTex')
zlabel('$x_3$','Interpreter', 'LaTex')
h=legend('show')
set(h,'Interpreter','latex')
%% 2.1 d) cross-validation of b)

totalSamples = length(y);
kFold = 5;
error=0;
B=1; % Number of iterations

for b=1:B
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
            if Y~=y(samples(n,k))
                error=error+1;
            end
        end
    end
    
end
TOTAL_ERROR=error/(partitionLength*k*B)

%% Cross validation 2.2 b)
load digits.mat
totalSamples = length(data(1,:,1));
kFold = 5;
numberOfTrials = 1;
error5=0; error8=0;

for i=1:numberOfTrials
    
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
    
    mu5_train=mean(var_arr_5_train');
    mu8_train=mean(var_arr_8_train');
    %
    
    % Test variances
    nbr_images=length(testSet5(1,:));
    var_arr_5_test=zeros(32,nbr_images);
    var_arr_8_test=zeros(32,nbr_images);
    for n=1:nbr_images
        var_arr_5_test(:,n)=var_array(testSet,n,5);
        var_arr_8_test(:,n)=var_array(testSet,n,8);
    end
    %
    
    for b=1:length(var_arr_5_test)
        
        if new_classifier(var_arr_5_test(:,b), mu5_train, mu8_train)~=1
            error5=error5+1;
        elseif new_classifier(var_arr_8_test(:,b), mu8_train, mu5_train)~=1
            error8=error8+1;
        end
    end
end

Error5=error5/(numberOfTrials*length(var_arr_5_test)*kFold)
Error8=error8/(numberOfTrials*length(var_arr_5_test)*kFold)