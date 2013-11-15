function accuracies = getResultAccess(base, queryPath, rgbHiss)
%
% Description:
%     assessing the performance of this CBIR engine
% Input Parameter:
%     base - the base index value
%     queryPath - the path to the testing images
% Output Parameters:
%     accuracies - the accuracies of the 100 tested images
% Assumption:
%     Current directory is './Image Databse'
%

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