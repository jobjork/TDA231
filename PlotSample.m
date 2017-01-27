function [ samplePlot ] = PlotSample(x)
hold on;

[mu, sigma] = sge(x);
numberOfCircles = 3;
numSamples = length(x);

scatter(x(:,1), x(:,2), '.');

pointsOutsideCircle = zeros(numSamples, numberOfCircles);

xCenter = mu(1);
yCenter = mu(2);

angle = linspace(0, 2*pi, 1000);

for k=1:numberOfCircles
    
    for i=1:numSamples
        outside = (x(i, 1) - xCenter)^2 + (x(i,2) - yCenter)^2 > k*sigma;
        if outside
            pointsOutsideCircle(i, k) = 1;
        end
        
    end
    
    xCoord = k*sigma * cos(angle) + xCenter;
    yCoord = k*sigma * sin(angle) + yCenter;
   
    fractionOutside = sum(pointsOutsideCircle(:,k))/numSamples;
    
    set(gca,'fontsize',14)

    plot(xCoord, yCoord, 'DisplayName', strcat('cos(x)' , num2str(k)))    
    
end

    legend('show');

%samplePlot;


end

