function resultImg = reduceSpatialResolution (img, destW, destL)
% Programmer: Rajesh
% Time: 10/10/2012
% Function: Reduce the spatial resolution of the input image to the specified size.
s = size (img);
resultImg = zeros (destW, destL, 3);
r = 0 : ceil(s(1) / destW - 1);
c = 0 : ceil(s(2) / destL - 1);
S = ceil(s(1) / destW) * ceil(s(2) / destL);
for i = 1 : destW
    for j = 1 : destL
        resultImg(i, j, :) = sum(sum(img(ceil(i * s(1) / destW) - r,...
            ceil(j * s(2) / destL) - c))) / S;
    end
end