%% Olof Ekborg, Johan Björk
load dataset1.mat;
% x denotes the vector of measurements loaded from dataset1.

% a)

dimension = length(x(1,:));
numMeasurements = length(x);

MLEmu = mean(x);
MLEVariance = sum(sum((x-repmat(mu, 1000, 1)).^2))/(dimension*numMeasurements);


