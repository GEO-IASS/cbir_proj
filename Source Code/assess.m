function [ma, sd, accuracies] = assess(base, queryPath, rgbHiss)
%
% Description:
%     assessing the performance of this CBIR engine
% Input Parameter:
%     base - the base index value
%     queryPath - the path to the testing images
% Output Parameters:
%     ma - mean accuracy
%     sd - standard deviation of accuracies
%     accuracies - the accuracies of the 100 tested images
% Assumption:
%     Current directory is './Image Databse'
%

if strcmp(queryPath, '') == 0
    disp(sprintf(strcat('Experiment is going to be performed.\n',...
        'If you want to use the default path for queries for this experiment,\n',...
        'make sure that directory contains all the 1000 sample images.')));

    choice = input('Use the default path for queries? (Y/N): ', 's');
end

if strcmp(queryPath, '') == 1 || strcmp(choice, 'y') == 0 && strcmp(choice, 'Y') == 0
    queryPath = input('Enter the path to the query images (the 1000 sample images): ', 's');
    while isempty(dir(queryPath)) == 1 || isdir(queryPath) == 0
        disp('Invalid Path!');
        queryPath = input('Enter the path to the query images (the 1000 sample images): ', 's');
    end
    if queryPath(length(queryPath)) ~= '\'
        queryPath = strcat(queryPath, '\');
    end
end

accuracies = zeros(100, 1);
hitCount = 1;

for i = base + 1 : base + 100
    img = imread(strcat(queryPath, strcat(num2str(i - 1), '.jpg')));
    qImg = quantizeRGB(img, 6);
    rgbHis = computeRGBHis(qImg, 216);
    
    distances = zeros(1000, 1);
    for j = 1 : 1000
        distances(j) = 0.5 * vectorDistance(rgbHis(:, 1) + rgbHis(:, 2), rgbHiss(:, 1, j) + rgbHiss(:, 2, j))...
            + 0.5 * vectorDistance(rgbHis, rgbHiss(:, :, j));
    end
    [sortedResult, index] = sort(distances);
    
    for j = 1 : 1000
        if index(j) >= base + 1 && index(j) <= base + 100
            accuracies(i - base) = accuracies(i - base) + hitCount / j;
            hitCount = hitCount + 1;
        end
    end
    
    hitCount = 1;
end

accuracies = accuracies / 100;
ma = sum(accuracies) / size(accuracies, 1);
sd = sqrt(sum((accuracies - ma).^2) / size(accuracies, 1));