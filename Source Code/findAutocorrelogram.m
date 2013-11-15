function gram = findAutocorrelogram(qImg, m, d, his)
%
% Description: find the autocorrelogram and saturation correlogram of an
%     image.
% Input Parameters:
%     hsvImg - an image represented using HSV color model
%     m - the number of color used
%     d - upper bound distance
%

% Data declaration
% Autocorrelogram and saturation correlogram
gram = zeros(m, d);
% Image size
[M N] = size(qImg);

% Main calculation - computational intensity O(M * N * d)
for x = 1 : M
    for y = 1 : N
        for k = 1 : d
            % Left edge
            if y - k >= 1
                for i = x - k : x + k
                    if i >= 1 && i <= M
                        if qImg(x, y) == qImg(i, y - k)
                            gram(qImg(x, y) + 1, k)...
                                = gram(qImg(x, y) + 1, k) + 1 / (8 * k);
                        end
                    end
                end
            end
            % Right edge
            if y + k <= N
                for i = x - k : x + k
                    if i >= 1 && i <= M
                        if qImg(x, y) == qImg(i, y + k)
                            gram(qImg(x, y) + 1, k)...
                                = gram(qImg(x, y) + 1, k) + 1 / (8 * k);
                        end
                    end
                end
            end
            % Top
            if x - k >= 1
                for j = y - k + 1 : y + k - 1
                    if j >= 1 && j <= N
                        if qImg(x, y) == qImg(x - k, j)
                            gram(qImg(x, y) + 1, k)...
                                = gram(qImg(x, y) + 1, k) + 1 / (8 * k);
                        end
                    end
                end
            end
            % Bottom
            if x + k <= M
                for j = y - k + 1 : y + k - 1
                    if j >= 1 && j <= N
                        if qImg(x, y) == qImg(x + k, j)
                            gram(qImg(x, y) + 1, k)...
                                = gram(qImg(x, y) + 1, k) + 1 / (8 * k);
                        end
                    end
                end
            end
        end
    end
end

for i = 1 : m
    if his(i) ~= 0
        gram(i, :) = gram(i, :) / his(i);
    end
end