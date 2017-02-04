%% Plot of data
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

%% 2.2 b)

nbr_images=length(data(1,:,1));
var_arr_5=zeros(32,nbr_images);
var_arr_8=zeros(32,nbr_images);
for n=1:nbr_images
    
    data_scale5=data(:,n,5)/255; % Scaling the pixels to range [0,1] for images of digit 5
    data_scale8=data(:,n,8)/255; % Scaling the pixels to range [0,1] for images of digit 8
    
    arr5=zeros(32,1);
    arr8=zeros(32,1);
    for i=1:32
        arr5(i)=var(data_scale5(i:(i+15))); % Variance of each row and column of an image of digit 5
        arr8(i)=var(data_scale8(i:(i+15))); % Variance of each row and column of an image of digit 8
    end
    var_arr_5(:,n)=arr5;
    var_arr_8(:,n)=arr8;
end

mu5=mean(var_arr_5');
mu8=mean(var_arr_8');
%

classifications5 = new_classifier(var_arr_5, mu5, mu8);

classifications8 = new_classifier(var_arr_8, mu8, mu5);

[classDist5, types5] = hist(classifications5, unique(classifications5));
[classDist8, types8] = hist(classifications8, unique(classifications8));


%% Cross validation

totalSamples = length(data(1,:,1));
kFold = 5;
numberOfTrials = 100;
error5=0; error8=0;

classifications5 = zeros(numberOfTrials*kFold, 1);
classifications8 = zeros(numberOfTrials*kFold, 1);


for i=1:numberOfTrials
    
    sampleIndices = randperm(totalSamples);
    partitionLength = floor(totalSamples/kFold);
    
    samples = zeros(partitionLength, kFold);
    
    for k=1:kFold
        samples(:,k) = sampleIndices(((k-1)*partitionLength +1):k*partitionLength);
        
    end
    
    testSet5=data(:,samples(:,k),5);
    train=samples;
    train(:,k)=[];
    trainSet5=data(:,train,5);
    
    testSet8=data(:,samples(:,k),8);
    train=samples;
    train(:,k)=[];
    trainSet8=data(:,train,8);
    
    nbr_images=length(trainSet5);
    var_arr_5_train=zeros(32,nbr_images);
    var_arr_8_train=zeros(32,nbr_images);
    for n=1:nbr_images
        
        data_scale5_train=trainSet5(:,n)/255; % Scaling the pixels to range [0,1] for images of digit 5
        data_scale8_train=trainSet8(:,n)/255; % Scaling the pixels to range [0,1] for images of digit 8
        
        arr5=zeros(32,1);
        arr8=zeros(32,1);
        for j=1:32
            arr5(j)=var(data_scale5_train(j:(j+15))); % Variance of each row and column of an image of digit 5
            arr8(j)=var(data_scale8_train(j:(j+15))); % Variance of each row and column of an image of digit 8
        end
        var_arr_5_train(:,n)=arr5;
        var_arr_8_train(:,n)=arr8;
    end
    
    mu5_train=mean(var_arr_5_train');
    mu8_train=mean(var_arr_8_train');
    
    
    %%%%%%%%%%%%%%%%%%%%%%%
    nbr_images=length(testSet5(1,:));
    var_arr_5_test=zeros(32,nbr_images);
    var_arr_8_test=zeros(32,nbr_images);
    for n=1:nbr_images
        data_scale5_val=testSet5(:,n)/255; % Scaling the pixels to range [0,1] for images of digit 5
        data_scale8_val=testSet8(:,n)/255; % Scaling the pixels to range [0,1] for images of digit 8
        
        arr5=zeros(32,1);
        arr8=zeros(32,1);
        for j=1:32
            arr5(j)=var(data_scale5_val(j:(j+15))); % Variance of each row and column of an image of digit 5
            arr8(j)=var(data_scale8_val(j:(j+15))); % Variance of each row and column of an image of digit 8
        end
        var_arr_5_test(:,n)=arr5;
        var_arr_8_test(:,n)=arr8;
    end
    %%%%%%%%%%%%%%
    
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
%%
[classDist5, types5] = hist(classifications5, unique(classifications5));
[classDist8, types8] = hist(classifications8, unique(classifications8));

subplot(1,2,1)
hist(classifications5, unique(classifications5));
title('Classicication of number 5 vs 8', 'Interpreter', 'latex')
subplot(1,2,2)
hist(classifications8, unique(classifications8));
title('Classicication of number 8 vs 5', 'Interpreter', 'latex')

