function databaseConstruction()
%
% Flow:
%     1. Resize images
%     2. Blur images
%     3. Convert images to images of HSV color model
%     4. Quantize the hue(H) component of images
%     5. Calculate the hue-histogram has the feature vector for an iamge
%     6. Store the hue-histograms of all images in a binary file
%

% Get path to image set from user
inputPath = input('Enter the path to the image set (the set of the 1000 sample images): ', 's');
while isempty(dir(inputPath)) == 1 || isdir(inputPath) == 0
    disp('Invalid Path!');
    inputPath = input('Enter the path to the image set (the set of the 1000 sample images): ', 's');
end
if inputPath(length(inputPath)) ~= '\'
    inputPath = strcat(inputPath, '\');
end

% Create a folder to hold the newly constructed database
mkdir('D:\MART\Image Database');
cd('D:\MART\Image Database');

% Database data
% autocorrelograms - the autocorrelograms of the 1000 images
% gramss - the saturation correlograms of the 1000 images
rgbHiss = zeros(216, 2, 1000);

% Scan all the 1000 images
list = dir(inputPath);
for i = 3 : length(list)
   if ~isempty(findstr(list(i).name, 'jpg'))
       fileName = strcat(inputPath, list(i).name);
       
       % Read an image
       img = imread(fileName);
       
       % Change it to HSV domain
       qImg = quantizeRGB(img, 6);
       % Get the index of the image
       [token, remain] = strtok(list(i).name, '.');
       % Calculate the autocorrelogram and the saturation correlogram of
       % the image
       rgbHiss(:, :, str2double(token) + 1) = computeRGBHis(qImg, 216);
   end
end

% Write the database data to a binary file for future use
fid = fopen('Feature Base.bin', 'w');
for i = 1 : 1000
    fwrite(fid, rgbHiss(:, :, i), 'double');
end
fclose(fid);