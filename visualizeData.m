load('tweetData.mat')
data = data

plotOptions = ['ro'; 'bo'; 'k+'; 'm+'; 'g*'; 'c*'];

figure(1)
hold on
Y = doTSNE(data);
for i = 0:5
    classIndices = labels == i;
    points = Y(classIndices, :);
    plot(points(:, 1), points(:, 2), plotOptions(i+1, :))
end