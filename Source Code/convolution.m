function resultImg = convolution(img, mask)
% Programmer: Rajesh
% Time: 12/23/2012
% Function: Convolve an image.
[m n] = size(mask);
m = (m - 1) / 2;
n = (n - 1) / 2;
[M N D] = size(img);
paddedImg = zeros(M + 2 * m, N + 2 * n, D);
paddedImg(1 + m : M + m, 1 + n : N + n, :) = img;
resultImg = zeros(M, N, D);
mask = rot90(mask, 2);

for x = 1 : M
    for y = 1 : N
        for z = 1 : D
            resultImg(x, y, z) = sum(sum(paddedImg(x : x + 2 * m, y : y + 2 * n, z)...
                .* mask));
        end
    end
end