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

%% 2.2 b)

nbr_images=length(data(1,:,1));
var_arr_5=zeros(nbr_images,32);
var_arr_8=zeros(nbr_images,32);

for n=1:nbr_images
    
    data_scale5=data(:,n,5)/255; % Scaling the pixels to range [0,1] for images of digit 5
    data_scale8=data(:,n,8)/255; % Scaling the pixels to range [0,1] for images of digit 8

    arr5=zeros(32,1);
    arr8=zeros(32,1);
    for i=1:32
        arr5(i,1) = var(data_scale5(i:(i+15))); % Variance of each row and column of an image of digit 5
        arr8(i,1) = var(data_scale8(i:(i+15))); % Variance of each row and column of an image of digit 8
    end
    
    var_arr_5(n,:) = arr5;
    var_arr_8(n,:) = arr8;
end

% os�ker p� detta
mu5=mean(var_arr_5);
mu8=mean(var_arr_8);
%%

classifications5 = new_classifier(var_arr_5', mu5, mu8);
classifications8 = new_classifier(var_arr_8', mu8, mu5);

%[classDist5, types5] = hist(classifications5, unique(classifications5));
%[classDist8, types8] = hist(classifications8, unique(classifications8));
subplot(1,2,1)
hist(classifications5, unique(classifications5));
subplot(1,2,2)
hist(classifications8, unique(classifications8));