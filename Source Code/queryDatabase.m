function rank = queryDatabase(queryPath, rgbHiss)
%
% Flow:
%     1. Read query
%     2. Resize, blur, convert, and quantize the queried image
%     3. Fetch the feature vector of the image
%     4. Calculate the distances between the querying feature vector and
%        the feature vectors in the feature-base and then rank the result
%     5. Output the top 100 ranked image by their names
% Assumption:
%     Current directory is './Image Databse'
%

if strcmp(queryPath, '') == 1
    fileName = input('Enter the full name of the query image: ', 's');
    fid = fopen(fileName);
    while fid == -1
        disp('Cannot find the image file!');
        fileName = input('Enter the full name of the query image: ', 's');
        fid = fopen(fileName);
    end
    fclose(fid);
else
    fileName = input('Enter the name of the query image (including extension): ', 's');
    fileName = strcat(queryPath, fileName);
    fid = fopen(fileName);
    while fid == -1
        disp('Cannot find the image file!');
        fileName = input('Enter the name of the query image (including extension): ', 's');
        fileName = strcat(queryPath, fileName);
        fid = fopen(fileName);
    end
    fclose(fid);
end

img = imread(fileName);
qImg = quantizeRGB(img, 6);
rgbHis = computeRGBHis(qImg, 216);

distances = zeros(1000, 1);
for i = 1 : 1000
    distances(i) = 0.5 * vectorDistance(rgbHis(:, 1) + rgbHis(:, 2), rgbHiss(:, 1, i) + rgbHiss(:, 2, i))...
            + 0.5 * vectorDistance(rgbHis, rgbHiss(:, :, i));
end

[sortedResult, rank] = sort(distances);