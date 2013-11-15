function resultImg = reduceColorResolution(img)
% Programmer: Rajesh
% Time: 12/23/2012
% Function: Reduce the color level of the input image by stepSize.
resultImg = rgb2hsv(img);
resultImg(:, :, 1) = round(resultImg(:, :, 1) * 63) / 63;
        