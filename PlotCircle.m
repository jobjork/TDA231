function circlePlot = PlotCircle(origin, radius)
hold on;

xCenter = origin(1);
yCenter = origin(2);

angle = linspace(0, 2*pi, 1000);

xCoord = radius * cos(angle) + xCenter;
yCoord = radius * sin(angle) + yCenter;
circlePlot = plot(xCoord, yCoord);

end

